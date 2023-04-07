
-- # ---------- dim_time

INSERT INTO dim_time("Date", "Month", "Month Name", "Quarter", "Year")
    SELECT d::date, DATE_PART('month', d), TO_CHAR(d, 'Month'),DATE_PART('quarter', d), DATE_PART('year', d)
    FROM generate_series((SELECT MIN(datesale) FROM public.sales)::date, CURRENT_DATE::date, '1 day'::interval) d;


-- # ---------- dim_product

INSERT INTO dim_product("Id Product", "Code", "Product Name", "Category Name", "Sub Category Name", "Ecoscore", "Nutriscore", "Nutriscore Score", "Novagroup Value", "Novagroup Label", "Country", "Image", "Creator", "Brand", "Energy for 100g", "Energy kcal for 100g", "Fat for 100g", "Saturated fat for 100g", "Sugars for 100g", "Proteins for 100g", "Carbohydrates for 100g")
        SELECT pr.idproduct as "ID Product", pr.code as "Code", pr.product_name as "Product Name", cmere.category_name as "Category Name", c.category_name as "Sub Category Name", 
            eco.grade as "Ecoscore", nutri.grade_label as "Nutriscore", pr.nutritionscorfr100g as "Nutrition Score", nova.value_nova_group as "Novagroup Value", nova.label_nova_group as "Novagroup Label", 
            ctry.country_name as "Country", img.url_image as "Image", cr.creator_name as "Creator", brand.brand_name as "Brand",
            pr.energy100g as "Energy for 100g", pr.energykcal100g "Energy kcal for 100g", 
            pr.fat100g as "Fat for 100g", pr.saturatedfat100g as "Saturated fat for 100g",  
            pr.sugars100g as "Sugars for 100g", pr.proteins100g as "Proteins for 100g", pr.carbohydrates100g as "Carbohydrates for 100g"
    FROM public.product pr
        JOIN public.category c ON pr.idcategory = c.idcategory
        JOIN public.category cmere ON cmere.idcategory = c.cat_idcategory
        JOIN public.ecoscore eco ON pr.idecoscore = eco.idecoscore
        JOIN public.nutritionalgrade nutri ON pr.idnutritionalgrade = nutri.idnutritionalgrade
        JOIN public.nova_group nova ON pr.idnovagroup = nova.idnovagroup
        JOIN public.country ctry ON pr.idcountry = ctry.idcountry
        JOIN public.image img ON pr.idproduct = img.idproduct
        JOIN public.typeimage typeimg ON img.idtypeimage = typeimg.idtypeimage
        JOIN public.brand_product bp ON pr.idproduct = bp.idproduct
        JOIN public.brand ON bp.idbrand = brand.idbrand
        JOIN public.creator cr ON pr.idcreator = cr.idcreator
    where pr.energy100g is not null and pr.energykcal100g is not null and pr.fat100g is not null and pr.saturatedfat100g is not null
            and pr.carbohydrates100g is not null and pr.sugars100g is not null and pr.proteins100g is not null and typeimg.name_type_image = 'small'


-- # ---------- dim_distributor

INSERT INTO dim_distributor ("Id Distributor", "Distributor Name")
    SELECT dis.iddistributor, dis.name_distributor
    FROM public.distributor dis


-- # ---------- fact_composition

INSERT INTO fact_composition ("Id Dim Product")
    SELECT pr."Id Dim Product"
    FROM dim_product pr 
    

-- # ---------- fact_sales

INSERT INTO fact_sales("Date", "Id Dim Product", "Id Distributor", "Id Sale", "Quantity Sold")
    SELECT s.datesale, dimpr."Id Dim Product", s.iddistributor, s.idsale, s.quantity
    FROM public.sales s 
        JOIN olap.dim_product dimpr ON s.idproduct = dimpr."Id Product"
