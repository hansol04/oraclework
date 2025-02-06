/*
    <GROUP BY절>
    여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
*/

-- 각 부서별 총 급여액
SELECT DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 사원 수
SELECT DEPT_CODE,COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE,SUM(SALARY),COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 직급별 사원수와 급여의 총합
SELECT JOB_CODE,COUNT(*),SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 직급별 사원수,보너스를 받는 사원수,급여합,평균급여,최저급여,최고급여
SELECT JOB_CODE,COUNT(*),COUNT(BONUS),SUM(SALARY),ROUND(AVG(SALARY),-1),MIN(SALARY),MAX(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 남,여별 사원수
-- DECODE는 오라클에서만 사용하는 함수
SELECT DECODE(SUBSTR(EMP_NO,8,1), '1', '남', '2', '여', '3', '남', '4', '여') "성별 사원수", COUNT(*)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1), '1', '남', '2', '여', '3', '남', '4', '여');

-- 모든 DB 다 사용
SELECT CASE WHEN SUBSTR(EMP_NO,8,1) = '1' THEN '남'
                    WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '여'
                    WHEN SUBSTR(EMP_NO,8,1) = '3' THEN '남'
                    WHEN SUBSTR(EMP_NO,8,1) = '4' THEN '여'
            END "성별 사원수"
            , COUNT(*)
FROM EMPLOYEE
GROUP BY CASE WHEN SUBSTR(EMP_NO,8,1) = '1' THEN '남'
                         WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '여'
                         WHEN SUBSTR(EMP_NO,8,1) = '3' THEN '남'
                         WHEN SUBSTR(EMP_NO,8,1) = '4' THEN '여'
                 END;

-- GROUP BY절에 여러 컬럼 기술 가능
SELECT DEPT_CODE,JOB_CODE,COUNT(*),SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE,JOB_CODE
ORDER BY DEPT_CODE,JOB_CODE;

--------------------------------------------------------------------------------
/* 
    <HAVING 절>
    그룹에 대한 조건을 제시할 때 
*/
-- 각 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE,CEIL(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY)>=3000000;

---------------------------------실습문제----------------------------------------
--1.직급별 총 급여합(단,직급별 급여합이 1000만원 이상인 직급만 조회)직급코드,급여합 조회
SELECT JOB_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY)>=10000000;

--2.부서별 보너스를 받는 사원이 없는 부서만 부서코드를 조회
SELECT DEPT_CODE,COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--------------------------------------------------------------------------------
/* 
    <SELECT문 실행 순서>
    FROM
    ON : 조인 조건 확인
    JOIN : 테이블간이 조인
    WHERE
    GROUP BY
    HAVING
    SELECT
    DISTINCT
    ORDER BY
*/
--------------------------------------------------------------------------------
/* 
    <집계함수>
    그룹별로 산출된 결과값에 중간집계를 계산해주는 함수
    
    ROLLUP,CUBE
    => GROUP BY 절에 기술하는 함수
    
    - ROLLUP(컬럼1,컬럼2):컬럼1을 가지고 다시 중간 집계를 내는 함수
    - CUBE(컬럼1,컬럼2):컬럼1을 가지고 중간집계를 내고, 컬럼2도 중간집계를 냄
*/

-- 각 직급별 급여의 합
SELECT JOB_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- 컬럼이 1개 일때는 CUBE, ROLLIP, 안쓴것 모두 동일
SELECT JOB_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY JOB_CODE;

--컬럼이 2개 일때 사용
SELECT JOB_CODE,DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE,DEPT_CODE
ORDER BY JOB_CODE,DEPT_CODE;

--ROLLUP
SELECT JOB_CODE,DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE,DEPT_CODE)
ORDER BY JOB_CODE,DEPT_CODE;

--CUBE
SELECT JOB_CODE,DEPT_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE,DEPT_CODE)
ORDER BY JOB_CODE,DEPT_CODE;

--------------------------------------------------------------------------------
/* 
    <집합 연산자>
    여러개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자
    
    - UNION : OR | 합집합
    - INTERSECT : AND | 교집합
    - UNION ALL : 합집합 + 교집합
    - MINUS : 차집합
*/

-----------------------------------1.UNION--------------------------------------
-- 부서코드가 D5인 사원 또는 급여 300만원 초과인 사원들 조회
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5';

SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY>3000000;

--UNION
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D5'
UNION
SELECT EMP_NAME,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY>3000000;

-- OR
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;

---------------------------2. INTERSECT ----------------------------------------
-- 부서코드가 D5이면서 급여가 300만원 초과인 사원의 사번, 사원명, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 집합연산자 사용시 주의사항
-- 각 쿼리문의 SELECT절에는 동일한 컬럼이어야한다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, PHONE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- AND
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;

---------------------------3. UNION ALL ----------------------------------------
-- 부서코드가 D5이면서 급여가 300만원 초과인 사원의 사번, 사원명, 부서코드, 급여 조회
-- 여러개의 쿼리 결과를 모두 다 더해서 출력
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_NAME;

-------------------------------4. MINUS ----------------------------------------
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_ID;

-- AND
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;   -- D5인 사원들중에서 3백만원 이하인 사원

/*
    <join>
    두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
    조회결과는 하나의 결과물(result set)로 나옴
    
    - 관계형 데이터 베이스는 최소한의 데이터로 각각 테이블에 담고 있음
      (중복을 최소화하기 위해)
      => 관계형 데이터베이스에서는 SQL문을 이용한 테이블간의 "관계"를 맺는 방법
      
      - JOIN은 크게 "오라클전용구문"과 "ANSI구문" (ANSI == 미국국립표준협회)
      
      [JOIN 용어 정리]
                오라클 전용 구문     |       ANSI
    ------------------------------------------------------------------------
                등가조인            |   내부조인(INNER JOIN) => JOIN USING/ON
              (EQUAL JOIN)         |   자연조인(NATURAL JOIN) => JOIN USING
    ------------------------------------------------------------------------
                포괄조인          |   왼쪽 외부 조인(LEFT OUTER JOIN)
             (EQUAL JOIN)        |   오른쪽 외부 조인(RIGHT OUTER JOIN)
             (RIGHT OUTER)       |   전체 외부 조인(FULL OUTER JOIN)
    ------------------------------------------------------------------------   
             자체조인(SELF JOIN)   |   JOIN ON
      비등가 조인(NON EQUAL JOIN)  |    
    ------------------------------------------------------------------------   
     카테시안곱(CARTESIAN RPODUCT) |   교차조인(CROSS JOIN)
     
*/
-- 전체 사원의 사번, 사원명, 부서코드, 부서명을 조회
SELECT EMP_ID,EMP_NAME,DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_TITLE
FROM DEPARTMENT;

-- 전체 사원의 사번,사원명,직급코드,직급명을 조회
SELECT EMP_ID,EMP_NAME,JOB_CODE
FROM EMPLOYEE;

SELECT JOB_NAME
FROM JOB;

--------------------------------------------------------------------------------
/*
    1. 등가조인(EQUAL JOIN / 내부조인(INNER JOIN)
       연결시키는 컬럼의 값이 "일치하는 행들만" 조인되어 조회
*/
-- >> 오라클 전용구문
-- FROM절에 조회하고자 하는 테이블들을 나열
-- WHERE절에 매칭시킬 컬럼(연결고리)에 대한 조건 제시

--1) 연결할 두컬럼명이 서로 다른 경우(EMPLOYEE : DEPT_CODE, DEPARTMENT:DEPT_ID)
-- 전체 사원의 사번,사원명,부서코드,부서명을 조회

SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT;
-- 인사관리부를 23번,회계관리부 23번....

SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- 일치하는 값이 없는 행은 조회에서 제회

--2) 연결할 두컬럼명이 같은 경우(EMPLOYEE:JOB_CODE,JOB:JOB_CODE)
-- 전체 사원의 사번,사원명,직급코드,직급명을 조회
SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE,JOB
WHERE JOB_CODE=JOB_CODE;

-- 해결방법1)테이블명을 이용하는 방법
SELECT EMP_ID,EMP_NAME,EMPLOYEE.JOB_CODE,JOB_NAME
FROM EMPLOYEE,JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 해결방법2)테이블에 별칭을 부여하여 이용하는 방법
SELECT EMP_ID,EMP_NAME,E.JOB_CODE,JOB_NAME
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- >> ANSI 구문
-- FROM절에 기준이 되는 테이블을 하나 기술한 후
-- JOIN절에 같이 조회하고자하는 테이블 기술 + 매칭시킬 컬럼에 대한 조건도 기술
-- JOIN USING, JOIN ON

-- 1)연결할 투컬럼명이 서로 다른 경우(EMPLOYEE: DEPT_CODE, DEPRATMENT: DEPT:ID)
-- 전체 사원의 사번,사원명,부서코드,부서명을 조회
SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPRATMENT ON(DEPT_CODE=DEPT_ID);

--2) 연결할 두컬럼명이 같은 경우(EMPLOYEE:JOB_CODE,JOB:JOB_CODE)
-- 전체 사원의 사번,사원명,직급코드, 직급명을 조회
SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE
JOIN JOB ON(JOB_CODE=JOB_CODE);

-- 해결방법 1) 테이블에 테이블명 또는 별칭을 이용하는 방법
SELECT EMP_ID,EMP_NAME,EMPLOYEE.JOB_CODE,JOB_NAME
FROM EMPLOYEE
JOIN JOB ON(EMPLOYEE.JOB_CODE=JOB.JOB_CODE);

-- 해결방법 2) JOIN USING구문 사용하는 방법(두 컬럼이 일치할 때만 사용가능)
SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- [참고]
-- NATURAL JOIN : 공통된 컬럼을 자동으로 매칭시켜줌
-- 공통된 컬럼은 한번만 반환
SELECT EMP_ID,EMP_NAME,JOB_CODE,JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- 3) 추가적인 조건도 제시 가능
-- 직급이 대리인 사원의 사번,사원명,직급명,급여 조회
-- >> 오라클 전용 구문
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE E,JOB J
WHERE E.JOB_CODE = J.JOB_CODE
      AND JOB_NAME = '대리';

-->> ANSI 구문
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리';

---------------------------------  실습 문제  -----------------------------------
-- 모든 문제는 오라클 전용 구문과 ANSI 구문 2가지 모두 다 하기

-- 1. 부서가 인사관리부인 사원들의 사번, 이름, 부서명, 보너스 조회
-- >> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, BONUS
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
      AND DEPT_TITLE = '인사관리부';

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';

-- 2. DEPARTMENT과 LOCATION을 참고하여 전체 부서의 부서코드, 부서명, 지역코드, 지역명 조회
-- >> 오라클 전용 구문
SELECT DEPT_ID,DEPT_TITLE,LOCAL_CODE,LOCAL_NAME
FROM DEPARTMENT,LOCATION
WHERE LOCAL_CODE = LOCATION_ID;

-->> ANSI 구문
SELECT DEPT_ID,DEPT_TITLE,LOCAL_CODE,LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID);

-- 3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
-- >> 오라클 전용 구문
SELECT EMP_ID,EMP_NAME, BONUS,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
      AND BONUS IS NOT NULL;
      
-->> ANSI 구문
SELECT EMP_ID,EMP_NAME, BONUS,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4. 부서가 총무부가 아닌 사원들의 사원명, 급여, 부서명 조회
-- >> 오라클 전용 구문
SELECT EMP_NAME,SALARY,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
      AND DEPT_TITLE != '총무부';
      
-->> ANSI 구문
SELECT EMP_NAME,SALARY,DEPT_CODE,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE != '총무부';

================================================================================
--                              2.포괄 조인
================================================================================
/*
    * 포괄조인 / 외부조인 (OUTER JOIN)
      두 테이블간의 JOIN시 일치하지 않는 행도 포함시켜 조회
      단, 반드시 LEFT / RIGHT를 지정해야 함(기준이 되는 테이블 지정)
*/

-- 모든 사원의 사원명,부서명,급여,연봉(부서를 배치받지 못한 사원도 조회)
SELECT EMP_NAME,DEPT_TITLE,SALARY,SALARY*12 연봉
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
--부서배치가 안된 사원 2명은 제외

--1)LEFT [OUTER] JOIN : 두 테이블 중 왼쪽에 기술된 테이블을 기준으로 JOIN
-->> ANSI 구문
SELECT EMP_NAME,DEPT_TITLE,SALARY,SALARY*12 연봉
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- >> 오라클 전용 구문
SELECT EMP_NAME,DEPT_TITLE,SALARY,SALARY*12 연봉
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- 기준이 되는 테이블의 반대편 테이블 컬럼의 뒤에(+)를 붙여줌

-- 2) RIGHT [OUTER] JOIN : 두 테이블 중 오른쪽에 기술된 테이블을 기준으로 JOIN
-->> ANSI 구문
SELECT EMP_NAME,DEPT_TITLE,SALARY,SALARY*12 연봉
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- >> 오라클 전용 구문
SELECT EMP_NAME,DEPT_TITLE,SALARY,SALARY*12 연봉
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID; -- 기준이 되는 테이블의 반대편 테이블 컬럼의 뒤에(+)를 붙여줌

-- 3) FULL [OUTER] JOIN : 두 테이블이 가진 모든 행 조회(오라클 전용구문은 사용 못함)
SELECT EMP_NAME,DEPT_TITLE,SALARY,SALARY*12 연봉
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

================================================================================
--                       3. 비등가 조인 (NON EQUAL JOIN)
================================================================================
/*
    * 비등가 조인
      매칠시킬 컬럼에 대한 조건 작성시 '='를 사용하지 않는 JOIN 문
      ANSI구문으로는 JOIN ON 으로만 가능
*/
-- 모든 사원들의 사원명,급여,급여레벨 조회
-->> 오라클 전영 구문
SELECT EMP_NAME,SALARY,SAL_LEVEL
FROM EMPLOYEE,SAL-GRADE
WHERE SALARY >= MIN_SAL AND SALALY <= MAX_SAL;

-->> ANSI 구문
SELECT EMP_NAME,SALARY,SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALRY,BETWEEN, MIN_SAL,AND MAX_SAL;

================================================================================
--                       4. 자체 조인 (SELF JOIN)
================================================================================
/*
    * 자체 조인(SELF JOIN)
      같은 테이블을 다시 한번 조인하는 경우
*/
-- 전체 사원의 사번, 사원명, 부서코드,                               (EMPLOYEE E 조회) 
--                                    사수사번, 사수명, 사수부서코드  (EMPLOYEE M 조회)
-->> 오라클 전용 구문
-- 사수가 있는 사원만 조회
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, M.EMP_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

-- 모든사원 조회
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, M.EMP_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+);

-->> ANSI 구문
SELECT E.EMP_ID, E.EMP_NAME, E.DEPT_CODE, M.EMP_ID, M.EMP_NAME, M.DEPT_CODE
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

================================================================================
--                                다중조인
================================================================================
/*
    2개 이상의 테이블을 JOIN 할 때
*/
-- 사번,사원명,부서명,직급명
/*
    EMPLOYEE        DEPT_CODE   JOB_CODE
    DEPARTMENT      DEPT_ID
    JOB                         JOB_CODE
*/

-->> 오라클 전용 구문
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,JOB_NAME
FROM EMPLOYEE E,DEPARTMENT D,JOB J
WHERE DEPT_CODE = DEPT_ID
      AND E.JOB_CODE = J.JOB_CODE;

-->> ANSI 구문
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,JOB_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

-- 사번,사원명,부서명,지역명 조회
/*
    EMPLOYEE        DEPT_CODE   
    DEPARTMENT      DEPT_ID     LOCATION_ID
    LOCATION                    LOCAL_CODE
*/
-->> 오라클 전용 구문
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE,DEPARTMENT,LOCATION
WHERE DEPT_CODE = DEPT_ID
    AND LOCATION_ID = LOCAL_CODE;

 -->> ANSI 구문 
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);
 
--------------------------------  실습 문제  ------------------------------------
-- 1. 사번, 사원명, 부서명, 지역명, 국가명 조회(EMPLOYEE, DEPARTMENT, LOCATION, NATIONAL 조인)
-- >> 오라클 구문
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,L.LOCAL_NAME,N.NATIONAL_NAME
FROM EMPLOYEE,DEPARTMENT,LOCATION L,NATIONAL N
WHERE DEPT_CODE = DEPT_ID
    AND LOCATION_ID = LOCAL_CODE;
    AND L.NATIONAL_CODE = N.NATIONAL_CODE;
    
--  >> ANSI구문
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME,NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE);

-- 2. 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 급여등급 조회 (모든 테이블 다 조인)
-- >> 오라클 구문
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,JOB_NAME,LOCAL_NAME,NATIONAL_NAME,SAL_LEVEL
FROM EMPLOYEE E,DEPARTMENT D,LOCATION L,NATIONAL N,SAL_GRADE,JOB J
WHERE DEPT_CODE = DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE
    AND LOCATION_ID = LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND SALARY BETWEEN MIN_SAL AND MAX_SAL;

--  >> ANSI구문
 
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
JOIN SAL_GRADE ON(SALARY BETWEEN MIN_SAL AND MAX_SAL);
