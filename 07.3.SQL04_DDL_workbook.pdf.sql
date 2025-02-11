--1.
CREATE TABLE TB_CATEGORY(
        TB_NAME VARCHAR2(10),
        TB_USE_YN CHAR(1)DEFAULT'Y'
        );

--2.
CREATE TABLE TB_CLASS_TYPE(
        TB_NO VARCHAR2(5)PRIMARY KEY,
        TB_NAME VARCHAR2(10)
        );
        
--3.
ALTER TABLE TB_CATEGORY ADD PRIMARY KEY(TB_NAME);

--4.
ALTER TABLE TB_CLASS_TYPE MODIFY TB_NAME NOT NULL;

--5.


           
        
        
        
        
        