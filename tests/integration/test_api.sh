#!/bin/bash
# This script tests model api passed to it
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MODEL_API_URL=$1

# Simple API test
echo "Testing API"
reply=$(curl -s $MODEL_API_URL/version)
if [[ $reply == 2.0 ]]; then
        echo -e "Successfully validated version API call"
else
        echo "Basic API call failed"
        echo "Reply: "$reply
        exit 1
fi

# Testing classification
echo "Testing Classification"
source activate $(whoami)
result=$(python $DIR/classify.py)
source deactivate

echo $result
echo "Finished"
exit 0
