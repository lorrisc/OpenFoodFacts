# 🥫 Projet Open Food Facts – Analyse & Optimisation de Données

## 📌 Présentation

Ce projet s’appuie sur la base de données **Open Food Facts**, qui regroupe plus de **600 000 produits alimentaires**. Mené en équipe de **quatre personnes**, notre objectif principal était de **créer une base de données relationnelle**, de **produire des rapports interactifs via Power BI**, et de **développer des modèles d’intelligence artificielle** à l’aide de **Knime**.

---

## 🚀 Objectif : Optimisation

S’il fallait résumer ce projet en un seul mot : **optimisation**.  
À chaque étape, nous avons veillé à choisir des solutions performantes, robustes et adaptées au volume de données.

### 🔧 Étapes clés :
- **Création de la base de données** à partir d’un **fichier plat** (.txt/.csv).
- **Extraction et transformation** des données via un **script Python** :
  - Génération automatisée de fichiers `.csv` pour chaque table.
  - Simulation de **100 ventes par produit**, soit plus de **60 millions de ventes**.
  - Optimisation des performances avec **Pandas** et la **librairie `multiprocessing`**.
  - Temps d’exécution total : **moins de 8 minutes**.
- **Visualisation et reporting** interactifs avec **Power BI**.
- **Analyse prédictive et modélisation** via **Knime** (algorithmes de machine learning supervisés et non-supervisés).

---

## 🛠️ Stack & Compétences mobilisées

- **Python** : traitement de données, génération CSV, multiprocessing
- **Pandas** : manipulation efficace des données
- **Bases de données relationnelles** : modélisation, création, normalisation
- **Power BI** : visualisations, tableaux de bord dynamiques
- **Knime** : modélisation IA, pipeline de traitement
- **Gestion de projet** : planification, travail collaboratif, partage des tâches

---

## 📊 Résultats

- Une base de données complète, performante, et évolutive
- Des rapports clairs et interactifs mettant en valeur les insights clés
- Des modèles IA appliqués avec pertinence aux données produits & ventes

---

## 📁 Organisation du dépôt

```text
📂 base_de_donnees/           # Scripts SQL pour la base OLTP/OLAP
├── base.backup.txt
├── insertIntoOlapFromOltp.sql
├── requete copy csv.sql
├── scriptBaseOLAP.sql
├── scriptBaseOLTP.sql

📂 data_plat/       # Données Open Food Facts originales
🔗 [Lien vers le fichier plat](https://drive.google.com/drive/folders/1dhE1XtP473UaUyRWGGeGqWiZNKgKVIIW?usp=sharing)

📂 knime/           # Workflows IA réalisés sous Knime
🔗 [Lien vers les workflows Knime](https://drive.google.com/drive/folders/1dhE1XtP473UaUyRWGGeGqWiZNKgKVIIW?usp=sharing) 

📂 OLTP OLAP/       # Schémas conceptuels (MCD/MPD) pour OLTP et OLAP

📂 powerbi/         # Tableaux de bord Power BI
🔗 [Lien vers les dashboards Power BI](https://drive.google.com/drive/folders/1dhE1XtP473UaUyRWGGeGqWiZNKgKVIIW?usp=sharing)

📂 python/          # Scripts Python pour génération et traitement de données
├── generate_csv_multiprocessing.py
├── generate_csv_noMultiprocess.py
├── know_csv_lenght.py
├── slice_csv.py
├── input_output_file_link.txt

📂 soutenances-et-rapports/                  # Documents finaux

📄 Sujet.pdf
