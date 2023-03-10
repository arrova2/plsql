DECLARE
 empl employees%rowtype;
  CURSOR cur IS SELECT * FROM employees FOR UPDATE;
BEGIN
  OPEN cur;
  LOOP
    FETCH cur INTO empl;
    EXIT   WHEN cur%notfound;
    IF EMPL.COMMISSION_PCT IS NOT NULL THEN
        -- EL CURRENT OF ES PARA ACTUALIZAR EL REGISTRO ACTUAL
        UPDATE employees SET SALARY=SALARY*1.10 WHERE CURRENT OF cur;
    ELSE
        -- EL CURRENT OF ES PARA ACTUALIZAR EL REGISTRO ACTUAL
        UPDATE employees SET SALARY=SALARY*1.15 WHERE CURRENT OF cur;
    END IF;
  END LOOP;
 
  CLOSE cur;
END;

/