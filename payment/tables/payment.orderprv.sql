CREATE TABLE payment.orderprv (
    orderid bigint NOT NULL,
    orderno text,
    maxordersrno integer,
    ordertxndate timestamp with time zone,
    clientorderid character varying(100),
    amount numeric(18,2),
    clientid bigint
);
