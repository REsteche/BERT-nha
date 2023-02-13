
# NLP - Intent Classifier Model

This project demonstrates the end-to-end workflow of a NLP project with Noronha, using a fit tuned LLM named BERT to make intent recognition.

All steps required for running this example can be found in its [script](https://github.com/REsteche/intent-clf/blob/master/script.sh).

## Dataset

The dataset used here is [ATIS](https://www.kaggle.com/datasets/hassanamin/atis-airlinetravelinformationsystem), a standard benchmark dataset widely used as an intent classification.  

## Framework features

Those are the key features demonstrated in this example:

- Structured datasets
- Project building
- In-Notebook shortcuts
- Training and deploying
- Routed inference requests
- Fit training of LLM

## Reusability

This example may be reused as a template in other Machine Learning projects by changing some code snippets in these areas:

- [Project setup and CLI actions](https://github.com/noronha-dataops/noronha/tree/master/examples/iris/script.sh)
    - Model files and dataset files definition
    - Names, descriptions and metadata
- [Training notebook](https://github.com/noronha-dataops/noronha/tree/master/examples/iris/notebooks/train.ipynb)
    - Parameter injection cell
    - Dataset loading cell
    - Training cell
- [Inference notebook](https://github.com/noronha-dataops/noronha/tree/master/examples/iris/notebooks/predict.ipynb)
    - Model loading cell
    - Prediction function

## Next steps

- For further commands and usage options, see the [CLI reference](https://noronha-dataops.readthedocs.io/en/latest/reference/cli.html).

- For a better understanding of the relationships between entities (models, versions, trainings, etc...) see the [data model guide](https://noronha-dataops.readthedocs.io/en/latest/guide/data_model.html).

- For running in a more robust configuration set-up or customizing the framework's behaviour, see the [configuration manual](https://noronha-dataops.readthedocs.io/en/latest/guide/configuration.html). 
