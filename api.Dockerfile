FROM python

ARG user=appuser
ARG group=appuser

RUN groupadd -r ${group}
RUN useradd -g ${group} ${user} -m

RUN chown -R ${user}:${group} /home/${user}

COPY web_app home/appuser 
COPY requirements.txt /home/appuser  
COPY models /home/appuser/models

RUN chown -R ${user}:${group} /home/${user}/models
#RUN chown -R ${user}:${group} /home/${user}/web_app

ENV PATH="/home/${user}/.local/bin/:${PATH}"

USER appuser
WORKDIR /home/appuser 

EXPOSE 5000

RUN pip install --user -r requirements.txt
CMD ["python", "main0.py"]


