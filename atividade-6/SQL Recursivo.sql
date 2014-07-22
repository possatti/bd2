-- Exemplo de recursão do wikipedia
/*
WITH RECURSIVE tempf (n, fact) AS 
(SELECT 0, 1 -- Initial Subquery
  UNION ALL 
 SELECT n+1, (n+1)*fact FROM tempf -- Recursive Subquery 
        WHERE n < 9)
SELECT * FROM tempf;
*/

-- CTE
WITH RECURSIVE temp (n, ename, job, empno, mgr) AS
(
	SELECT 1, ename, job, empno, mgr
	FROM emp WHERE mgr IS NULL
		UNION ALL
	SELECT t.n+1, e.ename, e.job, e.empno, e.mgr
	FROM emp e, temp t WHERE e.mgr = t.empno
)

SELECT * FROM temp;
