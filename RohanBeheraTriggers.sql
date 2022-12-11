DROP SEQUENCE IF EXISTS part_number_seq;
CREATE SEQUENCE part_number_seq START WITH 50000;

CREATE OR REPLACE LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION addNewPart()
    RETURNS "trigger" AS 
    $BODY$
    BEGIN
    NEW.part_number := nextval('part_number_seq');
    return NEW;
    END 
    $BODY$
    LANGUAGE plpgsql VOLATILE;

DROP TRIGGER IF EXISTS part_sfo_trigger ON part_sfo;

CREATE TRIGGER part_sfo_trigger BEFORE INSERT
ON part_sfo FOR EACH ROW
EXECUTE PROCEDURE addNewPart();

