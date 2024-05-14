# Summary
IRIS-VectorLab is a web application that demonstrates the functionality of [**Vector Search**](https://www.docs.intersystems.com/iris20241/csp/docbook/Doc.View.cls?KEY=GSQL_vecsearch) with the help of [**embedded python**](https://docs.intersystems.com/irisforhealthlatest/csp/docbook/DocBook.UI.Page.cls?KEY=AFL_epython). It leverages the functionality of the Python framework  [**SentenceTransformers**](https://www.sbert.net/) for state-of-the-art sentence embeddings.  

[![one](https://img.shields.io/badge/Platform-InterSystems%20IRIS-blue)](https://www.intersystems.com/data-platform/) [![one](https://img.shields.io/badge/WebFrameWork-CSP-Orange)](https://docs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=GCSP) [![one](https://img.shields.io/badge/Technology-Vector%20Search-yellow)](https://www.docs.intersystems.com/iris20241/csp/docbook/Doc.View.cls?KEY=GSQL_vecsearch) [![one](https://img.shields.io/badge/Python%20Library-Sentence%20Transformers-Maroon)](https://www.sbert.net/) [![OEX](https://img.shields.io/badge/Available%20on-Intersystems%20Open%20Exchange-00b2a9.svg)]() [![license](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/mwaseem75/iris-fhir-lab/blob/main/LICENSE)

## Features
* Text to Embeddings Translation.
* VECTOR-typed Data Insertion.
* View Vector Data
* Perform Vector Search by using VECTOR_DOT_PRODUCT and VECTOR_COSINE functions.
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


Application already loaded some dummy data for testing purposes.

## Test functionality through IRIS terminal
Run the below command to start IRIS terminal from VS CODE terminal
```
$ docker-compose exec iris iris session iris
```
<img width="862" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/82786e92-e187-4b42-b2aa-70453eefb17e">

### View existing data 
Run the below command in IRIS terminal to view the existing data
```
do ##class(dc.VectorLab.Base).ListData()
```
<img width="846" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/db04e185-56d7-409c-87f5-a134e206cc5d">

### Inserting vector data
Run the below command to insert vector data, Pass the desired description as an argument
```
do ##class(dc.VectorLab.Base).SaveData("InterSystems IRIS Data Platform 2024.1 introduces Vector Search")
```
Run the ListData command again to view the data
<img width="823" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/1db36edf-1bde-490f-97c3-fd6835186593">

### View vector data
Run the below command to view vector data in IRIS terminal and pass the ID which is 17 in our case.
```
set vector =  ##class(dc.VectorLab.Base).ViewData(17,2) 
write vector
```
<img width="830" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/5e63b1c1-b04a-413d-9373-f3b05b26e0f3">

### Performing Vector Search
Run the below command to search vector data
```
set vector =  ##class(dc.VectorLab.Base).VectorSearch("The fox and the chicken")
```
Application will get the top 5 similar records
<img width="833" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/00e39315-7e86-4460-babf-e93339ea9716">



## Test the functionality by Running Web Application
Navigate to [http://localhost:52773/csp/vectorlab/index.csp](http://localhost:52773/csp/VectorLab/index.csp) to run the application. (by using demo|demo)
<img width="841" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/8404f157-d1ac-4213-be6e-c875b8ef6fb5">

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

### Load data
If needed, Load data button will remove all the data and load the fresh data.
<img width="845" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/7c38e947-541a-486a-b7ba-0e4062666bd4">

## Performing Vector Search
Type "The fox and the chicken" in search and click Vector search button
<img width="848" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/cba18b3b-275b-4b7e-bbe1-9a05bce26a5c">

Application will get the top 5 similar vector data.

Now we will do a traditional search by clicking the Normal search button, as expected system will not retrieve any record.
<img width="853" alt="image" src="https://github.com/mwaseem75/iris-VectorLab/assets/18219467/fcd8d095-590b-40dc-91aa-69635ae84f10">


Thanks
