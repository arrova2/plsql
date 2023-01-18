/*Práctica de PAQUETES
1. Crear un paquete denominado REGIONES que tenga los 
siguientes componentes:
• PROCEDIMIENTOS:
• - ALTA_REGION, con parámetro de código y nombre Región. 
Debe devolver un error si la región ya existe. Inserta una nueva 
región en la tabla. Debe llamar a la función EXISTE_REGION 
para controlarlo.
• - BAJA_REGION, con parámetro de código de región y que 
debe borrar una región. Debe generar un error si la región no 
existe, Debe llamar a la función EXISTE_REGION para 
controlarlo
• - MOD_REGION: se le pasa un código y el nuevo nombre de la 
región Debe modificar el nombre de una región ya existente. 
Debe generar un error si la región no existe, Debe llamar a la 
función EXISTE_REGION para controlarlo
• FUNCIONES
• CON_REGION. Se le pasa un código de región y devuelve el 
nombre
• EXISTE_REGION. Devuelve verdadero si la región existe. Se 
usa en los procedimientos y por tanto es PRIVADA, no debe 
aparecer en la especificación del paquete*/
CREATE OR REPLACE PACKAGE PREGIONES
IS
  PROCEDURE ALTA_REGION (CODIGO REGIONS.REGION_ID%TYPE, NOMBRE_REGION VARCHAR2);
  PROCEDURE BAJA_REGION (CODIGO REGIONS.REGION_ID%TYPE);
  PROCEDURE MOD_REGION (CODIGO REGIONS.REGION_ID%TYPE, NOMBRE_REGION VARCHAR2);
  FUNCTION CON_REGION (CODIGO REGIONS.REGION_ID%TYPE) RETURN VARCHAR2;
END;
/

CREATE OR REPLACE PACKAGE BODY PREGIONES
IS

-- -----------------
FUNCTION EXISTE_REGION (CODIGO IN REGIONS.REGION_ID%TYPE, NOMBRE_REGION IN VARCHAR2) RETURN BOOLEAN
IS
    COD_REG REGIONS.REGION_ID%TYPE;
    NOM_REG REGIONS.REGION_NAME%TYPE;

BEGIN
    SELECT REGION_ID, NOMBRE_REGION INTO COD_REG, NOM_REG FROM REGIONS WHERE REGION_ID = CODIGO AND REGION_NAME = NOMBRE_REGION;
    RETURN TRUE;
EXCEPTION
WHEN NO_DATA_FOUND THEN
       RETURN FALSE;
END EXISTE_REGION;

-- -----------------
PROCEDURE ALTA_REGION(CODIGO IN REGIONS.REGION_ID%TYPE, NOMBRE_REGION IN VARCHAR2)
IS
BEGIN

    IF EXISTE_REGION(CODIGO, NOMBRE_REGION) THEN
        DBMS_OUTPUT.PUT_LINE('YA SE ENCUENTRA REGISTRADO ESTE CÓDIGO');
    ELSE
        INSERT INTO REGIONS (REGION_ID, REGION_NAME) VALUES 
        (CODIGO, UPPER(NOMBRE_REGION));
    END IF;

EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line('La ID YA EXISTE (duplicada)');
END ALTA_REGION;


-- ----------------
PROCEDURE BAJA_REGION (CODIGO IN REGIONS.REGION_ID%TYPE)
IS
    NOM REGIONS.REGION_ID%TYPE;
BEGIN

    SELECT REGION_NAME INTO NOM FROM REGIONS WHERE REGION_ID = CODIGO;

    IF EXISTE_REGION(CODIGO, NOM) THEN
        DELETE FROM regions WHERE
            REGION_ID = CODIGO;
        dbms_output.put_line('Región con ID ' || CODIGO || ' borrada');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('La región no existe!');
END BAJA_REGION;

-- -------------------
PROCEDURE MOD_REGION(CODIGO IN REGIONS.REGION_ID%TYPE, NOMBRE_REGION IN VARCHAR2)
IS
BEGIN
    IF EXISTE_REGION(CODIGO, NOMBRE_REGION) THEN
        UPDATE REGIONS SET REGION_ID = CODIGO, REGION_NAME = NOMBRE_REGION WHERE REGION_ID = CODIGO;
    END IF;
    
END MOD_REGION;

FUNCTION CON_REGION (CODIGO IN REGIONS.REGION_ID%TYPE) RETURN VARCHAR2
 IS
    NOM_REG REGIONS.REGION_NAME%TYPE;
 BEGIN

    SELECT REGION_NAME INTO NOM_REG FROM REGIONS WHERE REGION_ID = CODIGO;
    RETURN NOM_REG;

 EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('La región no existe!');
END CON_REGION;

END PREGIONES;
/

SET SERVEROUTPUT ON
DECLARE
    NOMBRE VARCHAR2(100);
BEGIN
    -- PREGIONES.MOD_REGION(7,'pikachutotal');
    -- Pregiones.baja_region(10);
    -- Pregiones.alta_region(10,'Prueba');
    NOMBRE := PREGIONES.CON_REGION(10);
    dbms_output.put_line(NOMBRE);

END;

/*2. Crear un paquete denominado NOMINA que tenga sobrecargado 
la función CALCULAR_NOMINA de la siguiente forma:
• CALCULAR_NOMINA(NUMBER): se calcula el salario del 
empleado restando un 15% de IRPF.
• CALCULAR_NOMINA(NUMBER,NUMBER): el segundo 
parámetro es el porcentaje a aplicar. Se calcula el salario del 
empleado restando ese porcentaje al salario
• CALCULAR_NOMINA(NUMBER,NUMBER,CHAR): el segundo 
parámetro es el porcentaje a aplicar, el tercero vale ‘V’ . Se 
calcula el salario del empleado aumentando la comisión que le 
pertenece y restando ese porcentaje al salario siempre y 
cuando el empleado tenga comisión.*/

CREATE OR REPLACE PACKAGE nomina IS
    FUNCTION calcular_nomina (
        id NUMBER
    ) RETURN NUMBER;

    FUNCTION calcular_nomina (
        id         NUMBER,
        porcentaje VARCHAR
    ) RETURN NUMBER;

    FUNCTION calcular_nomina (
        id         NUMBER,
        porcentaje NUMBER,
        tercero    VARCHAR2 := 'V'
    ) RETURN NUMBER;

END nomina;

CREATE OR REPLACE PACKAGE BODY nomina IS
--PRIMERA FUNCION
    FUNCTION calcular_nomina (
        id NUMBER
    ) RETURN NUMBER IS
        salario_final NUMBER;
        salario       NUMBER;
    BEGIN
        SELECT
            salary
        INTO salario
        FROM
            employees
        WHERE
            employee_id = id;

        salario_final := salario - ( salario * 0.15 );
        RETURN salario_final;
    END;
--SEGUNDA FUNCION
    FUNCTION calcular_nomina (
        id         NUMBER,
        porcentaje VARCHAR
    ) RETURN NUMBER IS
        salario_final NUMBER;
        salario       NUMBER;
    BEGIN
        SELECT
            salary
        INTO salario
        FROM
            employees
        WHERE
            employee_id = id;

        salario_final := salario - ( salario * ( TO_NUMBER ( porcentaje ) / 100 ) );
        RETURN salario_final;
    END;
--TERCERA FUNCION
    FUNCTION calcular_nomina (
        id         NUMBER,
        porcentaje NUMBER,
        tercero    VARCHAR2 := 'V'
    ) RETURN NUMBER IS
        salario_final NUMBER;
        comision      NUMBER;
        salario       NUMBER;
    BEGIN
        SELECT
            salary
        INTO salario
        FROM
            employees
        WHERE
            employee_id = id;

        SELECT
            commission_pct
        INTO comision
        FROM
            employees
        WHERE
            employee_id = id;

        salario_final := salario - ( salario * ( porcentaje / 100 ) ) + ( salario * comision );

        RETURN salario_final;
    END;

END nomina;

DECLARE
    x NUMBER;
BEGIN
    x := nomina.calcular_nomina(150, '8');
    dbms_output.put_line(x);
END;