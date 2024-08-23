-- Queries
-- Display the differnet graphical appearances and thier garments used for 'Jerry jogger bottoms' which are in black colour.

select   m.garment_group_name, m.graphical_appearance_name
from (select x.prod_name, x.garment_group_name, x.graphical_appearance_name, y.colour_group_code
from (select * 
from (select a.prod_name, b.garment_group_name
from design_features as a
natural join garment as b where a.prod_name ='Jerry jogger bottoms') as h
natural join  (select a.prod_name, b.graphical_appearance_name
from design_features as a
natural join graphical_appearance as b ) as i) as x
natural join colours as y) as m
natural join colour as n
where n.colour_group_name = 'Black'  


----Insertion------

insert into product_type values(1,'Dothi');
insert into product_type values(2,'Saree');
insert into product_type values(3,'Kurtha');

select * from product_type

----Updation---

update product_type set product_type_name = 'Lungi' where product_type_no = 1;

select * from product_type where product_type_no = 1;

----Deletion-----

delete from product_type where product_type_no = 3;

select * from product_type where product_type_no = 3;
 
----Order By -----

-- Name of the product names that are most sold.

SELECT p.prod_name, COUNT(*) AS total_sales
FROM purchases pu
JOIN products p ON pu.article_id = p.article_id
GROUP BY p.prod_name
ORDER BY total_sales DESC
LIMIT 5;

----Group By

-- Display the number of colours a single product is available in.

select prod_name , count(distinct(colour_group_code)) as colours from products group by prod_name order by colours desc

----FUNCTION_______


CREATE OR REPLACE FUNCTION GetProductDetails(articleID BIGINT)
RETURNS TABLE(
    article_id BIGINT,
    prod_name VARCHAR,
    detail_desc TEXT,
    product_type_name VARCHAR,
    product_group_name VARCHAR,
    colour_group_name VARCHAR,
    perceived_colour_master_name VARCHAR,
    perceived_colour_value_name VARCHAR,
    garment_group_name VARCHAR,
    graphical_appearance_name VARCHAR,
    department_name VARCHAR,
    index_name VARCHAR,
    index_group_name VARCHAR,
    section_name VARCHAR
)
LANGUAGE SQL
AS $$
    SELECT 
        p.article_id,
        p.prod_name,
        p.detail_desc,
        pt.product_type_name,
        pg.product_group_name,
        cg.colour_group_name,
        pcm.perceived_colour_master_name,
        pc.perceived_colour_value_name,
        gg.garment_group_name,
        ga.graphical_appearance_name,
        dep.department_name,
        i.index_name,
        ig.index_group_name,
        s.section_name
    FROM 
        products p
    Natural JOIN product_group pg 
    Natural JOIN product_type pt 
    Natural JOIN colours c 
    Natural JOIN colour cg 
    Natural JOIN perceived_colour pc 
    Natural JOIN perceived_master pcm 
    Natural JOIN design_features d 
    Natural JOIN garment gg 
    Natural JOIN graphical_appearance ga 
    Natural JOIN department dep 
    Natural JOIN styles sty 
    Natural JOIN indices i 
    Natural JOIN index_group ig 
    Natural JOIN sections s 
    WHERE 
        p.article_id = articleID;
$$;

SELECT * FROM GetProductDetails(108775015); 


---- FUNCTION 2-----------

CREATE FUNCTION GetSimilarColorProducts(customer_id INT)
RETURNS TABLE(article_id INT, prod_name VARCHAR, colour_group_name VARCHAR)
LANGUAGE SQL
AS $$
    SELECT DISTINCT pur.article_id, col.prod_name, cg.colour_group_name
    FROM PURCHASES pur
    JOIN colours col ON pur.article_id = col.article_id
    JOIN colour cg ON col.colour_group_code = cg.colour_group_code
    WHERE pur.customer_id = customer_id
    AND cg.colour_group_code IN (
        SELECT colour_group_code
        FROM PURCHASES
        JOIN colours ON PURCHASES.article_id = colours.article_id
        WHERE customer_id = customer_id
    );
END;
$$;

--- this query gives other colours that product is available in.
select *
from colour 
natural join (select colour_group_code
from colours
where prod_name = (select distinct(prod_name)
from purchases
natural join colours
natural join colour
where article_id = 176209023)) as f


---  gives 5 similar products given a customer purchase

select distinct(styles.prod_name)
from styles
where section_no in (select distinct(sections.section_no)
from sections 
natural join (select section_no
from styles
where prod_name in (select distinct(styles.prod_name)
from purchases
natural join styles
natural join sections
where customer_id = 'e62c0436e0d6a3d35a0585fc188cc8bd7fbd56d2bf63d8b7562d757bc30adc97')) as f) 
limit 5;




