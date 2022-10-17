CREATE TABLE payment.ipaymode (
    paymodeid integer NOT NULL,
    paymode character varying(100) NOT NULL,
    paymodedescription character varying(200),
    iconname character varying(100)
);
ALTER TABLE ONLY payment.ipaymode
    ADD CONSTRAINT ipaymodeid_pkey PRIMARY KEY (paymodeid);
