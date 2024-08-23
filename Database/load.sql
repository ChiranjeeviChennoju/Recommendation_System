-- product_type table

INSERT INTO product_type (product_type_no,product_type_name)
SELECT
    a.product_type_no,
    a.product_type_name,

FROM
    (SELECT DISTINCT product_type_no,product_type_name
     FROM articles) a
WHERE NOT EXISTS (
    SELECT 1 FROM product_type p WHERE p.product_type_no = a.product_type_no 
);

-- product_group table

INSERT INTO product_group (product_type_no,product_group_name)
SELECT
    a.product_type_no,
    a.product_group_name

FROM
    (SELECT DISTINCT product_type_no,product_group_name
     FROM articles) a
WHERE NOT EXISTS (
    SELECT 1 FROM product_group p WHERE p.product_type_no = a.product_type_no 
);


-- graphical appearance table


INSERT INTO graphical_appearance (graphical_appearance_no,graphical_appearance_name)
SELECT
    a.graphical_appearance_no,
    a.graphical_appearance_name
FROM
    (SELECT DISTINCT graphical_appearance_no,graphical_appearance_name
     FROM articles) a
WHERE NOT EXISTS (
    SELECT 1 FROM graphical_appearance p WHERE p.graphical_appearance_no = a.graphical_appearance_no
);

-- color table


INSERT INTO colour (colour_group_code,colour_group_name)
SELECT
    a.colour_group_code,
    a.colour_group_name
FROM
    (SELECT DISTINCT colour_group_code,colour_group_name
     FROM articles) a
WHERE NOT EXISTS (
    SELECT 1 FROM colour p WHERE p.colour_group_code = a.colour_group_code
);

-- department table

INSERT INTO department (department_no,department_name)
SELECT
    a.department_no,
    a.department_name
FROM
    (SELECT DISTINCT department_no,department_name
     FROM articles) a
WHERE NOT EXISTS (
    SELECT 1 FROM department p WHERE p.department_no = a.department_no
);


-- index table

INSERT INTO indices (index_code,index_name)
SELECT
    a.index_code,
    a.index_name
FROM
    (SELECT DISTINCT index_code, index_name
     FROM articles) a
WHERE NOT EXISTS (
    SELECT 1 FROM indices p WHERE p.index_code = a.index_code
);


--perceived_colour

INSERT INTO perceived_colour (perceived_colour_value_id,perceived_colour_value_name)
SELECT
    a.perceived_colour_value_id,
    a.perceived_colour_value_name
FROM
    (SELECT DISTINCT perceived_colour_value_id, perceived_colour_value_name
     FROM articles) a
WHERE NOT EXISTS (
    SELECT 1 FROM perceived_colour p WHERE p.perceived_colour_value_id = a.perceived_colour_value_id
);


-- perceived_master


INSERT INTO perceived_master (perceived_colour_master_id,perceived_colour_master_name)
SELECT
    a.perceived_colour_master_id,
    a.perceived_colour_master_name
FROM
    (SELECT DISTINCT perceived_colour_master_id, perceived_colour_master_name
     FROM articles) a
WHERE NOT EXISTS (
    SELECT 1 FROM perceived_master p WHERE p.perceived_colour_master_id = a.perceived_colour_master_id
);


-- section


INSERT INTO sections (section_no,section_name)
SELECT
    a.section_no,
    a.section_name
FROM
    (SELECT DISTINCT section_no, section_name
     FROM articles) a
WHERE NOT EXISTS (
    SELECT 1 FROM sections p WHERE p.section_no = a.section_no
);

select distinct section_no from articles

select * from sections

-- Garment


INSERT INTO garment (garment_group_no,garment_group_name)
SELECT
    a.garment_group_no,
    a.garment_group_name
FROM
    (SELECT DISTINCT garment_group_no, garment_group_name
     FROM articles) a
WHERE NOT EXISTS (
    SELECT 1 FROM garment p WHERE p.garment_group_no = a.garment_group_no
);

-- Relational Tables

-- PRODUCTS

insert into Products( article_id ,prod_name ,product_code ,product_type_no ,colour_group_code ,department_no , detail_desc )
select article_id ,prod_name ,product_code ,product_type_no ,colour_group_code ,department_no , detail_desc 
from articles

alter table Products add foreign key(product_type_no) references product_type(product_type_no) ON UPDATE SET NULL ON DELETE SET NULL;
alter table Products add foreign key(colour_group_code) references colour(colour_group_code) ON UPDATE SET NULL ON DELETE SET NULL;
alter table Products add foreign key(department_no) references department(department_no) ON UPDATE SET NULL ON DELETE SET NULL;

select * from Products

-- STYLE TABLE


insert into styles(
	article_id ,
	prod_name ,
	product_group_name ,
	product_type_no ,
	colour_group_code ,
	department_no ,
	index_code ,
	index_group_no ,
	section_no 
)
select 	article_id ,
	prod_name ,
	product_group_name ,
	product_type_no ,
	colour_group_code ,
	department_no ,
	index_code ,
	index_group_no ,
	section_no 
from articles

alter table styles add foreign key(product_type_no) references product_type(product_type_no) ON UPDATE SET NULL ON DELETE SET NULL;
alter table styles add foreign key(colour_group_code) references colour(colour_group_code) ON UPDATE SET NULL ON DELETE SET NULL;
alter table styles add foreign key(department_no) references department(department_no) ON UPDATE SET NULL ON DELETE SET NULL;
alter table styles add foreign key(index_code) references indices(index_code) ON UPDATE SET NULL ON DELETE SET NULL;
alter table styles add foreign key(index_group_no) references index_group(index_group_no) ON UPDATE SET NULL ON DELETE SET NULL;
alter table styles add foreign key(section_no) references sections(section_no) ON UPDATE SET NULL ON DELETE SET NULL;

-- COLOUR TABLE


insert into colours(
	article_id ,
	prod_name ,
	colour_group_code ,
	perceived_colour_value_id ,
	perceived_colour_master_id 
)
select 
	article_id ,
	prod_name ,
	colour_group_code ,
	perceived_colour_value_id ,
	perceived_colour_master_id 
from articles

alter table colours add foreign key(colour_group_code) references colour(colour_group_code) ON UPDATE SET NULL ON DELETE SET NULL;
alter table colours add foreign key(perceived_colour_value_id) references perceived_colour(perceived_colour_value_id) ON UPDATE SET NULL ON DELETE SET NULL;
alter table colours add foreign key(perceived_colour_master_id) references perceived_master(perceived_colour_master_id) ON UPDATE SET NULL ON DELETE SET NULL;

-- design_features

insert into design_features(
	article_id,
	prod_name,
	garment_group_no,
	graphical_appearance_no
)
select article_id, prod_name, garment_group_no, graphical_appearance_no
from articles

alter table design_features add foreign key(garment_group_no) references garment(garment_group_no) ON UPDATE SET NULL ON DELETE SET NULL;
alter table design_features add foreign key(graphical_appearance_no) references graphical_appearance(graphical_appearance_no) ON UPDATE SET NULL ON DELETE SET NULL;


-- purchases

-- these are the constraints for purchases
alter table purchases add foreign key (customer_id) references customers(customer_id)  ON UPDATE SET NULL ON DELETE SET NULL;
alter table purchases add foreign key (article_id) references products(article_id)  ON UPDATE SET NULL ON DELETE SET NULL; 



