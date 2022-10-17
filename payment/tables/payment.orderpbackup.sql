CREATE TABLE payment.orderpbackup (
    orderid bigint,
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
