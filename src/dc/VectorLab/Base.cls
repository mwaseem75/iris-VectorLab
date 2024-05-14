Class dc.VectorLab.Base Extends %RegisteredObject
{

// Create table

ClassMethod init() As %Status
{
	set createTable = ..CreateTable()
	return $$$OK
}

// Function to create the table

ClassMethod CreateTable() As %Status
{
	&SQL(DROP TABLE VectorLab)
	&SQL(CREATE TABLE VectorLab (
		description	VARCHAR(2000),
		description_vector VECTOR(DOUBLE, 384))  
		)
	if (SQLCODE '= 0) 
	{
	&SQL(CREATE COLUMNAR INDEX IVectorLab on VectorLab(description_vector))
	}
	return $$$OK
}

// add some dummy data for testing purpose

ClassMethod InsertData() As %String [ Language = python ]
{
	
	import iris
	# Step 1: Prepare the Data (Same as before)
	documents =[
    "The quick brown fox jumps over the lazy dog.",
    "A watched pot never boils.",
    "Two wrongs don't make a right.",
    "The early bird catches the worm.",
    "Actions speak louder than words.",
    "Rome wasn't built in a day.",
    "Don't count your chickens before they hatch.",
    "The pen is mightier than the sword.",
    "When life gives you lemons, make lemonade.",
    "Beauty is in the eye of the beholder.",
    "Practice makes perfect.",
    "Don't put all your eggs in one basket.",
    "You can't judge a book by its cover.",
    "Time heals all wounds.",
    "The grass is always greener on the other side."
	]
    # Step 2: Generate Document Embeddings
	from sentence_transformers import SentenceTransformer
	import pandas as pd

	df = pd.DataFrame(documents)
	df.columns = ['description']
	model = SentenceTransformer('all-MiniLM-L6-v2')

    # Generate embeddings for each document
	document_embeddings = model.encode(documents)

	df['description_vector'] = document_embeddings.tolist()
    
	for index, row in df.iterrows():
		iris.cls(__name__).SaveVector(row['description'],str(row['description_vector']))
}

// Save vector data

ClassMethod SaveData(desc As %String) As %String [ Language = python ]
{
	
	from sqlalchemy import create_engine,text
	import iris
	# Step 1: Prepare the Data (Same as before)
	documents =[ desc ]
    # Step 2: Generate Document Embeddings
	from sentence_transformers import SentenceTransformer
	import pandas as pd

	df = pd.DataFrame(documents)
	df.columns = ['description']
	model = SentenceTransformer('all-MiniLM-L6-v2')

    # Generate embeddings for each document
	document_embeddings = model.encode(documents)

	df['description_vector'] = document_embeddings.tolist()
    
	for index, row in df.iterrows():
		iris.cls(__name__).SaveVector(row['description'],str(row['description_vector']))
}

ClassMethod SaveVector(desc As %String, descvec As %String) As %Status
{
	
  	&sql(INSERT INTO SQLUser.VectorLab  VALUES (:desc,to_vector(:descvec)))
 	if SQLCODE '= 0 {
   	 	write !, "Insert failed, SQLCODE= ", SQLCODE, ! ,%msg
    	quit
  	}
   	return $$$OK
}

// Delete record

ClassMethod DeleteVector(id As %Integer) As %Status
{
	&sql(DELETE FROM SQLUser.VectorLab WHERE ID = :id)
    IF SQLCODE<0 {WRITE "SQLCODE error ",SQLCODE," ",%msg  QUIT}
 	return $$$OK
}

// View Vector data

ClassMethod ViewData(id As %Integer, opt As %Integer) As %String
{
	if opt = 1
	{
	&sql(SELECT description into :desc FROM SQLUser.VectorLab WHERE ID = :id)
    IF SQLCODE<0 {WRITE "SQLCODE error ",SQLCODE," ",%msg  QUIT}
 	return desc
	}
	if opt = 2
	{
	&sql(SELECT description_vector into :desc FROM SQLUser.VectorLab WHERE ID = :id)
    IF SQLCODE<0 {WRITE "SQLCODE error ",SQLCODE," ",%msg  QUIT}
 	
	
	set total = $vectorop("count",desc)
	set vectorStr = ""
	for i = 1:1:total 
		{
		if (i = 1)
			{ set vectorStr = $vector(desc,i)}
		else
			{ set vectorStr = vectorStr_", "_$vector(desc,i)}	
		}
	return vectorStr
	}
}

// Select top 5 similar vector records

ClassMethod VectorSearch(aurg As %String) As %String [ Language = python ]
{
	
	from sentence_transformers import SentenceTransformer
	import pandas as pd
	model = SentenceTransformer('all-MiniLM-L6-v2')

	search_vector = str(model.encode(aurg, normalize_embeddings=True).tolist()) # Convert search phrase into a vector
	
	import iris
	stmt = iris.sql.prepare("SELECT top 5 id,description FROM SQLUser.VectorLab ORDER BY VECTOR_DOT_PRODUCT(description_vector, TO_VECTOR(?)) DESC")
	results = stmt.execute(search_vector)
	results_df = pd.DataFrame(results) 
	print(results_df.head())
}

// Display HTML data

ClassMethod VectorSearchHTML(aurg As %String) As %String [ Language = python ]
{
	from sentence_transformers import SentenceTransformer	
	import pandas as pd

	model = SentenceTransformer('all-MiniLM-L6-v2')

	search_vector = str(model.encode(aurg, normalize_embeddings=True).tolist()) # Convert search phrase into a vector
	
	import iris
	stmt = iris.sql.prepare("SELECT top 5 id,description,VECTOR_COSINE(description_vector, TO_VECTOR(?)) FROM SQLUser.VectorLab ORDER BY VECTOR_DOT_PRODUCT(description_vector, TO_VECTOR(?)) DESC")
	results = stmt.execute(search_vector,search_vector)
	df = pd.DataFrame(results,columns=['id', 'description','Cosine_Similarity']) 
	print(df.head())
	rows = "<thead><tr><th>ID</th><th>Description</th><th>Cosine Similarity</th></thead>"
	for index, row in df.iterrows():
		rows = rows + "<tr><td>"+str(row['id'])+"</td><td>"+row['description']+"</td><td>"+str(row['Cosine_Similarity'])+"</td></tr>"
		
	rows = rows + "</tobody>"			
	return rows
}

// List down all records

ClassMethod ListData() As %String [ Language = python ]
{
	import pandas as pd
	
	import iris
	rs = iris.sql.exec("select id, description from SQLUser.vectorlab")
		
	results_df = pd.DataFrame(rs) 
	print(results_df.head())
}

}
