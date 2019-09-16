# Use the official docker image for python3.7
FROM python:3.7

# Define uid and gid arguments (passed during docker build command)
ARG user=appuser
ARG group=appuser

# Add in the container the group and the user you filled in
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
RUN groupadd -r ${group}
RUN useradd -g ${group} ${user} -m

# Give the created home the proper rights
RUN chown -R ${user}:${group} /home/${user}

COPY data home/appuser/data
COPY models home/appuser/models
COPY tfidf_encodeur.ipynb home/appuser
COPY requirements.txt home/appuser

RUN chown -R ${user}:${group} /home/${user}/models

# Add the user bin path in global PATH
ENV PATH="/home/${user}/.local/bin/:${PATH}"

# Change user
USER appuser

WORKDIR /home/appuser
# Install jupyterlab in container
RUN pip3 install --user jupyterlab
# Install python packages
RUN pip3 install --user -r requirements.txt

# When the container launches, launches a jupyterlab instance
CMD ["jupyter", "lab", "--no-browser", "--notebook-dir='/home/appuser'", "--ip=0.0.0.0", "--log-level='INFO'"]

