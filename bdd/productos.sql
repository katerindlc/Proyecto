--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.14
-- Dumped by pg_dump version 9.5.14

-- Started on 2018-12-10 11:52:29

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
--SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2148 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 188 (class 1255 OID 640269)
-- Name: funcionaactualdetalle(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.funcionaactualdetalle() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE 


BEGIN

update detallefactura set subtotal=cantidad*precio;
update factura set total=(select sum(subtotal) from detallefactura where ref_factura=NEW.ref_factura);

return null;
END;
$$;


ALTER FUNCTION public.funcionaactualdetalle() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 187 (class 1259 OID 640286)
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id integer NOT NULL,
    cedula character varying(10),
    nombres text,
    apellidos text
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 640284)
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clientes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clientes_id_seq OWNER TO postgres;

--
-- TOC entry 2149 (class 0 OID 0)
-- Dependencies: 186
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;


--
-- TOC entry 185 (class 1259 OID 640258)
-- Name: detallefactura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detallefactura (
    id integer NOT NULL,
    ref_factura integer DEFAULT 0,
    ref_producto integer DEFAULT 0,
    cantidad integer DEFAULT 0,
    precio numeric(18,2) DEFAULT 0,
    subtotal numeric(18,2) DEFAULT 0
);


ALTER TABLE public.detallefactura OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 640256)
-- Name: detallefactura_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detallefactura_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.detallefactura_id_seq OWNER TO postgres;

--
-- TOC entry 2150 (class 0 OID 0)
-- Dependencies: 184
-- Name: detallefactura_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detallefactura_id_seq OWNED BY public.detallefactura.id;


--
-- TOC entry 183 (class 1259 OID 640248)
-- Name: factura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.factura (
    id integer NOT NULL,
    ref_cliente integer,
    fecha date DEFAULT now(),
    total numeric(18,2) DEFAULT 0
);


ALTER TABLE public.factura OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 640246)
-- Name: factura_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.factura_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.factura_id_seq OWNER TO postgres;

--
-- TOC entry 2151 (class 0 OID 0)
-- Dependencies: 182
-- Name: factura_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.factura_id_seq OWNED BY public.factura.id;


--
-- TOC entry 181 (class 1259 OID 637142)
-- Name: producto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producto (
    codigo integer NOT NULL,
    nombre character varying NOT NULL,
    precio double precision NOT NULL,
    cantidad integer NOT NULL
);


ALTER TABLE public.producto OWNER TO postgres;

--
-- TOC entry 2009 (class 2604 OID 640289)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);


--
-- TOC entry 2003 (class 2604 OID 640261)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detallefactura ALTER COLUMN id SET DEFAULT nextval('public.detallefactura_id_seq'::regclass);


--
-- TOC entry 2000 (class 2604 OID 640251)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura ALTER COLUMN id SET DEFAULT nextval('public.factura_id_seq'::regclass);


--
-- TOC entry 2139 (class 0 OID 640286)
-- Dependencies: 187
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2152 (class 0 OID 0)
-- Dependencies: 186
-- Name: clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_id_seq', 1, false);


--
-- TOC entry 2137 (class 0 OID 640258)
-- Dependencies: 185
-- Data for Name: detallefactura; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2153 (class 0 OID 0)
-- Dependencies: 184
-- Name: detallefactura_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detallefactura_id_seq', 1, false);


--
-- TOC entry 2135 (class 0 OID 640248)
-- Dependencies: 183
-- Data for Name: factura; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2154 (class 0 OID 0)
-- Dependencies: 182
-- Name: factura_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.factura_id_seq', 1, false);


--
-- TOC entry 2133 (class 0 OID 637142)
-- Dependencies: 181
-- Data for Name: producto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.producto (codigo, nombre, precio, cantidad) VALUES (1, 'computador', 720.29999999999995, 10);
INSERT INTO public.producto (codigo, nombre, precio, cantidad) VALUES (2, 'mouse usb', 4.25, 40);
INSERT INTO public.producto (codigo, nombre, precio, cantidad) VALUES (3, 'teclado', 7.5, 30);
INSERT INTO public.producto (codigo, nombre, precio, cantidad) VALUES (556, 'Pila', 0.69999999999999996, 3);
INSERT INTO public.producto (codigo, nombre, precio, cantidad) VALUES (22, 'PANTALLA 17"', 80, 5);
INSERT INTO public.producto (codigo, nombre, precio, cantidad) VALUES (11, 'DISCO DURO', 95, 6);
INSERT INTO public.producto (codigo, nombre, precio, cantidad) VALUES (33, 'disco', 67, 6);
INSERT INTO public.producto (codigo, nombre, precio, cantidad) VALUES (444, 'CONEXTOR USB', 63, 4);
INSERT INTO public.producto (codigo, nombre, precio, cantidad) VALUES (888, 'jjj', 4, 1);
INSERT INTO public.producto (codigo, nombre, precio, cantidad) VALUES (8, '8', 8, 8);
INSERT INTO public.producto (codigo, nombre, precio, cantidad) VALUES (55, '5', 5, 5);


--
-- TOC entry 2017 (class 2606 OID 640294)
-- Name: clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- TOC entry 2015 (class 2606 OID 640268)
-- Name: detallefactura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detallefactura
    ADD CONSTRAINT detallefactura_pkey PRIMARY KEY (id);


--
-- TOC entry 2013 (class 2606 OID 640255)
-- Name: factura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.factura
    ADD CONSTRAINT factura_pkey PRIMARY KEY (id);


--
-- TOC entry 2011 (class 2606 OID 637149)
-- Name: producto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producto
    ADD CONSTRAINT producto_pkey PRIMARY KEY (codigo);


--
-- TOC entry 2018 (class 2620 OID 640270)
-- Name: actual_actualdetalle; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER actual_actualdetalle AFTER INSERT ON public.detallefactura FOR EACH ROW EXECUTE PROCEDURE public.funcionaactualdetalle();


--
-- TOC entry 2147 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-12-10 11:52:29

--
-- PostgreSQL database dump complete
--

