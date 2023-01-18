/*Práctica de COLECCIONES y RECORDS
• Creamos un TYPE RECORD que tenga las siguientes columnas
NAME VARCHAR2(100),
SAL EMPLOYEES.SALARY%TYPE,
COD_DEPT EMPLOYEES.DEPARTMENT_ID%TYPE);
• Creamos un TYPE TABLE basado en el RECORD anterior
• Mediante un bucle cargamos en la colección los empleados. El campo NAME 
debe contener FIRST_NAME y LAST_NAME concatenado.
• Para cargar las filas y siguiendo un ejemplo parecido que hemos visto en el 
vídeo usamos el EMPLOYEE_ID que va de 100 a 206
• A partir de este momento y ya con la colección cargada, hacemos las siguientes 
operaciones, usando métodos de la colección.
• Visualizamos toda la colección
• Visualizamos el primer empleado
• Visualizamos el último empleado
• Visualizamos el número de empleados
• Borramos los empleados que ganan menos de 7000 y visualizamos de 
nuevo la colección
• Volvemos a visualizar el número de empleados para ver cuantos se han 
borrad */
SET SERVEROUTPUT ON

DECLARE
    TYPE empl_record IS RECORD (
        name     VARCHAR2(100),
        sal      employees.salary%TYPE,
        cod_dept employees.department_id%TYPE
    );
    TYPE empl_table IS
        TABLE OF empl_record INDEX BY PLS_INTEGER;
    empl empl_table;
BEGIN
    FOR i IN 100..206 LOOP
        SELECT
            first_name
            || ' '
            || last_name,
            salary,
            department_id
        INTO
            empl
        (i)
        FROM
            employees
        WHERE
            employee_id = i;

    END LOOP;

    FOR i IN empl.first..empl.last LOOP
        dbms_output.put_line(empl(i).name
                             || ' '
                             || empl(i).sal
                             || ' 
'
                             || empl(i).cod_dept);
    END LOOP;

    dbms_output.put_line('EL PRIMERO');
    dbms_output.put_line(empl(empl.first).name);
    dbms_output.put_line('EL ÚLTIMO');
    dbms_output.put_line(empl(empl.last).name);
    dbms_output.put_line('BORRAMOS LOS EMPLEADOS QUE GANEN MENOS DE 7000');
    dbms_output.put_line('ANTES');
    dbms_output.put_line(empl.count);
    FOR i IN empl.first..empl.last LOOP
        IF empl(i).sal < 7000 THEN
            empl.DELETE(i);
        END IF;
    END LOOP;

    dbms_output.put_line('DESPUES');
    dbms_output.put_line(empl.count);
END;