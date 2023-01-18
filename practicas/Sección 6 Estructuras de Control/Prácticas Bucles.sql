/*Prácticas Bucles
1. Práctica 1
• Vamos a crear la tabla de multiplicar del 1 al 10, con los tres tipos de 
bucles: LOOP, WHILE y FOR*/

-- LOOP
SET SERVEROUTPUT ON
DECLARE
    X NUMBER:=1;
    Y NUMBER;
BEGIN

    LOOP 
        Y:=1;
        DBMS_OUTPUT.PUT_LINE('Tabla de multiplicar del :'||X);
        LOOP
            DBMS_OUTPUT.PUT_LINE(X||' x '||Y||' = '|| X*Y);
            Y:=Y+1;
            EXIT WHEN Y>10;
        END LOOP;
        X:=X+1;
        EXIT WHEN X>10;
    END LOOP;

END;

-- WHILE
SET SERVEROUTPUT ON
DECLARE
    X NUMBER:=1;
    Y NUMBER;
BEGIN

    WHILE X <= 10 LOOP 
        DBMS_OUTPUT.PUT_LINE('Tabla de multiplicar del :'||X);
        Y:=1;
        WHILE Y <= 10 LOOP
            DBMS_OUTPUT.PUT_LINE(X||' x '||Y||' = '|| X*Y);
            Y:=Y+1;
        END LOOP;
        X:=X+1;
    END LOOP;

END;

-- FOR
SET SERVEROUTPUT ON
DECLARE
    X NUMBER:=1;
    Y NUMBER;
BEGIN

    FOR X IN 1..10 LOOP 
        DBMS_OUTPUT.PUT_LINE('Tabla de multiplicar del :'||X);
        FOR Y IN 1..10 LOOP
            DBMS_OUTPUT.PUT_LINE(X||' x '||Y||' = '|| X*Y);
        END LOOP;
    END LOOP;

END;
   --PLS_INTEGER

/*2. Práctica 2
• Crear una variable llamada TEXTO de tipo VARCHAR2(100).
• Poner alguna frase
• Mediante un bucle, escribir la frase al revés, Usamos el bucle WHILE*/
SET SERVEROUTPUT ON
DECLARE
    TEXTO VARCHAR2(100) := 'Hola mundo';
    TEXTO_INVERTIDO VARCHAR2(100) := '';
    TEXTLEN INTEGER;
BEGIN
    TEXTLEN := LENGTH(TEXTO);
    WHILE TEXTLEN > 0 LOOP
        -- DBMS_OUTPUT.PUT_LINE(SUBSTR(TEXTO,TEXTLEN,1));
        TEXTO_INVERTIDO := TEXTO_INVERTIDO||SUBSTR(TEXTO,TEXTLEN,1);
        TEXTLEN := TEXTLEN - 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(TEXTO_INVERTIDO);
END;
/*3. Práctica 3
• Usando la práctica anterior, si en el texto aparece el carácter "x" debe 
salir del bucle. Es igual en mayúsculas o minúsculas.
• Debemos usar la cláusula EXIT.*/
SET SERVEROUTPUT ON
DECLARE
    TEXTO VARCHAR2(100) := 'Hola mundo X pepe';
    TEXTO_INVERTIDO VARCHAR2(100) := '';
    LETRA VARCHAR2(1);
    TEXTLEN INTEGER;
BEGIN
    TEXTLEN := LENGTH(TEXTO);
    WHILE TEXTLEN > 0 LOOP
        -- DBMS_OUTPUT.PUT_LINE(SUBSTR(TEXTO,TEXTLEN,1));
        LETRA := SUBSTR(TEXTO,TEXTLEN,1);
        EXIT WHEN LETRA = 'X' OR LETRA = 'x';
        TEXTO_INVERTIDO := TEXTO_INVERTIDO||LETRA;
        TEXTLEN := TEXTLEN - 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(TEXTO_INVERTIDO);
END;
/*4. Práctica 4
• Debemos crear una variable llamada NOMBRE
• Debemos pintar tantos asteriscos como letras tenga el nombre. 
Usamos un bucle FOR
• Por ejemplo Alberto → *******
• O por ejemplo Pedro → ******/
SET SERVEROUTPUT ON
DECLARE
    TEXTO VARCHAR2(100) := 'Pepe';
    TEXTLEN INTEGER;
    CONTRASENIA VARCHAR2(100) := '';
    
BEGIN
    TEXTLEN := LENGTH(TEXTO);
    FOR X IN 1..TEXTLEN LOOP 
        CONTRASENIA := CONTRASENIA||'*';
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(CONTRASENIA);
END;
/*5. Práctica 5
• Creamos dos variables numéricas, "inicio y fin"
• Las inicializamos con algún valor:
• Debemos sacar los números que sean múltiplos de 4 de ese rango*/
SET SERVEROUTPUT ON
DECLARE
    INICIO NUMBER := 0;
    FINAL NUMBER := 20;
BEGIN
    FOR I IN INICIO..FINAL LOOP 
        CONTINUE WHEN I MOD 4 = 0;
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;