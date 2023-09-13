CREATE VIEW vw_empregados_irpf
AS
SELECT
	emp.nome AS empregado
    ,emp.salario AS renda
    ,format((emp.salario * 13.35), 2) as renda_total
    ,CASE
		WHEN emp.salario<2112 THEN "Faixa 0"
        WHEN emp.salario<2826.65 THEN "Faixa 7,5"
        WHEN emp.salario<3751.05 THEN "Faixa 15,0"
        WHEN emp.salario<4664.68 THEN "Faixa 22.5"
		ELSE "Faixa 27.5"
    END AS IRPF
    ,CASE
		WHEN emp.salario<2112 THEN 0
        WHEN emp.salario<2826.65 THEN format((emp.salario * 0.075), 2)
        WHEN emp.salario<3751.05 THEN format((emp.salario * 0.15), 2)
        WHEN emp.salario<4664.68 THEN format((emp.salario * 0.225), 2)
		ELSE format((emp.salario * 0.275), 2)
    END AS valor_imposto
    ,count(dep.cod_dep) AS dependentes
FROM empregado emp
	,dependente dep
WHERE
	emp.cod_emp = dep.cod_emp
GROUP BY 
	emp.nome
	,emp.salario;

