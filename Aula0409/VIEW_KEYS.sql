DROP VIEW IF EXISTS vw_emp_idade_dep;

CREATE VIEW vw_emp_idade_dep 
AS SELECT 
	emp.nome as empregado
    ,format(datediff(now(), emp.dt_admissao) /365, 0) as tempo_empresa
    ,format(datediff(now(), emp.dt_nascimento) /365, 0) as idade_empregado
    ,emp.sexo as sexo_empregado
    ,dep.nome as dependente
    ,emp.salario as renda
    ,format(datediff(now(), dep.dt_nascimento) /365, 0) as idade_dependente
    ,dep.sexo as sexo_dependente
FROM
	empregado emp
    ,dependente dep
WHERE
	emp.cod_emp = dep.cod_emp;

