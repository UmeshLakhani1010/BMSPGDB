CREATE TABLE payment.mpgproviderconfig (
    pgproviderid bigint NOT NULL,
    pgid integer,
    pgconfigjson text,
    isaggregator boolean
);
ALTER TABLE payment.mpgproviderconfig ALTER COLUMN pgproviderid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME payment.mpgproviderconfig_pgproviderid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
ALTER TABLE ONLY payment.mpgproviderconfig
    ADD CONSTRAINT mpgproviderconfig_pkey PRIMARY KEY (pgproviderid);
ALTER TABLE ONLY payment.mpgproviderconfig
    ADD CONSTRAINT fk_mpgproviderconfigpgid FOREIGN KEY (pgid) REFERENCES payment.ipaymentgateway(pgid);
