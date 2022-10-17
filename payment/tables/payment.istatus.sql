CREATE TABLE payment.istatus (
    statusid integer NOT NULL,
    status character varying(100) NOT NULL
);
ALTER TABLE ONLY payment.istatus
    ADD CONSTRAINT istatusid_pkey PRIMARY KEY (statusid);
