--Create Schema
CREATE SCHEMA FR_LEGO_SCHEMA

-- Create Tables
CREATE OR REPLACE TABLE FR_LEGO_SCHEMA.COLORS (
	ID INT PRIMARY KEY,
	NAME VARCHAR(28),
	RGB VARCHAR(6),
	IS_TRANS VARCHAR(1)
);

CREATE OR REPLACE TABLE FR_LEGO_SCHEMA.THEMES (
 ID NUMBER(3) PRIMARY KEY,
 NAME VARCHAR(32),
 PARENT_ID NUMBER(3)
);

CREATE OR REPLACE TABLE FR_LEGO_SCHEMA.SETS (
 SET_NUM VARCHAR(255) PRIMARY KEY,
 NAME VARCHAR(250),
 YEAR NUMBER(4),
 THEME_ID NUMBER(3,0) FOREIGN KEY REFERENCES THEMES(id),
 NUM_PARTS NUMBER(4,0)
);

CREATE OR REPLACE TABLE FR_LEGO_SCHEMA.INVENTORIES (
	ID INT PRIMARY KEY,
	VERSION NUMBER(1),
	SET_NUM VARCHAR(255) FOREIGN KEY REFERENCES SETS(set_num)
);

CREATE OR REPLACE TABLE FR_LEGO_SCHEMA.INVENTORY_SETS (
    INVENTORY_ID INT FOREIGN KEY REFERENCES INVENTORIES(id),
	SET_NUM VARCHAR(255) FOREIGN KEY REFERENCES SETS(set_num),
	QUANTITY INT    
);

CREATE OR REPLACE TABLE FR_LEGO_SCHEMA.PART_CATEGORIES (
    ID NUMBER(38) PRIMARY KEY,
    NAME VARCHAR(250)
);

CREATE OR REPLACE TABLE FR_LEGO_SCHEMA.PARTS (
    PART_NUM VARCHAR(15) PRIMARY KEY,
    NAME VARCHAR(223),
    PART_CAT_ID NUMBER(38) FOREIGN KEY REFERENCES PART_CATEGORIES(id)
);

CREATE OR REPLACE TABLE FR_LEGO_SCHEMA.INVENTORY_PARTS (
    INVENTORY_ID INT FOREIGN KEY REFERENCES INVENTORIES(id),
	PART_NUM VARCHAR(15) FOREIGN KEY REFERENCES PARTS(part_num),
	COLOR_ID INT FOREIGN KEY REFERENCES COLORS(id),
	QUANTITY INT,
	IS_SPARE VARCHAR(1)
);



--Insert Data
INSERT INTO FR_LEGO_SCHEMA.COLORS (
SELECT *
FROM  STAGING.LEGO_COLORS
);

INSERT INTO FR_LEGO_SCHEMA.INVENTORIES (
SELECT *
FROM  STAGING.LEGO_INVENTORIES
);

INSERT INTO FR_LEGO_SCHEMA.INVENTORY_PARTS (
SELECT *
FROM  STAGING.LEGO_INVENTORY_PARTS
);

INSERT INTO FR_LEGO_SCHEMA.INVENTORY_SETS (
SELECT *
FROM  STAGING.LEGO_INVENTORY_SETS
);

INSERT INTO FR_LEGO_SCHEMA.PARTS (
SELECT *
FROM  STAGING.LEGO_PARTS
);

INSERT INTO FR_LEGO_SCHEMA.PART_CATEGORIES (
SELECT *
FROM  STAGING.LEGO_PART_CATEGORIES
);

INSERT INTO FR_LEGO_SCHEMA.THEMES (
SELECT *
FROM  STAGING.LEGO_THEMES
);

INSERT INTO FR_LEGO_SCHEMA.SETS (
SELECT *
FROM  STAGING.LEGO_SETS
);
