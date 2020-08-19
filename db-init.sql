--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2 (Debian 12.2-2.pgdg100+1)
-- Dumped by pg_dump version 12.2

-- Started on 2020-07-24 03:18:33 ADT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2 (class 3079 OID 16525)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 3104 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 733 (class 1247 OID 32840)
-- Name: BILLING_STATUS; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."BILLING_STATUS" AS ENUM (
    'CANCELLED',
    'CONFIRMED',
    'PENDING'
);


ALTER TYPE public."BILLING_STATUS" OWNER TO postgres;

--
-- TOC entry 742 (class 1247 OID 32863)
-- Name: CURRENCY; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."CURRENCY" AS ENUM (
    'CAD',
    'BRL'
);


ALTER TYPE public."CURRENCY" OWNER TO postgres;

--
-- TOC entry 693 (class 1247 OID 24731)
-- Name: ORDER_STATUS; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ORDER_STATUS" AS ENUM (
    'CANCELLED',
    'CREATED',
    'RESERVED',
    'SHIPPED',
    'DELIVERED',
    'COMPLETED'
);


ALTER TYPE public."ORDER_STATUS" OWNER TO postgres;

--
-- TOC entry 696 (class 1247 OID 24758)
-- Name: PAYMENT_STATUS; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."PAYMENT_STATUS" AS ENUM (
    'CANCELLED',
    'CREATED',
    'AUTHORIZED',
    'CAPTURED'
);


ALTER TYPE public."PAYMENT_STATUS" OWNER TO postgres;

--
-- TOC entry 723 (class 1247 OID 32818)
-- Name: PAYMENT_TYPE; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."PAYMENT_TYPE" AS ENUM (
    'STRIPE'
);


ALTER TYPE public."PAYMENT_TYPE" OWNER TO postgres;

--
-- TOC entry 668 (class 1247 OID 24583)
-- Name: PRODUCT_TYPE; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."PRODUCT_TYPE" AS ENUM (
    'SHOE',
    'CASE'
);


ALTER TYPE public."PRODUCT_TYPE" OWNER TO postgres;

--
-- TOC entry 686 (class 1247 OID 24701)
-- Name: SHIPPING_TYPE; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."SHIPPING_TYPE" AS ENUM (
    'REGULAR',
    'EXPRESS'
);


ALTER TYPE public."SHIPPING_TYPE" OWNER TO postgres;

--
-- TOC entry 711 (class 1247 OID 32775)
-- Name: TAX_TYPE; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TAX_TYPE" AS ENUM (
    'CANADA',
    'BRAZIL'
);


ALTER TYPE public."TAX_TYPE" OWNER TO postgres;

--
-- TOC entry 700 (class 1247 OID 24779)
-- Name: UNIT_TYPE; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."UNIT_TYPE" AS ENUM (
    'SHOE',
    'CASE'
);


ALTER TYPE public."UNIT_TYPE" OWNER TO postgres;

--
-- TOC entry 233 (class 1255 OID 16647)
-- Name: stockcount(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.stockcount(product_sku uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_ptype "PRODUCT_TYPE";
	v_result INTEGER;
BEGIN
	SELECT "TYPE" INTO v_ptype FROM "PRODUCT" WHERE "SKU"=product_sku;
	
	IF v_ptype = 'SHOES' THEN
		SELECT SUM("STOCK") INTO v_result FROM "PRODUCT_SHOES" WHERE "SKU"=product_sku;
		RETURN v_result;
	END IF;
	
	RETURN 0;
END
$$;


ALTER FUNCTION public.stockcount(product_sku uuid) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 203 (class 1259 OID 16536)
-- Name: ADDRESS; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ADDRESS" (
    "ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "STREET" text NOT NULL,
    "CITY" text NOT NULL,
    "COUNTRY" text NOT NULL,
    "STATE" text NOT NULL,
    "POSTAL_CODE" text NOT NULL
);


ALTER TABLE public."ADDRESS" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 32834)
-- Name: BILLING; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."BILLING" (
    "ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "ADDRESS" uuid NOT NULL,
    "PAYMENT" uuid NOT NULL,
    "TAX" uuid NOT NULL,
    "STATUS" public."BILLING_STATUS" NOT NULL
);


ALTER TABLE public."BILLING" OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 24691)
-- Name: CUSTOMER; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."CUSTOMER" (
    "ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "NAME" text NOT NULL,
    "EMAIL" text NOT NULL
);


ALTER TABLE public."CUSTOMER" OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 24744)
-- Name: ITEM; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ITEM" (
    "ORDER" uuid NOT NULL,
    "UNIT" uuid NOT NULL,
    "QUANTITY" numeric DEFAULT 1 NOT NULL,
    "PRICE" uuid NOT NULL
);


ALTER TABLE public."ITEM" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16543)
-- Name: ORDER; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ORDER" (
    "ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "DATE" timestamp(0) with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "SHIPPING" uuid,
    "CUSTOMER" uuid NOT NULL,
    "STATUS" public."ORDER_STATUS" DEFAULT 'CREATED'::public."ORDER_STATUS" NOT NULL,
    "BILLING" uuid NOT NULL
);


ALTER TABLE public."ORDER" OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16552)
-- Name: PAYMENT; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PAYMENT" (
    "ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "HANDLER" public."PAYMENT_TYPE" NOT NULL
);


ALTER TABLE public."PAYMENT" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 32821)
-- Name: PAYMENT_STRIPE; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PAYMENT_STRIPE" (
    "ID" uuid NOT NULL,
    "CLIENT_SECRET" text NOT NULL,
    "INTENT" text NOT NULL,
    "STATUS" public."PAYMENT_STATUS" NOT NULL
);


ALTER TABLE public."PAYMENT_STRIPE" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 32867)
-- Name: PRICING; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PRICING" (
    "ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "PRICE" integer NOT NULL,
    "CURRENCY" public."CURRENCY" NOT NULL
);


ALTER TABLE public."PRICING" OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16560)
-- Name: PRODUCT; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PRODUCT" (
    "ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "NAME" text NOT NULL,
    "DESCRIPTION" text,
    "TYPE" public."PRODUCT_TYPE" NOT NULL
);


ALTER TABLE public."PRODUCT" OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24790)
-- Name: PRODUCT_CASE; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PRODUCT_CASE" (
    "ID" uuid NOT NULL,
    "ARTIST" text NOT NULL
);


ALTER TABLE public."PRODUCT_CASE" OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 24586)
-- Name: PRODUCT_SHOE; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PRODUCT_SHOE" (
    "ID" uuid NOT NULL,
    "ARTIST" text
);


ALTER TABLE public."PRODUCT_SHOE" OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 24705)
-- Name: SHIPPING; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SHIPPING" (
    "ADDRESS" uuid NOT NULL,
    "TRACKING" text,
    "TYPE" public."SHIPPING_TYPE" DEFAULT 'REGULAR'::public."SHIPPING_TYPE" NOT NULL,
    "ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "PRICE" uuid NOT NULL
);


ALTER TABLE public."SHIPPING" OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 24680)
-- Name: STOCK; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."STOCK" (
    "UNIT" uuid NOT NULL,
    "QUANTITY" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public."STOCK" OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 32779)
-- Name: TAX; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TAX" (
    "ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "TYPE" public."TAX_TYPE" NOT NULL
);


ALTER TABLE public."TAX" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 32795)
-- Name: TAX_BRAZIL; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TAX_BRAZIL" (
    "ID" uuid NOT NULL,
    "VALUE" integer NOT NULL
);


ALTER TABLE public."TAX_BRAZIL" OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 32785)
-- Name: TAX_CANADA; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TAX_CANADA" (
    "ID" uuid NOT NULL,
    "IS_HARMONIZED" boolean NOT NULL,
    "HARMONIZED_TAX" integer NOT NULL,
    "FEDERAL_TAX" integer NOT NULL,
    "PROVINCIAL_TAX" integer NOT NULL
);


ALTER TABLE public."TAX_CANADA" OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 24600)
-- Name: UNIT; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UNIT" (
    "PRODUCT" uuid NOT NULL,
    "ID" uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "TYPE" public."UNIT_TYPE" NOT NULL
);


ALTER TABLE public."UNIT" OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24798)
-- Name: UNIT_CASE; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UNIT_CASE" (
    "ID" uuid NOT NULL,
    "DEVICE" text NOT NULL
);


ALTER TABLE public."UNIT_CASE" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 32913)
-- Name: UNIT_PRICE; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UNIT_PRICE" (
    "UNIT" uuid NOT NULL,
    "PRICE" uuid NOT NULL
);


ALTER TABLE public."UNIT_PRICE" OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 24641)
-- Name: UNIT_SHOE; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UNIT_SHOE" (
    "ID" uuid NOT NULL,
    "SIZE" numeric NOT NULL
);


ALTER TABLE public."UNIT_SHOE" OWNER TO postgres;

--
-- TOC entry 2918 (class 2606 OID 16582)
-- Name: ADDRESS ADDRESS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ADDRESS"
    ADD CONSTRAINT "ADDRESS_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2948 (class 2606 OID 32838)
-- Name: BILLING BILLING_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BILLING"
    ADD CONSTRAINT "BILLING_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2932 (class 2606 OID 24699)
-- Name: CUSTOMER CUSTOMER_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."CUSTOMER"
    ADD CONSTRAINT "CUSTOMER_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2920 (class 2606 OID 16584)
-- Name: ORDER ORDER_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORDER"
    ADD CONSTRAINT "ORDER_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2946 (class 2606 OID 32828)
-- Name: PAYMENT_STRIPE PAYMENT_STRIPE_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PAYMENT_STRIPE"
    ADD CONSTRAINT "PAYMENT_STRIPE_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2922 (class 2606 OID 16586)
-- Name: PAYMENT PAYMENT_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PAYMENT"
    ADD CONSTRAINT "PAYMENT_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2950 (class 2606 OID 32872)
-- Name: PRICING PRICING_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRICING"
    ADD CONSTRAINT "PRICING_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2936 (class 2606 OID 24797)
-- Name: PRODUCT_CASE PRODUCT_CASE_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRODUCT_CASE"
    ADD CONSTRAINT "PRODUCT_CASE_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2926 (class 2606 OID 24594)
-- Name: PRODUCT_SHOE PRODUCT_SHOES_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRODUCT_SHOE"
    ADD CONSTRAINT "PRODUCT_SHOES_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2924 (class 2606 OID 16588)
-- Name: PRODUCT PRODUCT_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRODUCT"
    ADD CONSTRAINT "PRODUCT_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2934 (class 2606 OID 24714)
-- Name: SHIPPING SHIPPING_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SHIPPING"
    ADD CONSTRAINT "SHIPPING_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2944 (class 2606 OID 32799)
-- Name: TAX_BRAZIL TAX_BRAZIL_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TAX_BRAZIL"
    ADD CONSTRAINT "TAX_BRAZIL_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2942 (class 2606 OID 32789)
-- Name: TAX_CANADA TAX_CANADA_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TAX_CANADA"
    ADD CONSTRAINT "TAX_CANADA_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2940 (class 2606 OID 32784)
-- Name: TAX TAX_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TAX"
    ADD CONSTRAINT "TAX_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2938 (class 2606 OID 24805)
-- Name: UNIT_CASE UNIT_CASE_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UNIT_CASE"
    ADD CONSTRAINT "UNIT_CASE_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2930 (class 2606 OID 24648)
-- Name: UNIT_SHOE UNIT_SOLID_SHOE_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UNIT_SHOE"
    ADD CONSTRAINT "UNIT_SOLID_SHOE_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2928 (class 2606 OID 24630)
-- Name: UNIT UNIT_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UNIT"
    ADD CONSTRAINT "UNIT_pkey" PRIMARY KEY ("ID");


--
-- TOC entry 2968 (class 2606 OID 32847)
-- Name: BILLING BILLING_ADDRESS_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BILLING"
    ADD CONSTRAINT "BILLING_ADDRESS_fkey" FOREIGN KEY ("ADDRESS") REFERENCES public."ADDRESS"("ID") NOT VALID;


--
-- TOC entry 2969 (class 2606 OID 32852)
-- Name: BILLING BILLING_PAYMENT_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BILLING"
    ADD CONSTRAINT "BILLING_PAYMENT_fkey" FOREIGN KEY ("PAYMENT") REFERENCES public."PAYMENT"("ID") NOT VALID;


--
-- TOC entry 2970 (class 2606 OID 32857)
-- Name: BILLING BILLING_TAX_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BILLING"
    ADD CONSTRAINT "BILLING_TAX_fkey" FOREIGN KEY ("TAX") REFERENCES public."TAX"("ID") NOT VALID;


--
-- TOC entry 2960 (class 2606 OID 32898)
-- Name: ITEM ITEM_ORDER_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ITEM"
    ADD CONSTRAINT "ITEM_ORDER_fkey" FOREIGN KEY ("ORDER") REFERENCES public."ORDER"("ID") NOT VALID;


--
-- TOC entry 2962 (class 2606 OID 32908)
-- Name: ITEM ITEM_PRICE_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ITEM"
    ADD CONSTRAINT "ITEM_PRICE_fkey" FOREIGN KEY ("PRICE") REFERENCES public."PRICING"("ID") NOT VALID;


--
-- TOC entry 2961 (class 2606 OID 32903)
-- Name: ITEM ITEM_UNIT_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ITEM"
    ADD CONSTRAINT "ITEM_UNIT_fkey" FOREIGN KEY ("UNIT") REFERENCES public."UNIT"("ID") NOT VALID;


--
-- TOC entry 2951 (class 2606 OID 32883)
-- Name: ORDER ORDER_BILLING_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORDER"
    ADD CONSTRAINT "ORDER_BILLING_fkey" FOREIGN KEY ("BILLING") REFERENCES public."BILLING"("ID") NOT VALID;


--
-- TOC entry 2953 (class 2606 OID 32893)
-- Name: ORDER ORDER_CUSTOMER_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORDER"
    ADD CONSTRAINT "ORDER_CUSTOMER_fkey" FOREIGN KEY ("CUSTOMER") REFERENCES public."CUSTOMER"("ID") NOT VALID;


--
-- TOC entry 2952 (class 2606 OID 32888)
-- Name: ORDER ORDER_SHIPPING_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ORDER"
    ADD CONSTRAINT "ORDER_SHIPPING_fkey" FOREIGN KEY ("SHIPPING") REFERENCES public."SHIPPING"("ID") NOT VALID;


--
-- TOC entry 2967 (class 2606 OID 32829)
-- Name: PAYMENT_STRIPE PAYMENT_STRIPE_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PAYMENT_STRIPE"
    ADD CONSTRAINT "PAYMENT_STRIPE_ID_fkey" FOREIGN KEY ("ID") REFERENCES public."PAYMENT"("ID");


--
-- TOC entry 2963 (class 2606 OID 24811)
-- Name: PRODUCT_CASE PRODUCT_CASE_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRODUCT_CASE"
    ADD CONSTRAINT "PRODUCT_CASE_ID_fkey" FOREIGN KEY ("ID") REFERENCES public."PRODUCT"("ID") NOT VALID;


--
-- TOC entry 2954 (class 2606 OID 24595)
-- Name: PRODUCT_SHOE PRODUCT_SHOES_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PRODUCT_SHOE"
    ADD CONSTRAINT "PRODUCT_SHOES_ID_fkey" FOREIGN KEY ("ID") REFERENCES public."PRODUCT"("ID");


--
-- TOC entry 2959 (class 2606 OID 32878)
-- Name: SHIPPING SHIPPING_ADDRESS_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SHIPPING"
    ADD CONSTRAINT "SHIPPING_ADDRESS_fkey" FOREIGN KEY ("ADDRESS") REFERENCES public."ADDRESS"("ID") NOT VALID;


--
-- TOC entry 2958 (class 2606 OID 32873)
-- Name: SHIPPING SHIPPING_PRICE_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SHIPPING"
    ADD CONSTRAINT "SHIPPING_PRICE_fkey" FOREIGN KEY ("PRICE") REFERENCES public."PRICING"("ID") NOT VALID;


--
-- TOC entry 2957 (class 2606 OID 24686)
-- Name: STOCK STOCK_ENTRY_UNIT_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."STOCK"
    ADD CONSTRAINT "STOCK_ENTRY_UNIT_fkey" FOREIGN KEY ("UNIT") REFERENCES public."UNIT"("ID");


--
-- TOC entry 2966 (class 2606 OID 32812)
-- Name: TAX_BRAZIL TAX_BRAZIL_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TAX_BRAZIL"
    ADD CONSTRAINT "TAX_BRAZIL_ID_fkey" FOREIGN KEY ("ID") REFERENCES public."TAX"("ID") NOT VALID;


--
-- TOC entry 2965 (class 2606 OID 32807)
-- Name: TAX_CANADA TAX_CANADA_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TAX_CANADA"
    ADD CONSTRAINT "TAX_CANADA_ID_fkey" FOREIGN KEY ("ID") REFERENCES public."TAX"("ID") NOT VALID;


--
-- TOC entry 2964 (class 2606 OID 24806)
-- Name: UNIT_CASE UNIT_CASE_VARIATION_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UNIT_CASE"
    ADD CONSTRAINT "UNIT_CASE_VARIATION_fkey" FOREIGN KEY ("ID") REFERENCES public."UNIT"("ID");


--
-- TOC entry 2972 (class 2606 OID 32923)
-- Name: UNIT_PRICE UNIT_PRICE_PRICE_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UNIT_PRICE"
    ADD CONSTRAINT "UNIT_PRICE_PRICE_fkey" FOREIGN KEY ("PRICE") REFERENCES public."PRICING"("ID");


--
-- TOC entry 2971 (class 2606 OID 32918)
-- Name: UNIT_PRICE UNIT_PRICE_UNIT_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UNIT_PRICE"
    ADD CONSTRAINT "UNIT_PRICE_UNIT_fkey" FOREIGN KEY ("UNIT") REFERENCES public."UNIT"("ID");


--
-- TOC entry 2955 (class 2606 OID 24606)
-- Name: UNIT UNIT_PRODUCT_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UNIT"
    ADD CONSTRAINT "UNIT_PRODUCT_fkey" FOREIGN KEY ("PRODUCT") REFERENCES public."PRODUCT"("ID");


--
-- TOC entry 2956 (class 2606 OID 24773)
-- Name: UNIT_SHOE UNIT_SHOE_VARIATION_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UNIT_SHOE"
    ADD CONSTRAINT "UNIT_SHOE_VARIATION_fkey" FOREIGN KEY ("ID") REFERENCES public."UNIT"("ID") NOT VALID;


-- Completed on 2020-07-24 03:18:35 ADT

--
-- PostgreSQL database dump complete
--

