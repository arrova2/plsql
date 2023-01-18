/*Práctica de FUNCIONES
1. Crear una función que tenga como parámetro un número de 
departamento y que devuelve la suma de los salarios de dicho 
departamento. La imprimimos por pantalla.
• Si el departamento no existe debemos generar una excepción 
con dicho mensaje
• Si el departamento existe, pero no hay empleados dentro, 
también debemos generar una excepción para indicarlo*/
CREATE OR REPLACE FUNCTION SUMA_SALARIOS (
    ID_DEPARTAMENTO IN DEPARTMENTS.DEPARTMENT_ID%TYPE
)
RETURN NUMBER
IS
    SALARIO NUMBER;
    ID_DEP DEPARTMENTS.DEPARTMENT_ID%TYPE;
    NUM_EMPL NUMBER;
BEGIN

    SELECT DEPARTMENT_ID INTO ID_DEP FROM DEPARTMENTS WHERE DEPARTMENT_ID = ID_DEPARTAMENTO;

    SELECT COUNT(*) INTO NUM_EMPL 
    FROM EMPLOYEES WHERE DEPARTMENT_ID = ID_DEP;

    IF NUM_EMPL > 0 THEN
        SELECT SUM(SALARY) INTO SALARIO FROM EMPLOYEES WHERE DEPARTMENT_ID = ID_DEP;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'EL DEPARTAMENTO NO TIENE EMPLEADOS');
    END IF;

    RETURN SALARIO;
    -- IF NOT EXISTS SELECT DEPARTAMENT_ID FROM DEPARTMENT WHERE DEPARTMENT_ID = ID_DEPARTAMENTO;
    --     RAISE_APPLICATION_ERROR(-20001, "EL DEPARTAMENTO NO EXISTE");
    -- END IF;

EXCEPTION
    when no_data_found then raise_application_error (-20730,'No existe el departamento ' || ID_DEP);
END;
/

SET SERVEROUTPUT ON
DECLARE
    DEPARTAMENTO NUMBER;
    SALARIO NUMBER;
BEGIN
    DEPARTAMENTO := 1;
    
    SALARIO:=SUMA_SALARIOS(DEPARTAMENTO);
    DBMS_OUTPUT.PUT_LINE(SALARIO);

END;
/


/*2. Modificar el programa anterior para incluir un parámetro de tipo OUT por 
el que vaya el número de empleados afectados por la query. Debe ser 
visualizada en el programa que llama a la función. De esta forma vemos 
que se puede usar este tipo de parámetros también en una función*/
CREATE OR REPLACE FUNCTION SUMA_SALARIOS (
    ID_DEPARTAMENTO IN DEPARTMENTS.DEPARTMENT_ID%TYPE,
    NUM_EMPL OUT NUMBER
)
RETURN NUMBER
IS
    SALARIO NUMBER;
    ID_DEP DEPARTMENTS.DEPARTMENT_ID%TYPE;
BEGIN

    SELECT DEPARTMENT_ID INTO ID_DEP FROM DEPARTMENTS WHERE DEPARTMENT_ID = ID_DEPARTAMENTO;

    SELECT COUNT(*) INTO NUM_EMPL 
    FROM EMPLOYEES WHERE DEPARTMENT_ID = ID_DEP;

    IF NUM_EMPL > 0 THEN
        SELECT SUM(SALARY) INTO SALARIO FROM EMPLOYEES WHERE DEPARTMENT_ID = ID_DEP;
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'EL DEPARTAMENTO NO TIENE EMPLEADOS');
    END IF;

    RETURN SALARIO;
    -- IF NOT EXISTS SELECT DEPARTAMENT_ID FROM DEPARTMENT WHERE DEPARTMENT_ID = ID_DEPARTAMENTO;
    --     RAISE_APPLICATION_ERROR(-20001, "EL DEPARTAMENTO NO EXISTE");
    -- END IF;

EXCEPTION
    when no_data_found then raise_application_error (-20730,'No existe el departamento ' || ID_DEP);
END;
/

SET SERVEROUTPUT ON
DECLARE
    DEPARTAMENTO NUMBER;
    SALARIO NUMBER;
    NUM_EMPL NUMBER;
BEGIN
    DEPARTAMENTO := 10;
    
    SALARIO:=SUMA_SALARIOS(DEPARTAMENTO, NUM_EMPL);
    DBMS_OUTPUT.PUT_LINE(SALARIO||' '||NUM_EMPL);

END;
/

/*3. Crear una función llamada CREAR_REGION,
• A la función se le debe pasar como parámetro un nombre de 
región y debe devolver un número, que es el código de región 
que calculamos dentro de la función
• Se debe crear una nueva fila con el nombre de esa REGION
• El código de la región se debe calcular de forma automática. 
Para ello se debe averiguar cual es el código de región más 
alto que tenemos en la tabla en ese momento, le sumamos 1 y 
el resultado lo ponemos como el código para la nueva región 
que estamos creando.
• Si tenemos algún problema debemos generar un error
• La función debe devolver el número que ha asignado a la región*/
Create or replace FUNCTION CREAR_REGION (nombre varchar2) 
    RETURN NUMBER IS
    regiones NUMBER;
    NOM_REGION VARCHAR2(100);
BEGIN
    --AVERIGUAR SI EXISTE LA REGIÓN. SI YA EXISTE DAMOS ERROR. SI NO EXISTE PASAMOS A EXCEPTION Y SEGUIMOS CON EL PROGRAMA
    SELECT REGION_NAME INTO NOM_REGION FROM REGIONS 
    WHERE REGION_NAME=UPPER(NOMBRE);
    raise_application_error(-20321,'Esta región ya existe!');
EXCEPTION
    -- SI LA REGION NO EXISTE LA INSERTAMOS. ES UN EJEMPLO DE COMO PODEMOS USAR LA EXCEPCION PARA HACER ALGO CORRECTO
    WHEN NO_DATA_FOUND THEN
    SELECT MAX(REGION_ID)+1 INTO REGIONES from REGIONS;
    INSERT INTO REGIONS (region_id,region_name) VALUES 
    (regiones,upper(nombre));
    RETURN REGIONES;
END;
/
--PROBAR LA FUNCIÓN
SET SERVEROUTPUT ON
DECLARE
    N_REGION NUMBER;
BEGIN
    N_REGION:=crear_region('NORMANDIA');
    DBMS_OUTPUT.PUT_LINE('EL NUMERO ASIGNADO ES:'||N_REGION);
END;
