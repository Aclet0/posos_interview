from flask import Flask, request
import pickle
import re
import numpy as np
import json


app = Flask(__name__)


def build_wv_query(query, wv_model):
    prepared_query = get_prepared_query(query)
    cleaned_query_vectorized, empty_vector_list = get_vector_list(prepared_query, wv_model)
    return cleaned_query_vectorized


def get_prepared_query(query):
    prepared_query = re.sub(",|-|'|\.|\?", " ", str(query)).split(" ")
    return prepared_query


def get_vector_list(sentence_splited_list, w2v_model):
    empty_vector_list = []
    vector_list = []
    for index, word_list in enumerate(sentence_splited_list):
        vocab_words = []
        for word in word_list:
            if word in w2v_model.wv.vocab.keys():
                vocab_words.append(w2v_model.wv[word])
        if not vocab_words:
            empty_vector_list.append(index)

        else:
            mean_vect = np.mean(vocab_words, axis=0)
            vector_list.append(mean_vect)
    return vector_list, empty_vector_list


@app.route("/")
def home2(**kwargs):
    #here i need to get the sentence
    query_to_test = request.args.get("query", {})
    # pretraitement on sentence and convert into vect
    filename_wv = '../word2vec_model.sav'
    wv_model = pickle.load(open(filename_wv, 'rb'))
    cleaned_query_vectorized = build_wv_query(query_to_test, wv_model)

    # load svm model
    filename_svm = "../svm_wv_model.sav"
    svm_model = pickle.load(open(filename_svm, 'rb'))
    probas = svm_model.predict_proba(cleaned_query_vectorized[0])
    index = np.argmax(probas)
    probability = probas[0][index]
    # prediction with proba

    predictions = {"intent": str(index), "probability": "%.2f" % probability}
    return json.loads(predictions)


if __name__ == "__main__":
    app.run(debug=True)


