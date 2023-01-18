-- Sentencias de Pl SQL

-- Para leer un archivo sql ya una vez logueado es:
start tablas_hr.sql

-- Para poder ver los nombres de las tablas podemos poner:
SELECT TNAME FROM TAB;

-- Para desbloquear al usuario HR ponemos:
ALTER USER HR ACCOUNT UNLOCK;

-- Para cambiarle el password al usuario ponemos:
ALTER USER HR IDENTIFIED BY hr;

-- Para saber la fecha actual ponermos;
SELECT SYSDATE FROM DUAL;

-- BLOQUES ANÓNIMOS

-- Bloque nónimo nulo
BEGIN
NULL;

END;

-- Para poder visualizar salídas en un bloque anónimo
SET SERVEROUTPUT ON
BEGIN

    -- Para imprimir números
    DBMS_OUTPUT.PUT_LINE(100);

    -- Para imprimir letras
    DBMS_OUTPUT.PUT_LINE('AAAA');

    -- Para concatenar
    DBMS_OUTPUT.PUT_LINE('AAAA'||' XXXXXX');

END;

-- Uso de variables
SET SERVEROUTPUT ON
DECLARE
    NAME VARCHAR2(100);
    LASTNAME VARCHAR(100);

BEGIN
    -- Se igualan con :=
    NAME := 'JOHN';
    LASTNAME := 'CONNORS';
    -- Para imprimir números
    DBMS_OUTPUT.PUT_LINE(NAME);

    -- Para imprimir letras
    DBMS_OUTPUT.PUT_LINE(LASTNAME);

    -- Para concatenar
    DBMS_OUTPUT.PUT_LINE(NAME||' '|| LASTNAME);

END;

-- CONSTANTES Y NULL
-- FORMATEAR CON CTRL F7
SET SERVEROUTPUT ON
DECLARE
    X CONSTANT NUMBER := 10;
    Z NUMBER NOT NULL := 20;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE(X);
    Z := 30;
    DBMS_OUTPUT.PUT_LINE(Z);

END;

-- BOOLEANAS
DECLARE 
    BL BOOLEAN;
BEGIN
    BL:=TRUE;
    BL:=FALSE;
    BL:=NULL;
END;

-- %TYPE FUNCIONA PARA ASIGNARLE EL MISMO TIPO A UNA
-- VARIABLE DE UN CAMPO 
SET SERVEROUTPUT ON
DECLARE
    X NUMBER;
    Z X%TYPE:
    EMPLE EMPLOYEES.SALARY%TYPE;
BEGIN
    EMPLE := 100;
    DBMS_OUTPUT.PUT_LINE(EMPLE);
END;

-- Ejemplo 2
DECLARE
    impuesto  CONSTANT NUMBER := 21;
    precio    NUMBER(5, 2);
    resultado precio%TYPE;
BEGIN
    precio := 100.50;
    resultado := precio * impuesto / 100;
    dbms_output.put_line(resultado);
END;

-- Al tener variables globales pueden ser accedidas por componentes hijos, pero no al reves
SET SERVEROUTPUT ON

DECLARE
    x   NUMBER := 20;  --GLOBAL
    Z   NUMBER:=30;
BEGIN
    dbms_output.put_line('X:='|| x);
    DECLARE
        x   NUMBER := 10;  --LOCAL
        z   number:=100;
        y number:=200;
    BEGIN
        dbms_output.put_line('X:='|| x);
        dbms_output.put_line('Z:='|| Z);
    END;
    dbms_output.put_line('Y:='|| y);   
END;


SET SERVEROUTPUT ON
DECLARE
    X NUMBER:=10;
BEGIN
    DBMS_OUTPUT.PUT_LINE(X);
    DECLARE
        X NUMBER:=20;
        BEGIN
            DBMS_OUTPUT.PUT_LINE(X);
        END;
        DBMS_OUTPUT.PUT_LINE(X);
END;

-- Impresión:
-- 10
-- 20
-- 10