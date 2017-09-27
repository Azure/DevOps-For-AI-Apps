import base64
import json
import logging
import urllib
from io import BytesIO

import requests
import toolz
from PIL import Image, ImageOps

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


TEST_IMAGES ={
'https://www.britishairways.com/assets/images/information/about-ba/fleet-facts/airbus-380-800/photo-gallery/240x295-BA-A380-exterior-2-high-res.jpg':
'n02690373 airliner',
}

def read_image_from(url):
    return toolz.pipe(url,
                      urllib.request.urlopen,
                      lambda x: x.read(),
                      BytesIO)


def to_rgb(img_bytes):
    return Image.open(img_bytes).convert('RGB')


@toolz.curry
def resize(img_file, new_size=(100, 100)):
    return ImageOps.fit(img_file, new_size, Image.ANTIALIAS)


def to_base64(img):
    imgio = BytesIO()
    img.save(imgio, 'PNG')
    imgio.seek(0)
    dataimg = base64.b64encode(imgio.read())
    return dataimg.decode('utf-8')


def to_img(img_url):
    return toolz.pipe(img_url,
                      read_image_from,
                      to_rgb,
                      resize(new_size=(224,224)))


def img_url_to_json(url):
    img_data = toolz.pipe(url,
                          to_img,
                          to_base64)
    return json.dumps({'input':'[\"{0}\"]'.format(img_data)})


if __name__=='__main__':
    logger.info('Starting classifier test')
    headers = {'content-type': 'application/json'}
    for url, label in TEST_IMAGES.items():
        jsonimg = img_url_to_json(url)
        r = requests.post('http://0.0.0.0:88/score', data=jsonimg, headers=headers)
        json_response = r.json()
        logger.info(json_response)
        if json_response['result'][0] != label:
            raise ValueError('The predicted label {} is not the same as {}'.format(json_response['result'][0],label))
        logger.info('CORRECT! {}'.format(json_response['result'][0]))