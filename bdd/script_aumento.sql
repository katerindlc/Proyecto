

CREATE TABLE clientes
(
  id SERIAL NOT NULL PRIMARY KEY,
  cedula VARCHAR(10) NULL,
  nombres TEXT,
  apellidos TEXT
);

CREATE TABLE factura
(
  id serial NOT NULL PRIMARY KEY,
  ref_cliente int,
  fecha date default now(),
  total numeric(18,2) default 0
);

CREATE TABLE detallefactura
(
  id serial NOT NULL PRIMARY KEY,
  ref_factura int default 0,
  ref_producto int default 0,
  cantidad int default 0,
  precio numeric(18,2) default 0,
  subtotal numeric(18,2) default 0
);


CREATE OR REPLACE FUNCTION funcionaactualdetalle() RETURNS trigger AS $funcionaactualdetalle$ 
DECLARE 


BEGIN

update detallefactura set subtotal=cantidad*precio  where ref_factura=NEW.ref_factura;
update factura set total=(select sum(subtotal) from detallefactura where ref_factura=NEW.ref_factura) WHERE id=NEW.ref_factura;

return null;
END;
$funcionaactualdetalle$ LANGUAGE plpgsql;

----------crear trigger
create trigger actual_actualdetalle after insert on detallefactura
for each row execute procedure funcionaactualdetalle();
