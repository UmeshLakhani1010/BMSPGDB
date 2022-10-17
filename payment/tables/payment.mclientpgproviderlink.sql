CREATE TABLE payment.mclientpgproviderlink (
    clientid bigint,
    pgproviderid bigint,
    uniquemerchantid character varying(100),
    seqno integer
);
ALTER TABLE ONLY payment.mclientpgproviderlink
    ADD CONSTRAINT fk_mclientpgproviderlinkclientid FOREIGN KEY (clientid) REFERENCES payment.mclientdetails(clientid);
ALTER TABLE ONLY payment.mclientpgproviderlink
    ADD CONSTRAINT fk_mpgproviderconfigpgid FOREIGN KEY (pgproviderid) REFERENCES payment.mpgproviderconfig(pgproviderid);
