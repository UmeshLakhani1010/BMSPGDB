CREATE TABLE payment.ipgstatus (
    pgstatusid integer NOT NULL,
    pgstatus character varying(100) NOT NULL,
    pgid integer
);
ALTER TABLE ONLY payment.ipgstatus
    ADD CONSTRAINT ipgstatusid_pkey PRIMARY KEY (pgstatusid);
