CREATE TABLE payment.mpaymodepgproviderlink (
    paymodeid integer,
    pgproviderid bigint,
    paymodecode character varying(100),
    paymodeicon text,
    mobpaymodecode character varying(100)
);
ALTER TABLE ONLY payment.mpaymodepgproviderlink
    ADD CONSTRAINT fk_mpaymodepgproviderlinkpaymodeid FOREIGN KEY (paymodeid) REFERENCES payment.ipaymode(paymodeid);
ALTER TABLE ONLY payment.mpaymodepgproviderlink
    ADD CONSTRAINT fk_mpaymodepgproviderlinkpgproviderid FOREIGN KEY (pgproviderid) REFERENCES payment.mpgproviderconfig(pgproviderid);
