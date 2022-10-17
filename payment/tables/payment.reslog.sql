CREATE TABLE payment.reslog (
    orderid bigint,
    recdetails text,
    recdetailsenc text,
    modifytimestamp timestamp with time zone DEFAULT now() NOT NULL
);
ALTER TABLE ONLY payment.reslog
    ADD CONSTRAINT fk_reslogorderid FOREIGN KEY (orderid) REFERENCES payment.orderp(orderid);
