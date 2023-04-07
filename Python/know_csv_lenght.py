# find the number of lines in a file
# sales.csv has its 60,567,401 lines for the 605,674 products (100 sales per product) + 1 header line

import csv

# Ouverture du fichier CSV
with open('output/sales.csv', newline='') as f:
    reader = csv.reader(f)
    
    # Comptage du nombre de lignes
    nombre_de_lignes = len(list(reader))

# Affichage du résultat
print("Le fichier contient", nombre_de_lignes, "lignes.")
