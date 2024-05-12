# Summary
IRIS-VectorLab is a web application that demonstrates the functionality of Vector Search. 

## Application Layout
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/c71559ae-9ce7-46a3-ab99-1800ab47adbd)

## Features
* Translating Text to Embeddings.
* Inserting VECTOR-typed Data
* Perform Vector Search.
* Demonstrate the difference between normal and vector search

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation 

### Docker (e.g. for dev purposes)

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/mwaseem75/iris-VectorLab.git
```

Open the terminal in this directory and run:

```
$ docker-compose up -d
```

### IPM

Open IRIS for Health installation with IPM client installed. Call in any namespace:

```
USER>zpm "install iris-VectorLab"
```

## Run the Application
Navigate to [http://localhost:32783/csp/fhirlab/index.csp](http://localhost:52773/csp/VectorLab/index.csp) to run the application
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/c5b861ee-4b93-4471-b682-77a086c069fe)


### Load data


### Add data with vector embeddings
Click on the Resources List to view Resource records of connected FHIR Server and further clink on the record itself to view JSON and Human readable details of selected Resource
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/751d7d05-e9e5-4b3d-a7b1-a2c939cc826e)


### Perform Vector Search
To search, type resource in the search field
![image](https://github.com/mwaseem75/iris-fhir-lab/assets/18219467/8903a73b-9558-4700-bde6-557bfc92d923)

Thanks
