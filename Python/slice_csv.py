# Create a new csv file with the desired number of lines
# Allows you to create a test csv file

import pandas as pd

nombre_lignes = 50000

dtypes = {"code_barre": str,"ecoscore_score": "Int64"}
df_product = pd.read_csv("input/donnees_traite.csv", sep=";", dtype=dtypes)

df_product_slice = df_product.iloc[0:nombre_lignes]
df_product_slice.to_csv("input/donnees_traite_small"+str(nombre_lignes)+".csv", sep=";", index=False)
