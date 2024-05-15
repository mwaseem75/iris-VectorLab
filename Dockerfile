ARG IMAGE=intersystemsdc/iris-community:latest
#ARG IMAGE=iris-vectorlab-iris
FROM $IMAGE

USER root
WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp
USER ${ISC_PACKAGE_MGRUSER}

COPY src src
COPY module.xml module.xml
COPY iris.script iris.script
COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

#RUN pip3  install --upgrade pip && pip install --no-cache-dir sentence-transformers


RUN iris start IRIS \
   && iris session IRIS < iris.script \
   && iris stop IRIS quietly

