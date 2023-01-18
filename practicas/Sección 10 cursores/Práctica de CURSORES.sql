/*Práctica de CURSORES
1. Hacer un programa que tenga un cursor que vaya visualizando los 
salarios de los empleados. Si en el cursor aparece el jefe (Steven 
King) se debe generar un RAISE_APPLICATION_ERROR indicando 
que el sueldo del jefe no se puede ver.*/
SET SERVEROUTPUT ON

DECLARE
    CURSOR empleados IS
    SELECT
        *
    FROM
        employees;

BEGIN
    FOR i IN empleados LOOP
        IF
            i.first_name = 'Steven'
            AND i.last_name = 'King'
        THEN
            raise_application_error(-20001, 'EL SUELDO DEL JEFE NO SE PUEDE VER');
        END IF;

        dbms_output.put_line(i.first_name
                             || ' '
                             || i.salary);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
END;
/

/*2. Hacemos un bloque con dos cursores. (Esto se puede hacer 
fácilmente con una sola SELECT pero vamos a hacerlo de esta 
manera para probar parámetros en cursores)
• El primero de empleados
• El segundo de departamentos que tenga como parámetro el 
MANAGER_ID
• Por cada fila del primero, abrimos el segundo curso pasando el ID del 
MANAGER
• Debemos pintar el Nombre del departamento y el nombre del 
MANAGER_ID
• Si el empleado no es MANAGER de ningún departamento debemos 
poner “No es jefe de nada”*/
SET SERVEROUTPUT ON
DECLARE
    CURSOR EMPLEADOS IS SELECT * FROM EMPLOYEES;
    CURSOR DEPARTAMENTOS(ID_MANAGER DEPARTMENTS.MANAGER_ID%TYPE) IS SELECT * FROM DEPARTMENTS 
        WHERE MANAGER_ID = ID_MANAGER;
    DEPARTAMENTO DEPARTMENTS%ROWTYPE;
BEGIN
    FOR EMPLEADO IN EMPLEADOS LOOP
        OPEN DEPARTAMENTOS(EMPLEADO.EMPLOYEE_ID);
        FETCH DEPARTAMENTOS INTO DEPARTAMENTO;
            IF DEPARTAMENTOS%NOTFOUND then
                DBMS_OUTPUT.PUT_LINE(EMPLEADO.FIRST_NAME ||' No es JEFE de NADA');
            ELSE
                DBMS_OUTPUT.PUT_LINE(EMPLEADO.FIRST_NAME || 'ES JEFE DEL DEPARTAMENTO '|| DEPARTAMENTO.DEPARTMENT_NAME);
            END IF;
        CLOSE DEPARTAMENTOS;
    END LOOP;
END;
/
/*3. Crear un cursor con parámetros que pasando el número de 
departamento visualice el número de empleados de ese 
departamento*/

SET SERVEROUTPUT ON
DECLARE
    CURSOR EMPLEADOS(ID_DEPARTAMENTO DEPARTMENTS.DEPARTMENT_ID%TYPE) IS SELECT COUNT(*) FROM EMPLOYEES 
        WHERE DEPARTMENT_ID = ID_DEPARTAMENTO;
    NUMERO_EMPLEADOS NUMBER;
BEGIN
    OPEN EMPLEADOS(50);
        FETCH EMPLEADOS INTO NUMERO_EMPLEADOS;
        DBMS_OUTPUT.PUT_LINE(NUMERO_EMPLEADOS);
    CLOSE EMPLEADOS;
END;
/

SELECT * FROM DEPARTMENTS;

/*4. Crear un bucle FOR donde declaramos una subconsulta que nos 
devuelva el nombre de los empleados que sean ST_CLERCK. Es 
decir, no declaramos el cursor sino que lo indicamos 
directamente en el FOR.*/

SET SERVEROUTPUT ON
BEGIN
    FOR EMPLEADOS IN (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'ST_CLERK') LOOP
        DBMS_OUTPUT.PUT_LINE(EMPLEADOS.FIRST_NAME||' '||EMPLEADOS.LAST_NAME);
    END LOOP;
END;
/

/*5. Creamos un bloque que tenga un cursor para empleados. 
Debemos crearlo con FOR UPDATE.
• Por cada fila recuperada, si el salario es mayor de 8000 
incrementamos el salario un 2%
• Si es menor de 800 lo hacemos en un 3%
• Debemos modificarlo con la cláusula CURRENT OF
• Comprobar que los salarios se han modificado correctamente
*/
SET SERVEROUTPUT ON
DECLARE 
    CURSOR EMPLEADOS IS SELECT * FROM EMPLOYEES FOR UPDATE;
    EMPLEADO EMPLOYEES%ROWTYPE;
BEGIN

  OPEN EMPLEADOS;
  LOOP
    FETCH EMPLEADOS INTO EMPLEADO;
        EXIT WHEN EMPLEADOS%NOTFOUND;
        IF EMPLEADO.SALARY > 8000 THEN
            UPDATE employees SET SALARY=SALARY*1.20 WHERE CURRENT OF EMPLEADOS;
        END IF;
        IF EMPLEADO.SALARY < 800 THEN
            UPDATE employees SET SALARY=SALARY*1.30 WHERE CURRENT OF EMPLEADOS;
        END IF;
  END LOOP;
 
  CLOSE EMPLEADOS;
END;

/

SELECT * FROM EMPLOYEES;