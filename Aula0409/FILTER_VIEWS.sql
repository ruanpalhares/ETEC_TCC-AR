SELECT 
    *
FROM
    vw_emp_idade_dep
WHERE
    (idade_dependente < 6)
        AND (renda > 3920)
        AND (sexo_empregado = 'F');