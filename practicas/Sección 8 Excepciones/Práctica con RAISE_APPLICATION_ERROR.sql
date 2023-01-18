/*Práctica con RAISE_APPLICATION_ERROR
1. Modificar la practica anterior para disparar un error con RAISE_APPLICATION 
en vez de con PUT_LINE.
a. Esto permite que la aplicación pueda capturar y gestionar el error que 
devuelve el PL/SQ*/
SET SERVEROUTPUT ON
DECLARE
    ID_REGION REGIONS.REGION_ID%TYPE := 210;
    NOMBRE_REGION REGIONS.REGION_NAME%TYPE := 'MILPA ALTA';
BEGIN
    
    IF ID_REGION > 200 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Codigo no permitido. Debe ser inferior a 200');
    END IF;
    
    INSERT INTO REGIONS (REGION_ID, REGION_NAME) VALUES (ID_REGION, NOMBRE_REGION);
    
EXCEPTION
    when others then
        dbms_output.put_line(SQLcode);
        dbms_output.put_line(SQLERRM);
END;