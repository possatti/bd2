WITH RECURSIVE temp (n, ename, job, empno, mgr) AS
(
	SELECT 1, (LPAD(' ', 0) || ename), job, empno, mgr
	FROM emp WHERE mgr IS NULL
		UNION ALL
	SELECT t.n+1, (LPAD(' ', 2*(n)) || e.ename), e.job, e.empno, e.mgr
	FROM emp e, temp t WHERE e.mgr = t.empno
)

SELECT * FROM temp;
