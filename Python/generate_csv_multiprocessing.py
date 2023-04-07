# Create the csv corresponding to the tables of the database from the input file donne_traite.csv containing all the products
# This script uses multiprocessing methods for the sales generation part. This greatly improves the execution speed of the program (from 20min to about 5min)
# A computer with minimal hardware resources is required

from multiprocessing import Pool
from functools import partial
import multiprocessing as mp
import datetime as dt
import pandas as pd
import numpy as np
import subprocess
import random
import time
import re
import os




def getExecuteTime(startTime) : 
    endTime = time.time()
    elapsedTime = endTime - startTime
    print("Éxécuté en " + str(elapsedTime) + " secondes\n")

# SALES FUCTIONS
def generate_sales(idproduct,nutriscore_grade,ecoscore_grade, dic_score, days_between_date, date_trois_ans_avant):
    indice_vente = dic_score.get(nutriscore_grade, 1) * dic_score.get(ecoscore_grade, 1)
    sales_data_temp = []

    indice_vente_sup1 = 5 * indice_vente
    indice_vente_inf1 = indice_vente
    for i in range(100):
        random_numbers_of_days = random.randrange(days_between_date)
        random_date = date_trois_ans_avant + dt.timedelta(days=random_numbers_of_days)
        pourcentage_date = random_numbers_of_days / days_between_date
        if indice_vente > 1:
            pourcentage_ecart_type = indice_vente_sup1 * pourcentage_date
        else:
            if pourcentage_date == 0:
                pourcentage_date = 1 / 1095
            pourcentage_ecart_type = indice_vente_inf1 / pourcentage_date

        ecart_type = 4000 * pourcentage_ecart_type + 2000

        sales_data_temp.append([random.randrange(1, 10), idproduct, abs(round(random.normalvariate(10000, ecart_type))), "'" + str(random_date) + "'"])
    return sales_data_temp

def add_sales_data(row, dic_score, days_between_date, date_trois_ans_avant, sales_data):
    nutriscore_grade = row["nutriscore_grade"]
    ecoscore_grade = row["ecoscore_grade"]
    idproduct = row["id_product"]
    sales_data.extend(generate_sales(idproduct,nutriscore_grade,ecoscore_grade, dic_score, days_between_date,date_trois_ans_avant))
    # df_sales = pd.DataFrame(sales_data, columns=['iddistributor', 'idproduct', 'quantity','datesale'])

def worker(df_chunk, dic_score, days_between_date, date_trois_ans_avant):
    sales_data = []
    df_chunk.apply(lambda row: add_sales_data(row, dic_score=dic_score, days_between_date=days_between_date, date_trois_ans_avant=date_trois_ans_avant, sales_data=sales_data), axis=1)

    df_sales = pd.DataFrame(sales_data, columns=['iddistributor', 'idproduct', 'quantity','datesale'])
    # df_sales.to_csv("sales"+str(sales_data[0][1])+".csv", sep=";",  header=False, index=False) # sales_data[0][1] for an unique file name (= idproduct)
    return df_sales

# CATEGORY FUNCTIONS
def get_main_category(row):
    if row['category_name'] in df_product['sub_category'].unique():# if sub_category
        main_category = df_product.loc[df_product['sub_category'] == row['category_name'], 'main_category'].iloc[0]# get main_category
        cat_idcategory = df_category.loc[df_category['category_name'] == main_category, 'idcategory'].iloc[0]# get id of main_category
    else:
        cat_idcategory = None
    return cat_idcategory

# Add category id to df_product
def get_category_id(row):
    if pd.notnull(row['sub_category']):
        category_name = row['sub_category']
    elif pd.notnull(row['main_category']):
        category_name = row['main_category']
    else:
        category_name = None

    if category_name is not None:
        idcategory = df_category.loc[df_category['category_name'] == category_name, 'idcategory'].iloc[0]
    else:
        idcategory = None

    return idcategory




if __name__ == '__main__':
    startTimeProgram = time.time()

    print('READING CSV ...')
    startTime = time.time()
    dtypes = {"code_barre": str,"ecoscore_score": "Int64"}
    df_product = pd.read_csv("input/donnees_traite.csv", sep=";", dtype=dtypes)
    outputPath = "output/"
    getExecuteTime(startTime)




    # ***** DISTRIBUTOR *****
    print('DISTRIBUTOR IN PROGRESS ...')
    startTime = time.time()
    distributors_data = {
        'iddistributor': range(1, 11),
        'name_distributor': ['Carrefour', 'Provencia', 'Les Mousquetaires', 'Auchan', 'Systeme U', 'Casino', 'Lidl', 'Leclerc', 'Aldi', 'Cora']
    }

    df_distributor = pd.DataFrame(distributors_data)

    df_distributor.to_csv(outputPath+"distributor.csv", sep=";", index=False)
    getExecuteTime(startTime)



    # ***** COUNTRY *****
    print('COUNTRY IN PROGRESS ...')
    startTime = time.time()
    df_country = df_product[["countries_en"]].drop_duplicates().reset_index(drop=True) # drop duplicates and reset index
    df_country = df_country.dropna(subset=["countries_en"]) # drop null values
    df_country["idcountry"] = df_country.index + 1 # id step

    df_product = df_product.rename(columns={"countries_en": "country_name"}) # rename product column
    # rename country colmun and reindex
    df_country = df_country.rename(columns={"countries_en": "country_name", "idcountry": "idcountry"}).reindex(columns=["idcountry", "country_name"])
    # save in csv
    df_country.to_csv(outputPath+"country.csv", sep=";", index=False)

    df_product = pd.merge(df_product, df_country, on="country_name", how="left") # merge product and country
    df_product = df_product.drop(columns=["country_name"]) # drop country_name column
    df_product["idcountry"] = df_product["idcountry"].astype(str).str.replace("nan|\.0", "", regex=True) # delete nan and .0
    getExecuteTime(startTime)




    # ***** CREATOR *****
    print('CREATOR IN PROGRESS ...')
    startTime = time.time()
    df_creator = df_product[["creator"]].drop_duplicates().reset_index(drop=True)
    df_creator = df_creator.dropna(subset=["creator"])
    df_creator["idcreator"] = df_creator.index + 1

    df_product = df_product.rename(columns={"creator": "creator_name"})
    df_creator = df_creator.rename(columns={"creator": "creator_name", "idcreator": "idcreator"}).reindex(columns=["idcreator", "creator_name"])

    df_creator.to_csv(outputPath+"creator.csv", sep=";", index=False)

    df_product = pd.merge(df_product, df_creator, on="creator_name", how="left")
    df_product = df_product.drop(columns=["creator_name"])
    df_product["idcreator"] = df_product["idcreator"].astype(str).str.replace("nan|\.0", "", regex=True)
    getExecuteTime(startTime)




    # ***** SALES *****
    print('SALES IN PROGRESS ...')
    startTime = time.time()

    date_actuelle = dt.datetime.now()
    date_trois_ans_avant = date_actuelle - dt.timedelta(days=3*365)
    days_between_date = (date_actuelle - date_trois_ans_avant).days

    dic_score = { # nutriscore et ecoscore
        "a":1.10,
        "b":1.05,
        "c":1,
        "d":0.95,
        "e":0.90,
        "":1,
        "nan":1,
        "<NA>":1,
    }

    num_processes = mp.cpu_count()

    chunk_size = len(df_product) // num_processes
    chunks = [df_product.iloc[i:i + chunk_size] for i in range(0, len(df_product), chunk_size)]
    pool = mp.Pool(processes=num_processes)

    worker_with_args = partial(worker, dic_score=dic_score, days_between_date=days_between_date, date_trois_ans_avant=date_trois_ans_avant)
    pool.map(worker_with_args, chunks)
    df_salefinal = pd.DataFrame(columns=['iddistributor', 'idproduct', 'quantity', 'datesale'])
    for result in pool.map(worker_with_args, chunks):
        df_salefinal = pd.concat([df_salefinal, result], ignore_index=True)

    df_salefinal.insert(0, 'idsale', df_salefinal.index)
    df_salefinal.to_csv(outputPath+"sales.csv", sep=";", index=False)
    getExecuteTime(startTime)



    # ***** ECOSCORE *****
    # We could also have imagined inserting ecoscore by hand, but python allows very good speed
    print('ECOSCORE IN PROGRESS ...')
    startTime = time.time()
    df_ecoscore = df_product[["ecoscore_grade"]].drop_duplicates().reset_index(drop=True)
    df_ecoscore = df_ecoscore.dropna(subset=["ecoscore_grade"])
    df_ecoscore["idecoscore"] = df_ecoscore.index + 1

    df_product = df_product.rename(columns={"ecoscore_grade": "grade"})
    df_ecoscore = df_ecoscore.rename(columns={"ecoscore_grade": "grade"}).reindex(columns=["idecoscore", "grade"])

    df_ecoscore.to_csv(outputPath+"ecoscore.csv", sep=";", index=False)

    df_product = pd.merge(df_product, df_ecoscore, on="grade", how="left")
    df_product = df_product.drop(columns=["grade"])
    df_product["idecoscore"] = df_product["idecoscore"].astype(str).str.replace("nan|\.0", "", regex=True)
    getExecuteTime(startTime)




    # ***** NOVAGROUP *****
    print('NOVAGROUP IN PROGRESS ...')
    startTime = time.time()
    df_novagroup = pd.DataFrame()

    df_novagroup['idnovagroup'] = [1, 2, 3, 4]
    df_novagroup['value_nova_group'] = [1, 2, 3, 4]
    df_novagroup['label_nova_group'] = ['Aliments peu ou non transformés', 'Ingrédients culinaires', 
                                        'Aliments transformés', 'Aliments ultratransformés']

    df_novagroup.to_csv(outputPath+"nova_group.csv", sep=";", index=False)

    # Dictionnary for map values
    # The df nova_group have several columns, the mapping allows not to delete all the columns of nova_group in the df product after the merge
    value_nova_group = dict(df_novagroup[['idnovagroup', 'value_nova_group']].values)
    df_product['idnovagroup'] = df_product['nova_group'].map(value_nova_group)
    df_product = df_product.drop(columns=["nova_group"])
    df_product["idnovagroup"] = df_product["idnovagroup"].astype(str).str.replace("nan|\.0", "", regex=True)
    getExecuteTime(startTime)




    # ***** NUTRISCORE *****
    print('NUTRISCORE IN PROGRESS ...')
    startTime = time.time()
    df_nutritionalgrade = df_product[["nutriscore_grade"]].drop_duplicates().reset_index(drop=True)
    df_nutritionalgrade = df_nutritionalgrade.dropna(subset=["nutriscore_grade"])
    df_nutritionalgrade["idnutritionalgrade"] = df_nutritionalgrade.index + 1

    df_product = df_product.rename(columns={"nutriscore_grade": "grade_label"})
    df_nutritionalgrade = df_nutritionalgrade.rename(columns={"nutriscore_grade": "grade_label"}).reindex(columns=["idnutritionalgrade", "grade_label"])

    df_nutritionalgrade.to_csv(outputPath+"nutritionalgrade.csv", sep=";", index=False)

    df_product = pd.merge(df_product, df_nutritionalgrade, on="grade_label", how="left")
    df_product = df_product.drop(columns=["grade_label"])
    df_product["idnutritionalgrade"] = df_product["idnutritionalgrade"].astype(str).str.replace("nan|\.0", "", regex=True)
    getExecuteTime(startTime)




    # ***** TYPEIMAGE *****
    print('TYPEIMAGE IN PROGRESS ...')
    startTime = time.time()
    df_typeimage = pd.DataFrame()

    df_typeimage['idtypeimage'] = [1, 2]
    df_typeimage['name_type_image'] = ['normal', 'small']

    df_typeimage.to_csv(outputPath+"typeimage.csv", sep=";", index=False)
    getExecuteTime(startTime)




    # ***** IMAGE *****
    print('IMAGE IN PROGRESS ...')
    startTime = time.time()
    df_image_normal = pd.DataFrame({# normal
        'idimage': pd.RangeIndex(start=1, step=1, stop=len(df_product)+1),
        'idtypeimage': 1,
        'idproduct': df_product['id_product'],
        'url_image': df_product['image_url'],
        'date_image': df_product['last_image_datetime']
    })
    df_image_normal = df_image_normal.dropna(subset=['url_image'])# delete rows with empty url_image

    n = len(df_product)
    df_image_small = pd.DataFrame({# small
        'idimage': pd.RangeIndex(start=n+1, step=1, stop=2*n+1),
        'idtypeimage': 2,
        'idproduct': df_product['id_product'],
        'url_image': df_product['image_small_url'],
        'date_image': df_product['last_image_datetime']
    })
    df_image_small = df_image_small.dropna(subset=['url_image'])

    df_image = pd.concat([df_image_normal, df_image_small])
    df_image.to_csv(outputPath+"image.csv", sep=";", index=False)
    getExecuteTime(startTime)



        
    # ***** BRAND *****
    print('BRAND IN PROGRESS ...')
    startTime = time.time()
    brandtags_list = df_product['brands_tags'].str.split(',', expand=True).stack().str.strip().unique()
    df_brand = pd.DataFrame({
        'idbrand': range(1, len(brandtags_list) + 1),
        'brand_name': brandtags_list
    })
    df_brand.to_csv(outputPath+"brand.csv", sep=";", index=False)
    getExecuteTime(startTime)

    print('BRAND PRODUCT IN PROGRESS ...')
    startTime = time.time()
    df_brand_product = df_product[['id_product', 'brands_tags']]
    df_brand_product = df_brand_product.assign(brands_tags=df_brand_product['brands_tags'].str.split(',')).explode('brands_tags')
    df_brand_product = pd.merge(df_brand_product, df_brand, left_on='brands_tags', right_on='brand_name')[['id_product', 'idbrand']]
    df_brand_product = df_brand_product.drop_duplicates()
    df_brand_product.to_csv(outputPath+"brand_product.csv", sep=";", index=False)
    getExecuteTime(startTime)




    # ***** CATEGORY *****
    print('CATEGORY IN PROGRESS ...')
    startTime = time.time()
    # Get all categories
    all_categories = pd.concat([df_product['main_category'], df_product['sub_category']]).unique()
    df_category = pd.DataFrame({'category_name': all_categories})

    # Add id and parent category
    df_category['idcategory'] = df_category.index + 1

    df_category = df_category[df_category['category_name'].notnull()]
    df_category['cat_idcategory'] = df_category.apply(get_main_category, axis=1) # add cat_idcategory (parent category)
    df_category = df_category[['idcategory', 'cat_idcategory', 'category_name']] # reindex columns
    df_category["cat_idcategory"] = df_category["cat_idcategory"].astype(str).str.replace("nan|\.0", "", regex=True)

    df_category.to_csv(outputPath+"category.csv", sep=";", index=False)

    df_product['idcategory'] = df_product.apply(get_category_id, axis=1)
    getExecuteTime(startTime)




    # ***** INGREDIENT *****
    print('INGREDIENT IN PROGRESS ...)')
    startTime = time.time()
    # Extract id_product and ingredients_tags
    df_ingredients = df_product[['id_product', 'ingredients_tags']].dropna(subset=['ingredients_tags'])

    # ingredients_tags array
    df_ingredients.loc[:, 'ingredients_tags'] = df_ingredients['ingredients_tags'].str.split(',')
    df_ingredients['ingredients_tags'] = df_ingredients['ingredients_tags'].apply(lambda x: x.copy())

    # Array to several lines
    df_ingredients_clean = df_ingredients.explode('ingredients_tags')
    df_ingredients_clean['name_ingredient'] = df_ingredients_clean['ingredients_tags'].apply(lambda x: str(x).split(':')[-1].strip())# get name_ingredient
    df_ingredients_clean = df_ingredients_clean[['id_product', 'name_ingredient']].drop_duplicates() # drop duplicates
    df_ingredients_clean = df_ingredients_clean.replace('', np.nan)
    df_ingredients_clean = df_ingredients_clean.dropna(subset=['name_ingredient'])
    df_ingredients_clean = df_ingredients_clean[df_ingredients_clean['name_ingredient'].str.len() < 100] # non fiable
    df_id_product = df_ingredients_clean[['id_product']].drop_duplicates()

    # Unique id for each ingredient
    df_idingredient = pd.DataFrame({'name_ingredient': df_ingredients_clean['name_ingredient'].unique()})
    df_idingredient['idingredient'] = df_idingredient.index + 1

    df_ingredients_clean = pd.merge(df_ingredients_clean, df_idingredient, on='name_ingredient', how='left') # id_product, name_ingredient, idingredient

    df_idingredient[['idingredient', 'name_ingredient']].to_csv(outputPath+'ingredient.csv', index=False, sep=';')
    df_ingredients_clean = df_ingredients_clean.rename(columns={"id_product": "idproduct"})
    df_ingredients_clean[['idingredient', 'idproduct']].to_csv(outputPath+'define_ingredient.csv', index=False, sep=';')
    getExecuteTime(startTime)




    # ***** ADDITIVE *****
    print('ADDITIVE IN PROGRESS ...')
    startTime = time.time()
    # Extract id_product and additives_tags
    df_additives = df_product[['id_product', 'additives_tags']].dropna(subset=['additives_tags'])

    # additives_tags array
    df_additives.loc[:, 'additives_tags'] = df_additives['additives_tags'].str.split(',')
    df_additives['additives_tags'] = df_additives['additives_tags'].apply(lambda x: x.copy())

    # Array to several lines
    df_additives_clean = df_additives.explode('additives_tags')
    df_additives_clean['code_additive'] = df_additives_clean['additives_tags'].apply(lambda x: str(x).split(':')[-1].strip())# get code_additive
    df_additives_clean = df_additives_clean[['id_product', 'code_additive']].drop_duplicates() # drop duplicates
    df_id_product = df_additives_clean[['id_product']].drop_duplicates()

    # Unique id for each additive
    df_idadditive = pd.DataFrame({'code_additive': df_additives_clean['code_additive'].unique()})
    df_idadditive['idadditive'] = df_idadditive.index + 1

    df_additives_clean = pd.merge(df_additives_clean, df_idadditive, on='code_additive', how='left') # id_product, code_additive, idadditive

    df_idadditive['name_additive'] = df_idadditive['code_additive'].apply(lambda x: x if re.match('^(?!e\d{2,}).*$', x) else None) # add name 
    df_idadditive['code_additive'] = df_idadditive['code_additive'].apply(lambda x: None if re.match('^(?!e\d{2,}).*$', x) else x) # delete code when it's a name


    df_idadditive[['idadditive', 'code_additive','name_additive']].to_csv(outputPath+'additive.csv', index=False, sep=';')
    df_additives_clean = df_additives_clean.rename(columns={"id_product": "idproduct"})
    df_additives_clean[['idproduct', 'idadditive']].to_csv(outputPath+'define_additive.csv', index=False, sep=';')
    getExecuteTime(startTime)

    


    # ***** PRODUCT *****
    print('SAVE PRODUCT CSV ...')
    startTime = time.time()
    df_product["idcategory"] = df_product["idcategory"].astype(str).str.replace("nan|\.0", "", regex=True) # delete nan and .0
    df_product[['id_product', 'idnovagroup','idecoscore','idnutritionalgrade','idcreator','idcategory','idcountry','code_barre','url','created_datetime','last_modified_datetime','product_name','completeness','energy_100g','fat_100g','saturated_fat_100g','carbohydrates_100g','sugars_100g','proteins_100g','nutrition_score_fr_100g','energy_kcal_100g','ecoscore_score']].to_csv(outputPath+"product.csv", sep=";", index=False)
    getExecuteTime(startTime)




    endTime = time.time()
    elapsedTime = endTime - startTimeProgram
    print("Temps total d'exécution : " + str(elapsedTime) + " secondes\n")