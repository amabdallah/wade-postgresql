﻿-- Table: "WADE"."SUMMARY_USE"

-- DROP TABLE "WADE"."SUMMARY_USE";

CREATE TABLE "WADE"."SUMMARY_USE"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- Unique identifier assigned to the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the report by the organization.
  "REPORT_UNIT_ID" character varying(35) NOT NULL, -- A unique identifier assigned to the reporting unit by the organization.
  "SUMMARY_SEQ" numeric(18,0) NOT NULL, -- A unique identifier for the use summary.
  "BENEFICIAL_USE_ID" numeric(18,0) NOT NULL, -- Unique identifier for the beneficial use.
  "FRESH_SALINE_IND" numeric(18,0) NOT NULL,
  "SOURCE_TYPE" numeric(18,0) NOT NULL,
  "POWER_GENERATED" numeric(18,3),
  "POPULATION_SERVED" numeric(18,3),
  "WFS_FEATURE_REF" character varying(35),
  CONSTRAINT "PK_SUMMARY_USE" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID", "SUMMARY_SEQ", "BENEFICIAL_USE_ID"),
  CONSTRAINT "FK_SUMMARY_USE-LU_BENEFICIAL_USE" FOREIGN KEY ("BENEFICIAL_USE_ID")
      REFERENCES "WADE"."LU_BENEFICIAL_USE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_SUMMARY_USE-LU_FRESH_SALINE_INDICATOR" FOREIGN KEY ("FRESH_SALINE_IND")
      REFERENCES "WADE"."LU_FRESH_SALINE_INDICATOR" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_SUMMARY_USE-LU_SOURCE_TYPE" FOREIGN KEY ("SOURCE_TYPE")
      REFERENCES "WADE"."LU_SOURCE_TYPE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_SUMMARY_USE-REPORTING_UNIT" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID")
      REFERENCES "WADE"."REPORTING_UNIT" ("ORGANIZATION_ID", "REPORT_ID", "REPORT_UNIT_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."SUMMARY_USE"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."SUMMARY_USE"
  IS 'Annual summary of water use within the reporting unit.';
COMMENT ON COLUMN "WADE"."SUMMARY_USE"."ORGANIZATION_ID" IS 'Unique identifier assigned to the organization.';
COMMENT ON COLUMN "WADE"."SUMMARY_USE"."REPORT_ID" IS 'A unique identifier assigned to the report by the organization.';
COMMENT ON COLUMN "WADE"."SUMMARY_USE"."REPORT_UNIT_ID" IS 'A unique identifier assigned to the reporting unit by the organization.';
COMMENT ON COLUMN "WADE"."SUMMARY_USE"."SUMMARY_SEQ" IS 'A unique identifier for the use summary.';
COMMENT ON COLUMN "WADE"."SUMMARY_USE"."BENEFICIAL_USE_ID" IS 'Unique identifier for the beneficial use.';


-- Index: "WADE"."FKI_SUMMARY_USE-LU_BENEFICIAL_USE"

-- DROP INDEX "WADE"."FKI_SUMMARY_USE-LU_BENEFICIAL_USE";

CREATE INDEX "FKI_SUMMARY_USE-LU_BENEFICIAL_USE"
  ON "WADE"."SUMMARY_USE"
  USING btree
  ("BENEFICIAL_USE_ID");

-- Index: "WADE"."FKI_SUMMARY_USE-LU_FRESH_SALINE_INDICATOR"

-- DROP INDEX "WADE"."FKI_SUMMARY_USE-LU_FRESH_SALINE_INDICATOR";

CREATE INDEX "FKI_SUMMARY_USE-LU_FRESH_SALINE_INDICATOR"
  ON "WADE"."SUMMARY_USE"
  USING btree
  ("FRESH_SALINE_IND");

-- Index: "WADE"."FKI_SUMMARY_USE-LU_SOURCE_TYPE"

-- DROP INDEX "WADE"."FKI_SUMMARY_USE-LU_SOURCE_TYPE";

CREATE INDEX "FKI_SUMMARY_USE-LU_SOURCE_TYPE"
  ON "WADE"."SUMMARY_USE"
  USING btree
  ("SOURCE_TYPE");

-- Index: "WADE"."FKI_SUMMARY_USE-REPORTING_UNIT"

-- DROP INDEX "WADE"."FKI_SUMMARY_USE-REPORTING_UNIT";

CREATE INDEX "FKI_SUMMARY_USE-REPORTING_UNIT"
  ON "WADE"."SUMMARY_USE"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "REPORT_UNIT_ID" COLLATE pg_catalog."default");
