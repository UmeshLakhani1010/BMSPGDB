CREATE TABLE payment.ipaymentgateway (
    pgid integer NOT NULL,
    pgname character varying(100) NOT NULL,
    pgiconname text
);
ALTER TABLE ONLY payment.ipaymentgateway
    ADD CONSTRAINT ipgid_pkey PRIMARY KEY (pgid);
