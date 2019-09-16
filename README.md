# posos_interview

Project based on following git repo: https://github.com/VincentMatthys/posos_sample

This project is divided in 2 parts:
- One training part which learn how to classify data for training set
- One web application part which served models trained in training part


Train part:

Main code is in a jupyter notebook tfidf_encodeur.ipynb. 

This jupyter notebook is going through different encoders and decoder in order to test different performances.

Finally one word2vec vectorizer is saved and a SVM model is saved, both are located in 'models' folder

Data are retrieved from git based repository and added in a folder 'data'
A trainer.Dockerfile is used to create a docker image containing python and jupyter lab to launch previous jupyter notebook and save trained models


Web application part:

A web application running in flask is located in web_app folder. Goal of this web_app is to serve previous trained model on new queries.

This server is running on port 4002 and has to be contact at /intent 

api.Dockerfile is used to create a docker image containing python and requiered libraries to run flask,
models used by this web app are located in a 'models' folder.

Training part has to run before in order to save trained models.

Train and web app container will share folder 'models' where train can write and read on it whereas web_app can only read.

requirements.txt is containing libraries which need to be installed for training and web app

makefile file is containing 2 rules:
- train: which create a docker image using trainer.Dockerfile and then run a container with volume ./models where jupyter notebook will be running
- api: which create a docker image using api.Dockerfile and then run a container with volume ./models where a Flask app will be running and serving our models


