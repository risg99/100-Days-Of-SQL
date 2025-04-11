-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon (Hard Level) #SQL Interview Question — Solution
-- Find products which are exclusive to only Amazon and therefore not sold at Top Shop 
-- and Macy's. Your output should include the product name, brand name, price, and rating.
-- Two products are considered equal if they have the same product name and same maximum 
-- retail price (mrp column).

-- Database setup:
CREATE TABLE INNERWEAR_AMAZON_COM (
	PRODUCT_NAME VARCHAR(255),
	MRP VARCHAR(50),
	PRICE VARCHAR(50),
	PDP_URL VARCHAR(255),
	BRAND_NAME VARCHAR(100),
	PRODUCT_CATEGORY VARCHAR(100),
	RETAILER VARCHAR(100),
	DESCRIPTION VARCHAR(255),
	RATING FLOAT,
	REVIEW_COUNT INT,
	STYLE_ATTRIBUTES VARCHAR(255),
	TOTAL_SIZES VARCHAR(50),
	AVAILABLE_SIZE VARCHAR(50),
	COLOR VARCHAR(50)
);

INSERT INTO
	INNERWEAR_AMAZON_COM (
		PRODUCT_NAME,
		MRP,
		PRICE,
		PDP_URL,
		BRAND_NAME,
		PRODUCT_CATEGORY,
		RETAILER,
		DESCRIPTION,
		RATING,
		REVIEW_COUNT,
		STYLE_ATTRIBUTES,
		TOTAL_SIZES,
		AVAILABLE_SIZE,
		COLOR
	)
VALUES
	(
		'ProductA',
		'100',
		'80',
		'url1',
		'BrandA',
		'Category1',
		'Amazon',
		'DescriptionA',
		4.5,
		100,
		'StyleA',
		'M,L',
		'M',
		'Red'
	),
	(
		'ProductB',
		'200',
		'180',
		'url2',
		'BrandB',
		'Category1',
		'Amazon',
		'DescriptionB',
		4.2,
		150,
		'StyleB',
		'S,M,L',
		'S',
		'Blue'
	),
	(
		'ProductC',
		'300',
		'250',
		'url3',
		'BrandC',
		'Category2',
		'Amazon',
		'DescriptionC',
		4.8,
		200,
		'StyleC',
		'L,XL',
		'L',
		'Green'
	);

CREATE TABLE INNERWEAR_MACYS_COM (
	PRODUCT_NAME VARCHAR(255),
	MRP VARCHAR(50),
	PRICE VARCHAR(50),
	PDP_URL VARCHAR(255),
	BRAND_NAME VARCHAR(100),
	PRODUCT_CATEGORY VARCHAR(100),
	RETAILER VARCHAR(100),
	DESCRIPTION VARCHAR(255),
	RATING FLOAT,
	REVIEW_COUNT FLOAT,
	STYLE_ATTRIBUTES VARCHAR(255),
	TOTAL_SIZES VARCHAR(50),
	AVAILABLE_SIZE VARCHAR(50),
	COLOR VARCHAR(50)
);

INSERT INTO
	INNERWEAR_MACYS_COM (
		PRODUCT_NAME,
		MRP,
		PRICE,
		PDP_URL,
		BRAND_NAME,
		PRODUCT_CATEGORY,
		RETAILER,
		DESCRIPTION,
		RATING,
		REVIEW_COUNT,
		STYLE_ATTRIBUTES,
		TOTAL_SIZES,
		AVAILABLE_SIZE,
		COLOR
	)
VALUES
	(
		'ProductA',
		'100',
		'85',
		'url4',
		'BrandA',
		'Category1',
		'Macys',
		'DescriptionA',
		4.5,
		90,
		'StyleA',
		'M,L',
		'M',
		'Red'
	),
	(
		'ProductD',
		'150',
		'130',
		'url5',
		'BrandD',
		'Category3',
		'Macys',
		'DescriptionD',
		4.0,
		80,
		'StyleD',
		'S,M',
		'S',
		'Yellow'
	),
	(
		'ProductE',
		'250',
		'210',
		'url6',
		'BrandE',
		'Category4',
		'Macys',
		'DescriptionE',
		3.9,
		60,
		'StyleE',
		'M,L',
		'L',
		'Black'
	);

CREATE TABLE INNERWEAR_TOPSHOP_COM (
	PRODUCT_NAME VARCHAR(255),
	MRP VARCHAR(50),
	PRICE VARCHAR(50),
	PDP_URL VARCHAR(255),
	BRAND_NAME VARCHAR(100),
	PRODUCT_CATEGORY VARCHAR(100),
	RETAILER VARCHAR(100),
	DESCRIPTION VARCHAR(255),
	RATING FLOAT,
	REVIEW_COUNT FLOAT,
	STYLE_ATTRIBUTES VARCHAR(255),
	TOTAL_SIZES VARCHAR(50),
	AVAILABLE_SIZE VARCHAR(50),
	COLOR VARCHAR(50)
);

INSERT INTO
	INNERWEAR_TOPSHOP_COM (
		PRODUCT_NAME,
		MRP,
		PRICE,
		PDP_URL,
		BRAND_NAME,
		PRODUCT_CATEGORY,
		RETAILER,
		DESCRIPTION,
		RATING,
		REVIEW_COUNT,
		STYLE_ATTRIBUTES,
		TOTAL_SIZES,
		AVAILABLE_SIZE,
		COLOR
	)
VALUES
	(
		'ProductB',
		'200',
		'190',
		'url7',
		'BrandB',
		'Category1',
		'TopShop',
		'DescriptionB',
		4.1,
		95,
		'StyleB',
		'S,M,L',
		'M',
		'Blue'
	),
	(
		'ProductF',
		'100',
		'90',
		'url8',
		'BrandF',
		'Category3',
		'TopShop',
		'DescriptionF',
		3.5,
		50,
		'StyleF',
		'XS,S',
		'S',
		'Pink'
	),
	(
		'ProductG',
		'300',
		'270',
		'url9',
		'BrandG',
		'Category5',
		'TopShop',
		'DescriptionG',
		4.3,
		70,
		'StyleG',
		'M,L,XL',
		'M',
		'Purple'
	);

-- Query:
SELECT
	A.PRODUCT_NAME,
	A.BRAND_NAME,
	A.PRICE,
	A.RATING
FROM
	INNERWEAR_AMAZON_COM A
	LEFT JOIN INNERWEAR_MACYS_COM M ON A.PRODUCT_NAME = M.PRODUCT_NAME
	AND A.MRP = M.MRP
	LEFT JOIN INNERWEAR_TOPSHOP_COM T ON A.PRODUCT_NAME = T.PRODUCT_NAME
	AND A.MRP = T.MRP
WHERE
	M.PRODUCT_NAME IS NULL
	AND T.PRODUCT_NAME IS NULL;

-- Reset Database:
DROP TABLE INNERWEAR_AMAZON_COM;
DROP TABLE INNERWEAR_MACYS_COM;
DROP TABLE INNERWEAR_TOPSHOP_COM;