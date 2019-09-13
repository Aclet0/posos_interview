FROM python

ARG user=appuser
ARG group=appuser

RUN groupadd -r ${group}
RUN useradd -g ${group} ${user} -m

RUN chown -R ${user}:${group} /home/${user}

COPY web_app home/${user}  
COPY requirements.txt /home/${user}  
COPY models /home/${user}/models
#COPY svm_wv_model.sav /appuser
#COPY word2vec_model.sav /appuser

ENV PATH="/home/${user}/.local/bin/:${PATH}"

USER ${user} 
WORKDIR /home/${user} 

EXPOSE 5000

RUN pip install --user -r requirements.txt
CMD ["python", "main.py"]


