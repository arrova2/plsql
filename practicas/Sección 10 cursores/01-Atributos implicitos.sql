-- IMPLICITOS, SON LOS CURSORES AUTOMÁTICOS, QUE SQL ABRE Y CIERRA POR UNA SENTENCIA
-- EXPLICITOS, SON LOS CURSORES QUE NOSOTROS CREAMOS, ABRIMOS, MANEJAMOS Y CERRAMOS
/*
SQL%ISOPEN -- FALSE ES PARA SABER SI UN CURSOR ESTA ABIERTO
SQL%FOUND -- ES PARA SABER SI EL CURSOR ENCONTRO ALGO
SQL%NOTFOUNT -- ES PARA SABER SI EL CURSOR NO ENCONTRÓ NADA
SQL%ROWCOUNT -- ES PARA SABER EL NÚMERO DE LINEAS QUE HAN SIDO AFECTADAS
*/
DECLARE
    X TEST.C1%TYPE;
BEGIN

    UPDATE TEST SET C2='PPPPPP' WHERE C1=10;
    -- SI EXISTE C1=10 ENTONCES MOSTRARA QUE UNA LINEA HA SIDO MODIFICADA
    -- SI NO LO ENCUENTRA MOSTRARÁ 0
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
    IF SQL%FOUND THEN
        -- SI HUBO UNA MODIFICACIÓN, ENTONCES MOSTRARÁ ESTE MENSAJE
        DBMS_OUTPUT.PUT_LINE('ENCONTRADO');
    END IF;
    IF SQL%NOTFOUND THEN
        -- SI NO HUBO UNA MODIFICACIÓN, ENTONCES MOSTRARÁ ESTE MENSAJE
        DBMS_OUTPUT.PUT_LINE('NO ENCONTRADO');
    END IF;
    SELECT C1 INTO X FROM TEST WHERE C1=1000;
    -- ESTE NO PASA, YA QUE AL NO ENCONTRAR UN ROW CON ESTA BUSQUEDA Y AL LLEVAR EL INTO
    -- NOS LANZA UNA EXCEPCION Y YA NO ENTRA LAS SIGUIENTES LINEAS
    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('FILA NO EXISTENTE');
    END IF;
END;