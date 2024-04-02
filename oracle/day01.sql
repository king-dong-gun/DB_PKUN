CREATE TABLE ex2_2 (
    COLUMN1 VARCHAR2(3),
    COLUMN2 VARCHAR2(3),
    COLUMN3 VARCHAR2(3)
);

INSERT INTO ex2_2 VALUES ('ABC', 'ABC', 'ABC');

SELECT * FROM ex2_2;

SELECT COLUMN1, LENGTH(COLUMN1) AS LEN1,
       COLUMN2, LENGTH(COLUMN2) AS LEN2,
       COLUMN3, LENGTH(COLUMN3) AS LEN3
FROM ex2_2;

INSERT INTO ex2_2 (column3) VALUES ('홍길동');

SELECT COLUMN3, LENGTH(COLUMN3) AS len3, LENGTHB(COLUMN3) AS bytelen 
FROM ex2_2;

CREATE TABLE ex2_3 (
    col_int     integer,
    col_dec     decimal,
    col_num     number
);

SELECT COLUMN_ID, COLUMN_NAME, DATA_TYPE, DATA_LENGTH
FROM USER_tab_cols
WHERE TABLE_NAME = 'EX2_3'
ORDER BY COLUMN_ID;


CREATE TABLE ex2_4 (
    COL_FLOT1   FLOAT(32),
    COL_FLOT2   FLOAT
    );

INSERT INTO ex2_4 (col_flot1, col_flot2) VALUES (1234567891234, 1234567891234);


CREATE TABLE ex2_5 (
    COL_DATE        DATE,
    COL_TIMESTAMP   TIMESTAMP
);

INSERT INTO ex2_5 VALUES (SYSDATE, SYSTIMESTAMP);

SELECT *
FROM ex2_5;


CREATE TABLE ex2_6 (
    col_null        varchar2(10),
    col_not_null    varchar2(10) NOT NULL
    );

INSERT INTO ex2_6 VALUES ('AA', 'BB');

CREATE TABLE ex2_7 (
    col_unique_null     varchar2(10) UNIQUE,
    col_unique_nnull    varchar2(10) UNIQUE NOT NULL,
    col_unique          varchar2(10),
    CONSTRAINTS unique_nm1 UNIQUE (col_unique)
    );

