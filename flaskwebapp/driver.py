import numpy as np
import logging, sys, json
import timeit as t
import base64
from cntk import load_model, combine
from PIL import Image, ImageOps
from io import BytesIO

LABEL_FILE = 'synset.txt'
MODEL_FILE = 'ResNet_152.model'

logger = logging.getLogger("cntk_svc_logger")
ch = logging.StreamHandler(sys.stdout)
logger.addHandler(ch)


trainedModel = None
mem_after_init = None
labelLookup = None
topResult = 3


def init():
    """ Initialise ResNet 152 model
    """
    global trainedModel, labelLookup, mem_after_init

    start = t.default_timer()

    # Load the model and labels from disk
    with open(LABEL_FILE, 'r') as f:
        labelLookup = [l.rstrip() for l in f]

    # Load model and load the model from brainscript (2nd index and third item)
    trainedModel = load_model(MODEL_FILE)
    trainedModel = combine([trainedModel.outputs[2].owner])
    end = t.default_timer()

    loadTimeMsg = "Model loading time: {0} ms".format(round((end - start) * 1000, 2))
    logger.info(loadTimeMsg)


def run(inputString):
    """ Classify the input using the loaded model
    """
    start = t.default_timer()

    images = json.loads(inputString)
    result = []
    totalPreprocessTime = 0
    totalEvalTime = 0
    totalResultPrepTime = 0

    for base64ImgString in images:
        if base64ImgString.startswith('b\''):
            base64ImgString = base64ImgString[2:-1]
        base64Img = base64ImgString.encode('utf-8')

        # Preprocess the input data
        startPreprocess = t.default_timer()
        decoded_img = base64.b64decode(base64Img)
        img_buffer = BytesIO(decoded_img)

        # Load image with PIL (RGB)
        pil_img = Image.open(img_buffer).convert('RGB')
        pil_img = ImageOps.fit(pil_img, (224, 224), Image.ANTIALIAS)
        rgb_image = np.array(pil_img, dtype=np.float32)

        # Resnet trained with BGR
        bgr_image = rgb_image[..., [2, 1, 0]]
        imageData = np.ascontiguousarray(np.rollaxis(bgr_image, 2))

        endPreprocess = t.default_timer()
        totalPreprocessTime += endPreprocess - startPreprocess

        # Evaluate the model using the input data
        startEval = t.default_timer()
        imgPredictions = np.squeeze(trainedModel.eval({trainedModel.arguments[0]: [imageData]}))
        endEval = t.default_timer()
        totalEvalTime += endEval - startEval

        # Only return top 3 predictions
        startResultPrep = t.default_timer()
        resultIndices = (-np.array(imgPredictions)).argsort()[:topResult]
        imgTopPredictions = []
        for i in range(topResult):
            imgTopPredictions.append((labelLookup[resultIndices[i]], imgPredictions[resultIndices[i]] * 100))
        endResultPrep = t.default_timer()
        result.append(imgTopPredictions)

        totalResultPrepTime += endResultPrep - startResultPrep

    end = t.default_timer()

    logger.info("Predictions: {0}".format(result))
    logger.info("Predictions took {0} ms".format(round((end - start) * 1000, 2)))
    logger.info("Time distribution: preprocess={0} ms, eval={1} ms, resultPrep = {2} ms".format(
        round(totalPreprocessTime * 1000, 2), round(totalEvalTime * 1000, 2), round(totalResultPrepTime * 1000, 2)))

    actualWorkTime = round((totalPreprocessTime + totalEvalTime + totalResultPrepTime) * 1000, 2)
    return (result, 'Computed in {0} ms'.format(actualWorkTime))