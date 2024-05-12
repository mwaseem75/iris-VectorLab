Class dc.VectorLab.Base Extends %RegisteredObject
{

ClassMethod init() As %Status
{
	set createTable = ..CreateTable()
	return $$$OK
}

ClassMethod ListResources() As %String
{
	//Get Active Server data based on Global Variable 
	//Set obj = ##class(dc.FhirLab.Server).%OpenId(^FhirLabServer)
	//If Url and ApiKey is defined
	//if $isobject(obj)  
	//{  
	  
	//  set resources =  "Resources"
	
	//  return resources
  //	}
	//Active Server data is not defined
  	//else
  	//{ 
  		return "Not able to get server Info.."
  	//}
  	return ""
}

ClassMethod GetConnString() As %String [ Language = python ]
{
	import os
	username = 'demo'
	password = 'demo'
	hostname = os.getenv('IRIS_HOSTNAME', 'localhost')
	port = '1972' 
	namespace = 'USER'
	CONNECTION_STRING = f"iris://{username}:{password}@{hostname}:{port}/{namespace}"
	return CONNECTION_STRING
}

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

ClassMethod InserData() As %String [ Language = python ]
{
	
	from sqlalchemy import create_engine,text
	import iris
	connStr = iris.cls(__name__).GetConnString()
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
	import numpy as np 
	import pandas as pd

	df = pd.DataFrame(documents)
	df.columns = ['description']
	model = SentenceTransformer('all-MiniLM-L6-v2')

    # Generate embeddings for each document
	document_embeddings = model.encode(documents)

	df['description_vector'] = document_embeddings.tolist()
    

	engine = create_engine(connStr)
    
	with engine.connect() as conn:
		with conn.begin():
			# remove existing data
			sql = text("""
                    DELETE FROM VectorLab                    
                """)
			conn.execute(sql)
			for index, row in df.iterrows():
				sql = text("""
                    INSERT INTO VectorLab 
                    (description, description_vector) 
                    VALUES (:description, TO_VECTOR(:description_vector))
                """)
				conn.execute(sql, {
                    'description': row['description'], 
                    'description_vector': str(row['description_vector'])
              	  })
	
	conn.close()
}

ClassMethod VectorSearch(aurg As %String) As %String [ Language = python ]
{
	
	from sentence_transformers import SentenceTransformer
	import numpy as np 
	import pandas as pd
	from sqlalchemy import create_engine,text

	model = SentenceTransformer('all-MiniLM-L6-v2')

	search_vector = model.encode(aurg, normalize_embeddings=True).tolist() # Convert search phrase into a vector
	
	import iris
	connStr = iris.cls(__name__).GetConnString()
	engine = create_engine(connStr)
    
	with engine.connect() as conn:
		with conn.begin():
			sql = text("""
            	SELECT TOP 5 id,description FROM VectorLab 
            	ORDER BY VECTOR_DOT_PRODUCT(description_vector, TO_VECTOR(:search_vector)) DESC
        	""")

			results = conn.execute(sql, {'search_vector': str(search_vector)}).fetchall()

	conn.close()
	#results_df = pd.DataFrame(results, columns=['description','description_vector']).iloc[:, :-1] # Remove vector
	results_df = pd.DataFrame(results) 
	print(results_df.head())
}

ClassMethod VectorSearchHTML(aurg As %String) As %String [ Language = python ]
{
	from sentence_transformers import SentenceTransformer	
	from sqlalchemy import create_engine,text
	import pandas as pd

	model = SentenceTransformer('all-MiniLM-L6-v2')

	search_vector = model.encode(aurg, normalize_embeddings=True).tolist() # Convert search phrase into a vector
	
	import iris
	connStr = iris.cls(__name__).GetConnString()
	engine = create_engine(connStr)
    
	with engine.connect() as conn:
		with conn.begin():
			sql = text("""
            	SELECT TOP 5 ID,description FROM VectorLab 
            	ORDER BY VECTOR_DOT_PRODUCT(description_vector, TO_VECTOR(:search_vector)) DESC
        	""")

			results = conn.execute(sql, {'search_vector': str(search_vector)}).fetchall()

	conn.close()
	df = pd.DataFrame(results) 
	
	rows = "<thead><tr><th>ID</th><th>Description</th><th>Options</th></thead>"
	for index, row in df.iterrows():
		
		rows = rows + "<tr><td>"+str(row['ID'])+"</td><td>"+row['description']+"</td><td>"+"options"+"</td></tr>"
		
	
	rows = rows + "</tobody>"			
	return rows
}

}
