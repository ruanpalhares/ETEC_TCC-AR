/*
SALARIO MINIMO 1320
CRIAR UMA VIEW PARA CALCULAR UMA ESCALA DE AUMENTO
CASO O EMPREGADO GANHE MAIS DE 5 SALARIOS MINIMOS ELE RECEBE 5% DE AUMENTO
CASO ELE GANHE ATE 3 SALARIOS E TENHA 1 DEPENDENTE OU MAIS ELE TERA 12%
POR FIM SE ELE GANHA MENOS DE 3 SALARIOS E TEM MAIS DE 3 DEPENDENTES RECEBE 33%
*/

CREATE VIEW vw_dicidio_salario
AS
SELECT
	emp.nome AS empregado
    ,emp.salario AS renda
    ,vw.dependentes as dependentes
    ,CASE
		WHEN emp.salario>6600 THEN format((emp.salario*0.05),2)
        WHEN emp.salario>3960 AND dependentes>=1 THEN format((emp.salario*0.12),2)
        WHEN emp.salario<3960 AND dependentes>=3 THEN format((emp.salario*0.33),2)
        ELSE 0
    END AS taxa_aumento
    ,CASE
		WHEN emp.salario>6600 THEN "5%"
        WHEN emp.salario>3960 AND dependentes>=1 THEN "12%"
        WHEN emp.salario<3960 AND dependentes>=3 THEN "33%"
        ELSE 0
    END AS percentual
FROM empregado emp
	,dependente dep
    ,vw_empregados_irpf vw
WHERE
	emp.cod_emp = dep.cod_emp
GROUP BY 
	emp.nome
	,emp.salario
    ,vw.dependentes;

SELECT * FROM vw_dicidio_salario;