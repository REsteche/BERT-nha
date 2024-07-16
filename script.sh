#!/bin/bash

set -x flags="--debug --pretty --skip-questions"

# define a model
nha ${flags} model new \
--name fly-bert-nha \
--desc "NLP classifier for travel information queries" \
--model-file '{"name": "model.pkl", "required": true, "desc": "Classifier saved as pickle", "max_mb": 45}' \
--data-file '{"name": "atis_intents_test.csv"}' \
--data-file '{"name": "atis_intents_train.csv"}' \
--data-file '{"name": "atis_intents.csv"}'
# check it at nha model list, or specify with nha model list | grep ruben

# record a dataset
nha ${flags} ds new \
--name bert-data-v0 \
--model fly-bert-nha \
--details '{"extraction_date": "2023-02-14"}' \
--path ./datasets/
# check it at nha ds list

# create your project
nha ${flags} proj new \
--name air-bert \
--desc "A model to classify airline related queries intentions" \
--home-dir '.' \
--model fly-bert-nha
# check it at nha proj list

# build your project # now it's "dockerized" :)
nha ${flags} proj build \
--from-here
# you can check it here using $ docker images or specify with docker images | grep airplanes  

# note that a docker image has been created for you
docker images noronha/*air-bert*

# and it's also versioned in noronha's database
nha ${flags} bvers list
# nha bvers list will work out too

# Run a Jupyter Notebook for editing and testing your code:
nha ${flags} note --port 30091 --edit --dataset fly-bert-nha:bert-data-v0

# execute your first training (usar 0 --rp e setar o arquivo nha.yaml pra garantir que não vai estourar a máquina)
nha ${flags} train new --rp nha-train \
--name experiment-v1 \
--nb notebooks/train \
--dataset fly-bert-nha:bert-data-v0

# check out which model versions have been produced so far
nha ${flags} movers list

# deploy a model version to homologation
nha ${flags} depl new \
--name homolog \
--nb notebooks/predict \
--port 30052 \
--movers fly-bert-nha:experiment-v1 \
--n-tasks 1 \
&& sleep 10

# test your api (direct call to the service)
curl -X POST \
--data '{"data":"which time is the new york flight arriving?"}' \
-H '{"Content-Type": "application/json"}' \
http://127.0.0.1:30052/predict \
&& echo

# test your api (call through model router)
curl -X POST \
-H 'Content-Type: application/JSON' \
--data 'all flights from baltimore after 6 pm' \
"http://127.0.0.1:30080/predict?project=flowers&deploy=homolog" \
&& echo
