--1.
SELECT DEPARTMENT_NO,STUDENT_NAME 이름,ENTRANCE_DATE 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO LIKE '002';

--15.
SELECT NVL(SUBSTR(TERM_NO,1,4),'')년도,NVL(SUBSTR(TERM_NO,5,2),'')학기,ROUND(AVG(POINT),1)평균
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,2));
