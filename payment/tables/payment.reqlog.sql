CREATE TABLE payment.reqlog (
    orderid bigint,
    senddetails text,
    senddetailsenc text,
    modifytimestamp timestamp with time zone DEFAULT now() NOT NULL
);
ALTER TABLE ONLY payment.reqlog
    ADD CONSTRAINT fk_reqlogorderid FOREIGN KEY (orderid) REFERENCES payment.orderp(orderid);
