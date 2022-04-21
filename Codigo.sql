-- Parte 1: 

drop database parte1;

create database parte1;

use parte1;

CREATE TABLE EMPLEADO (

  CEDULA INTEGER PRIMARY KEY,

  NOMBRE VARCHAR(50)

);

delimiter //

CREATE PROCEDURE INSERTA_EMPLEADO(IN idem char(50), IN nomb VARCHAR(50))

BEGIN

	IF idem REGEXP '^-?[0-9]+$' THEN

		IF char_length(idem) >= 8 and char_length(idem) <= 9 THEN

			IF nomb REGEXP '-?[A-Za-z]+$' THEN

				IF char_length(nomb) >= 3 and char_length(nomb) <= 30 THEN

					INSERT INTO EMPLEADO VALUES (idem, nomb);

                    select * from EMPLEADO;

				ELSE

					SELECT "El nombre debe tener un tamaño entre 3 y 30 dígitos" As Mensaje;

				END IF;

			ELSE

				SELECT "El nombre ingresado tiene caracteres especiales" As Mensaje;

			END IF;

        

		ELSE

			SELECT "El Id debe tener un tamaño entre 8 y 9 dígitos" As Mensaje;

		END IF;

    

	ELSE

		SELECT "El Id ingresado no es un valor númerico" As Mensaje;

    END IF;

END

//

delimiter ;

call INSERTA_EMPLEADO("Prueba","Carlos");

call INSERTA_EMPLEADO(123468,'Carlos');

call INSERTA_EMPLEADO(12345678,'@');

call INSERTA_EMPLEADO(12345678,'Carlos@=');

call INSERTA_EMPLEADO(12345678,'Carlos Perez');

call INSERTA_EMPLEADO(123456789,'Carlos');

call INSERTA_EMPLEADO(12345678,'34');

select * from EMPLEADO;

-- Parte 2:

drop database PROCEDIMIENTOS;

create database PROCEDIMIENTOS;

use PROCEDIMIENTOS;

create table BLOG(

ID_BLOG varchar(10) not null primary key,

FECHA datetime not null,

AUTOR varchar(50) not null,

TITULO varchar(50) not null,

CONTENIDO varchar(50) not null

);

create table NOTIFICACION(

ID int not null AUTO_INCREMENT,

ID_BLOG varchar(10) not null,

FECHA datetime not null,

NOTIFICACION varchar(80) not null,

primary key (ID),

FOREIGN KEY (ID_BLOG) REFERENCES BLOG(ID_BLOG)

);

-- Insertar blog con procedure:

delimiter //

CREATE PROCEDURE INSERTA_BLOG(IN id varchar(10), IN fech datetime , IN aut varchar(50), IN titu varchar(50), IN cont varchar(50))

BEGIN

	INSERT INTO BLOG VALUES (id,fech,aut,titu,cont);

    

    INSERT INTO NOTIFICACION VALUES (null,id,fech,"Nuevo Blog agregado");

END

//

delimiter ;

select * from NOTIFICACION;

select * from BLOG;

call INSERTA_BLOG("96542",now(),"Gabriel Garcia Marquez","Cien Años de Soledad","Libro de Drama");

select * from NOTIFICACION;

select * from BLOG;

-- Insertar blog con trigger:

create trigger insertar_Blog after insert on BLOG for each row insert into NOTIFICACION(ID_BLOG,FECHA,NOTIFICACION) values (new.ID_BLOG,now(),"nuevo");

select * from NOTIFICACION;

select * from BLOG;

insert into BLOG values("A002",now(),"Artur ","holmes","crimenes");

select * from NOTIFICACION;

select * from BLOG;

-- Eliminar con trigger:

CREATE TRIGGER Delete_Blog AFTER DELETE ON NOTIFICACION

FOR EACH ROW

DELETE FROM BLOG WHERE ID_BLOG = old.ID_BLOG;

select * from NOTIFICACION;

select * from BLOG;

DELETE FROM NOTIFICACION WHERE ID_BLOG="A002";

select * from NOTIFICACION;

select * from BLOG;
