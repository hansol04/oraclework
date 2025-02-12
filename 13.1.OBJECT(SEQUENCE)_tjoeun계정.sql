/*
    * SEQUENCE
      : 자동으로 번호를 발생시켜주는 객체
        정수값을 순차적으로 일정값씩 증가시키면서 생성
        
      EX) 회원번호,사원번호,게시글번호...
*/

/*
    * 시퀀스 객체 생성
    
    [표현식]
    CREATE SEQUENCE 시퀀스명
    [START WITH 시작숫자]           -> 처음 발생시킬 시작값 지정(기본값 1)
    [INCREMENT BY 숫자]            -> 몇씩 증가 시킬지(기본값1)
    [MAXVALUE 숫자]                -> 최대값 지정(기본값 엄청큼)
    [MINVALUE 숫자]                -> 최소값 지정(기본값1)
    [CYCLE | NOCYCLE]              -> 값 순환 여부 지정(기본값 NOCYCLE)
    [NOCACHE | CACHE 바이트크기]    -> 캐시메모리 할당(기본값 CACHE 20)
     > 캐시메모리 : 시퀀스의 값을 미리 생성하여 저장해 두는 곳
                   매번 호출할 때마다 새롭게 번호를 생성하는게 아니라
                   캐시메모리에 미리 만들어 둔 값을 가져다 씀(속도가 빨라짐)
                   접속 해제 -> 캐시메모리에 미리 만들어 둔 번호는 다 날라감
                   
     - 객체 생성시 접두어 사용(권장사항)
       테이블 : TB_
       뷰 : VW_
       시퀀스 : SEQ_
       트리거 : TRG_
*/

-- 시퀀스 생성
CREATE SEQUENCE SEQ_TEST;

CREATE SEQUENCE SE1_EMPNO
START WITH 400
INCREMENT BY 5
MAXVALUE 410
NOCYCLE
NOCACHE;

/*
    * 시퀀스 사용
      시퀀스명.CURRVAL : 현재 시퀀스의 값(마지마으로 성공하여 수행된 NEXTVAL값)
      시퀀스명.NEXTVAL : 시숸스값에 일정하게 증가시켜서 발생된 값
                        현재 시퀀스 값에서 INCREMENT BY 한 값
                        시퀀스명.CURRVAL + INCREMENTT BY
                    
*/
SELECT  SEQ_EMPNO.CURRVAL FROM DUAL;
-- NEXTVAL를 한번도 수행하지 않은 상태. 성공한적 없음 CURRVAL을 사용할 수는 없음

SELECT  SEQ_EMPNO.
SELECT  SEQ_EMPNO.
SELECT  SEQ_EMPNO.NEXTACE
























-- 삭제
DROP SEQUENCE SEQ_EMPNO;

--------------------------------------------------------------------------------
CREATE SEQUENCE SEQ_EID
START WITH 400
NOCACHE;

INSERT INTO EMPOLYEE(EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL,'강감찬','971001-1234567','J3',SYSDATE);

INSERT INTO EMPOLYEE(EMP_ID,EMP_NAME,EMP_NO,JOB_CODE,HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL,'김일이','971001-1234567','J3',SYSDATE);


