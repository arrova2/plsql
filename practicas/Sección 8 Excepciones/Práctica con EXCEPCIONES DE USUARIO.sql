/* Práctica con EXCEPCIONES DE USUARIO
1- Crear una Excepción personalizada denominada 
CONTROL_REGIONES.
• Debe dispararse cuando al insertar o modificar una región 
queramos poner una clave superior a 200. Por ejemplo usando una 
variable con ese valor.
• En ese caso debe generar un texto indicando algo así como 
“Codigo no permitido. Debe ser inferior a 200”
• Recordemos que las excepciones personalizadas deben 
dispararse de forma manual con el RAISE.*/
SET SERVEROUTPUT ON
DECLARE
    CONTROL_REGIONES EXCEPTION;
    ID_REGION REGIONS.REGION_ID%TYPE := 210;
    NOMBRE_REGION REGIONS.REGION_NAME%TYPE := 'MILPA ALTA';
BEGIN
    
    IF ID_REGION > 200 THEN
        RAISE CONTROL_REGIONES;
    END IF;
    
    INSERT INTO REGIONS (REGION_ID, REGION_NAME) VALUES (ID_REGION, NOMBRE_REGION);
    
EXCEPTION
    WHEN CONTROL_REGIONES THEN
        DBMS_OUTPUT.PUT_LINE('Codigo no permitido');
    when others then
        dbms_output.put_line(SQLcode);
        dbms_output.put_line(SQLERRM)

END;