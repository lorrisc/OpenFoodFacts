delete from brand_product cascade; 
delete from brand cascade; 
delete from define_ingredient cascade;
delete from ingredient cascade;
delete from define_additive cascade;
delete from additive cascade;
delete from image cascade;
delete from typeimage cascade;
delete from sales cascade;
delete from distributor cascade;
delete from product cascade;
delete from category cascade;
delete from country cascade;
delete from creator cascade;
delete from nova_group cascade;
delete from ecoscore cascade;
delete from nutritionalgrade cascade;

-- NUTRIONALGRADE
COPY nutritionalgrade(idnutritionalgrade, grade_label)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\nutritionalgrade.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- ECOSCORE
COPY ecoscore(idecoscore, grade)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\ecoscore.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- NOVAGROUP
COPY nova_group(idnovagroup, value_nova_group, label_nova_group)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\nova_group.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- CREATOR
COPY creator(idcreator, creator_name)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\creator.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- COUNTRY
COPY country(idcountry, country_name)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\country.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- CATEGORY
COPY category(idcategory, cat_idcategory, category_name)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\category.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- PRODUCT
COPY product(idproduct, idnovagroup,idecoscore,idnutritionalgrade,idcreator,idcategory,idcountry,code,url,creation_date,last_update_date,product_name,completness,energy100g,fat100g,saturatedfat100g,carbohydrates100g,sugars100g,proteins100g,nutritionscorfr100g,energykcal100g,ecoscore_value)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\product.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- DISTRIBUTOR
COPY distributor(iddistributor, name_distributor)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\distributor.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- SALES
COPY sales(idsale, iddistributor, idproduct, quantity, datesale)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\sales.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- TYPE IMAGE
COPY typeimage(idtypeimage, name_type_image)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\typeimage.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- IMAGE
COPY image(idimage, idtypeimage, idproduct, url_image, date_image)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\image.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- ADDITIVE
COPY additive(idadditive, code_additive,name_additive)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\additive.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- DEFINE ADDITIVE
COPY define_additive(idproduct, idadditive)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\define_additive.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- INGREDIENT
COPY ingredient(idingredient, name_ingredient)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\ingredient.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- DEFINE INGREDIENT
COPY define_ingredient(idingredient, idproduct)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\define_ingredient.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- BRAND
COPY brand(idbrand, brand_name)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\brand.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');

-- BRAND PRODUCT
COPY brand_product(idproduct, idbrand)
FROM 'C:\Users\Lorris\Desktop\generate csv_\output\brand_product.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ';', QUOTE '''');