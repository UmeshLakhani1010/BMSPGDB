CREATE TABLE payment.mclientdetails (
    clientid bigint NOT NULL,
    creationdate timestamp with time zone,
    clientname character varying(100),
    clientsalt character varying(100),
    clientkey character varying(100),
    isactive boolean,
    clientlogo text,
    clientcompname character varying(100),
    clientwebsite character varying(100),
    clientcontactno character varying(100),
    clientconfigjson text
);
ALTER TABLE payment.mclientdetails ALTER COLUMN clientid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME payment.mclientdetails_clientid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE ONLY payment.mclientdetails
    ADD CONSTRAINT mclientdetails_pkey PRIMARY KEY (clientid);
