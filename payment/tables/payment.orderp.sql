CREATE TABLE payment.orderp (
    orderid bigint NOT NULL,
    orderno text,
    maxordersrno integer,
    ordertxndate timestamp with time zone,
    clientorderid character varying(100),
    amount numeric(18,2),
    clientid bigint,
    emailid character varying(100),
    mobileno character varying(100),
    extraparam text,
    pgproviderid bigint,
    pgid integer,
    reqpaymodeid integer,
    reqconveniencefee numeric(18,2),
    respaymode text,
    resamount numeric(18,2),
    orderstatusid integer,
    pgreftxnid character varying(100),
    bankreftxnid character varying(100)
);
ALTER TABLE ONLY payment.orderp
    ADD CONSTRAINT orderp_pkey PRIMARY KEY (orderid);
