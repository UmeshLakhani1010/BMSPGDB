CREATE TABLE payment.ordert (
    orderid bigint,
    ordersrno integer,
    orderstatusid integer,
    updatedatetime timestamp with time zone,
    callby character varying(100)
);
ALTER TABLE ONLY payment.ordert
    ADD CONSTRAINT fk_ordertorderid FOREIGN KEY (orderid) REFERENCES payment.orderp(orderid);
