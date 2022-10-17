CREATE TABLE payment.ipgstatuslink (
    id bigint NOT NULL,
    statusid integer NOT NULL,
    pgstatusid integer NOT NULL
);
ALTER TABLE ONLY payment.ipgstatuslink
    ADD CONSTRAINT ipgstatuslink_pkey PRIMARY KEY (statusid, pgstatusid);
