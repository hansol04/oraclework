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

--6.

--7.
ALTER TABLE TB_CATEGORY CONSTRAINT PK_CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE CONSTRAINT PK_CALSS_TYPE_NO PRIMARY KEY;


-- EMPLOYEE_COPY 테이블에 PRIMARY KEY 추가
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);
- PRIMARY KEY : ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명);

CREATE TABLE TB_PUBLISHER (
    PUB_NO NUMBER CONSTRAINT PUBLISHER_PK PRIMARY KEY,
    PUB_NAME VARCHAR (50) CONSTRAINT PUBLISHER_NN NOT NULL,
    PHONE VARCHAR (20)
);        
        
        
        
        