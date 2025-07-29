CREATE DATABASE inventory_db;
USE inventory_db;

# Creating Products Category Table.
CREATE TABLE product_category(
id INT NOT NULL,
name VARCHAR (50),
taxable BOOLEAN,
age_restricted BOOLEAN,
ebt_eligible BOOLEAN
	);
    
# Adding Values to the product_category Table.

INSERT INTO product_category (id, name, taxable, age_restricted, ebt_eligible)
VALUES( 01, 'Beer and Seltzers', TRUE, TRUE, FALSE),
(02, 'Liquor', TRUE, TRUE, FALSE),
(03, 'Wine', TRUE, TRUE, FALSE),
(04, 'Tobacco', TRUE, TRUE, FALSE),
(05, 'Grocery', FALSE, FALSE, TRUE),
(06, 'Grocery-Tax', TRUE, FALSE, FALSE);


# Creating brands Table
CREATE TABLE brands(
brand_id INT AUTO_INCREMENT PRIMARY KEY,
brand_name VARCHAR(100),
country_of_origin VARCHAR(50),
michigan_made BOOLEAN,
brand_description TEXT
);

# Altering product_category Table to modify Primary Key Column and Auto Increment.
ALTER TABLE product_category 
MODIFY COLUMN id INT AUTO_INCREMENT,
ADD PRIMARY KEY (id);

ALTER TABLE product_category 
AUTO_INCREMENT = 7;

# Creating beer_and_seltzers Table
CREATE TABLE beer_and_seltzers(
beer_id INT AUTO_INCREMENT PRIMARY KEY,
brand_id INT,
category_id INT,
sub_category VARCHAR(50),
item_description TEXT,
price DECIMAL(10,2),
size_and_quantity VARCHAR (50),
alcohol_percentage DECIMAL(5,2),
bottle_form VARCHAR(50),
image_url VARCHAR(2083),
FOREIGN KEY(brand_id) REFERENCES brands(brand_id),
FOREIGN KEY(category_id) REFERENCES product_category(id)
);
ALTER TABLE beer_and_seltzers
ADD COLUMN beer_name VARCHAR(100);

# Creating liquor Table
CREATE TABLE liqour(
liquor_id INT AUTO_INCREMENT PRIMARY KEY,
brand_id INT,
category_id INT,
sub_category VARCHAR(50),
item_description TEXT,
price DECIMAL(10,2),
size_and_quantity VARCHAR (50),
alcohol_percentage DECIMAL(5,2),
bottle_form VARCHAR(50),
image_url VARCHAR(2083),
FOREIGN KEY(brand_id) REFERENCES brands(brand_id),
FOREIGN KEY(category_id) REFERENCES product_category(id)
);




