# Summary
IRIS-VectorLab is a web application that demonstrates the functionality of Vector Search. 

## Application Layout
<img width="868" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/44e53bf4-dc5d-495c-93ab-0d31cda279fe">


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
Navigate to [http://localhost:52773/csp/vectorlab/index.csp](http://localhost:52773/csp/VectorLab/index.csp) to run the application
<img width="868" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/4b9a0a2a-9028-4edf-983d-0835c628716e">



### Load data


### Add data with vector embeddings
Click on the Resources List to view Resource records of connected FHIR Server and further clink on the record itself to view JSON and Human readable details of selected Resource



### Perform Vector Search
To search, type resource in the search field


Thanks
