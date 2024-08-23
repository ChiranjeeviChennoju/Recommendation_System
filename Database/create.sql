----Create

-- product_type table
drop table product_type

create table product_type(
	product_type_no INT primary key,
	product_type_name varchar,
);



-- product_group table
drop table product_group

create table product_group(
	product_type_no INT primary key,
	product_group_name varchar
);

-- graphical appearance table

drop table graphical_appearance

create table graphical_appearance(
	graphical_appearance_no INT primary key,
	graphical_appearance_name varchar
);

select * from articles

-- color table

drop table colour

create table colour(
	colour_group_code INT primary key,
	colour_group_name varchar
);


-- department table
select * from articles

drop table department

create table department(
	department_no INT primary key,
	department_name varchar
);


-- index table

drop table indices

create table indices(
	index_code varchar primary key,
	index_name varchar
);


--perceived_colour

drop table perceived_colour

create table perceived_colour(
	perceived_colour_value_id int primary key,
	perceived_colour_value_name varchar
);


select * from perceived_colour

-- perceived_master

drop table perceived_master

create table perceived_master(
	perceived_colour_master_id int primary key,
	perceived_colour_master_name varchar
);

-- section

drop table sections

create table sections(
	section_no int primary key,
	section_name varchar
);



-- Garment

drop table garment

create table garment(
	garment_group_no int primary key,
	garment_group_name varchar
);


-- Relational Tables

-- PRODUCTS
drop table Products

create table Products(
	article_id int primary key,
	prod_name varchar,
	product_group_name varchar,
	product_code int,
	product_type_no int,
	colour_group_code int,
	department_no int,
	detail_desc text
)

-- STYLE TABLE

drop table styles

create table styles(
	article_id int primary key,
	prod_name varchar,
	product_group_name varchar,
	product_type_no int,
	colour_group_code int,
	department_no int,
	index_code varchar,
	index_group_no int,
	section_no int
)

-- COLOUR TABLE

drop table colours

create table colours(
	article_id int primary key,
	prod_name varchar,
	colour_group_code int,
	perceived_colour_value_id int,
	perceived_colour_master_id int
)

-- design_features

drop table design_features

create table design_features(
	article_id int primary key,
	prod_name varchar,
	garment_group_no int,
	graphical_appearance_no int
)

-- customers
drop table customers

create table customers(
	customer_id varchar primary key,
	fn float,
	active float,
	club_member_status varchar,
	fashion_news_frequency varchar,
	age float,
	postal_code varchar
)

-- purchases

drop table purchases

create table purchases(
	t_dat date,
	customer_id varchar,
	article_id int,
	price float,
	sales_channel_id int
) 


