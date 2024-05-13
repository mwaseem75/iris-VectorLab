# Summary
IRIS-VectorLab is a web application that demonstrates the functionality of [**Vector Search**](https://www.docs.intersystems.com/iris20241/csp/docbook/Doc.View.cls?KEY=GSQL_vecsearch) with the help of [**embedded python**](https://docs.intersystems.com/irisforhealthlatest/csp/docbook/DocBook.UI.Page.cls?KEY=AFL_epython). It leverages the functionality of the Python framework  [**SentenceTransformers**](https://www.sbert.net/) for state-of-the-art sentence embeddings.  

[![one](https://img.shields.io/badge/Platform-InterSystems%20IRIS-blue)](https://www.intersystems.com/data-platform/) [![one](https://img.shields.io/badge/WebFrameWork-CSP-Orange)](https://docs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GCSP) [![one](https://img.shields.io/badge/Technology-Vector%20Search-yellow)](https://www.docs.intersystems.com/iris20241/csp/docbook/Doc.View.cls?KEY=GSQL_vecsearch) [![one](https://img.shields.io/badge/Python%20Library-Sentence%20Transformers-Maroon)](https://www.sbert.net/) [![OEX](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)]() [![license](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/mwaseem75/iris-fhir-lab/blob/main/LICENSE)

## Features
* Text to Embeddings Translation.
* VECTOR-typed Data Insertion.
* View Vector Data
* Perform Vector Search.
* Demonstrate the difference between normal and vector search

## Online Demo
[https://irisfhirlab.demo.community.intersystems.com/csp/fhirlab/index.csp](https://irisvectorlab.demo.community.intersystems.com/csp/vectorlab/index.csp) by using demo | demo


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
Navigate to [http://localhost:52773/csp/vectorlab/index.csp](http://localhost:52773/csp/VectorLab/index.csp) to run the application. (by using demo|demo)
<img width="868" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/4b9a0a2a-9028-4edf-983d-0835c628716e">


### Load data
<img width="845" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/7c38e947-541a-486a-b7ba-0e4062666bd4">


### Add data with vector embeddings
Click on the Resources List to view Resource records of the connected FHIR Server and further clink on the record itself to view JSON and Human readable details of selected Resource
<img width="845" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/4cd66ed0-8020-4c2f-b929-72cd6d61c5ae">
<img width="938" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/11f66897-5df2-426d-bee1-59ce517202bf">

### View Vector Data

From application

<img width="845" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/36fce100-deb4-4861-a624-6be1852248d9">

<img width="875" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/fbe3be3e-01fc-4175-af40-f503b19c8c68">

From Management portal
<img width="950" alt="Screenshot 2024-05-13 133805" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/008996ea-8fd5-4a26-861b-bc92cf37a31a">


## Performing Vector Search
Type "The fox and the chicken" in search and click Vector search button
<img width="852" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/9099f686-4308-4bf6-af9e-f3932ad8923f">

Application will get the top 5 similar vector data.

Try to do a traditional search by clicking the Normal search button, system will not retrieve any record.
<img width="853" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/fcd8d095-590b-40dc-91aa-69635ae84f10">

Application will not get any data.



Thanks
