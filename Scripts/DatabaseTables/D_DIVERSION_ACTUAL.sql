﻿-- Table: "WADE"."D_DIVERSION_ACTUAL"

-- DROP TABLE "WADE"."D_DIVERSION_ACTUAL";

CREATE TABLE "WADE"."D_DIVERSION_ACTUAL"
(
  "ORGANIZATION_ID" character varying(10) NOT NULL, -- A unique identifier for the organization.
  "REPORT_ID" character varying(35) NOT NULL, -- A unique identifier for the report assigned by the reporting organization.
  "ALLOCATION_ID" character varying(60) NOT NULL, -- Unique identifier for the allocation.
  "DIVERSION_ID" character varying(35) NOT NULL,
  "DETAIL_SEQ_NO" numeric(18,0) NOT NULL, -- Unique identifier for the detail information.
  "ACTUAL_SEQ_NO" numeric(18,0) NOT NULL,
  "AMOUNT_VOLUME" numeric(18,3), -- Volume of water actually diverted at this diversion.
  "UNIT_VOLUME" numeric(18,0), -- Volume unit of measure
  "VALUE_TYPE_VOLUME" numeric(18,0), -- Indicator on how the actual amount was determined
  "METHOD_ID_VOLUME" numeric(18,0), -- ID referencing the method used to estimate the volume
  "AMOUNT_RATE" numeric(18,3), -- Rate of water actually diverted at this diversion.
  "UNIT_RATE" numeric(18,0), -- Unit of measure.
  "VALUE_TYPE_RATE" numeric(18,0), -- Indicator on how the actual amount was determined
  "METHOD_ID_RATE" numeric(18,0), -- ID referencing the method used to estimate the rate
  "START_DATE" character varying(5), -- Starting date for the amount (in MM/DD).
  "END_DATE" character varying(5), -- Ending date for the amount as MM/DD.
  CONSTRAINT "PK_D_DIVERSION_ACTUAL" PRIMARY KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "DIVERSION_ID", "DETAIL_SEQ_NO", "ACTUAL_SEQ_NO"),
  CONSTRAINT "FK_D_DIVERSION_ACTUAL-D_DIVERSION_FLOW" FOREIGN KEY ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "DIVERSION_ID", "DETAIL_SEQ_NO")
      REFERENCES "WADE"."D_DIVERSION_FLOW" ("ORGANIZATION_ID", "REPORT_ID", "ALLOCATION_ID", "DIVERSION_ID", "DETAIL_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_DIVERSION_ACTUAL-LU_UNITS" FOREIGN KEY ("UNIT_VOLUME")
      REFERENCES "WADE"."LU_UNITS" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_DIVERSION_ACTUAL-LU_UNITS1" FOREIGN KEY ("UNIT_RATE")
      REFERENCES "WADE"."LU_UNITS" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_DIVERSION_ACTUAL-LU_VALUE_TYPE" FOREIGN KEY ("VALUE_TYPE_VOLUME")
      REFERENCES "WADE"."LU_VALUE_TYPE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_DIVERSION_ACTUAL-LU_VALUE_TYPE1" FOREIGN KEY ("VALUE_TYPE_RATE")
      REFERENCES "WADE"."LU_VALUE_TYPE" ("LU_SEQ_NO") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_DIVERSION_ACTUAL-METHODS" FOREIGN KEY ("METHOD_ID_VOLUME")
      REFERENCES "WADE"."METHODS" ("METHOD_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_D_DIVERSION_ACTUAL-METHODS1" FOREIGN KEY ("METHOD_ID_RATE")
      REFERENCES "WADE"."METHODS" ("METHOD_ID") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "WADE"."D_DIVERSION_ACTUAL"
  OWNER TO "WADE";
COMMENT ON TABLE "WADE"."D_DIVERSION_ACTUAL"
  IS 'The amount of water actually diverted for this allocation.  Only report if there are no diversions for this allocation, or if information is not available at the diversion level.';
COMMENT ON COLUMN "WADE"."D_DIVERSION_ACTUAL"."ORGANIZATION_ID" IS 'A unique identifier for the organization.';
COMMENT ON COLUMN "WADE"."D_DIVERSION_ACTUAL"."REPORT_ID" IS 'A unique identifier for the report assigned by the reporting organization.';
COMMENT ON COLUMN "WADE"."D_DIVERSION_ACTUAL"."ALLOCATION_ID" IS 'Unique identifier for the allocation.';
COMMENT ON COLUMN "WADE"."D_DIVERSION_ACTUAL"."DETAIL_SEQ_NO" IS 'Unique identifier for the detail information.';
COMMENT ON COLUMN "WADE"."D_DIVERSION_ACTUAL"."AMOUNT_VOLUME" IS 'Volume of water actually diverted at this diversion.';
COMMENT ON COLUMN "WADE"."D_DIVERSION_ACTUAL"."UNIT_VOLUME" IS 'Volume unit of measure';
COMMENT ON COLUMN "WADE"."D_DIVERSION_ACTUAL"."VALUE_TYPE_VOLUME" IS 'Indicator on how the actual amount was determined';
COMMENT ON COLUMN "WADE"."D_DIVERSION_ACTUAL"."METHOD_ID_VOLUME" IS 'ID referencing the method used to estimate the volume';
COMMENT ON COLUMN "WADE"."D_DIVERSION_ACTUAL"."AMOUNT_RATE" IS 'Rate of water actually diverted at this diversion.';
COMMENT ON COLUMN "WADE"."D_DIVERSION_ACTUAL"."UNIT_RATE" IS 'Unit of measure.';
COMMENT ON COLUMN "WADE"."D_DIVERSION_ACTUAL"."VALUE_TYPE_RATE" IS 'Indicator on how the actual amount was determined';
COMMENT ON COLUMN "WADE"."D_DIVERSION_ACTUAL"."METHOD_ID_RATE" IS 'ID referencing the method used to estimate the rate';
COMMENT ON COLUMN "WADE"."D_DIVERSION_ACTUAL"."START_DATE" IS 'Starting date for the amount (in MM/DD).';
COMMENT ON COLUMN "WADE"."D_DIVERSION_ACTUAL"."END_DATE" IS 'Ending date for the amount as MM/DD.';


-- Index: "WADE"."FKI_D_DIVERSION_ACTUAL-D_DIVERSION_FLOW"

-- DROP INDEX "WADE"."FKI_D_DIVERSION_ACTUAL-D_DIVERSION_FLOW";

CREATE INDEX "FKI_D_DIVERSION_ACTUAL-D_DIVERSION_FLOW"
  ON "WADE"."D_DIVERSION_ACTUAL"
  USING btree
  ("ORGANIZATION_ID" COLLATE pg_catalog."default", "REPORT_ID" COLLATE pg_catalog."default", "ALLOCATION_ID" COLLATE pg_catalog."default", "DIVERSION_ID" COLLATE pg_catalog."default", "DETAIL_SEQ_NO");

-- Index: "WADE"."FKI_D_DIVERSION_ACTUAL-LU_UNITS"

-- DROP INDEX "WADE"."FKI_D_DIVERSION_ACTUAL-LU_UNITS";

CREATE INDEX "FKI_D_DIVERSION_ACTUAL-LU_UNITS"
  ON "WADE"."D_DIVERSION_ACTUAL"
  USING btree
  ("UNIT_VOLUME");

-- Index: "WADE"."FKI_D_DIVERSION_ACTUAL-LU_UNITS1"

-- DROP INDEX "WADE"."FKI_D_DIVERSION_ACTUAL-LU_UNITS1";

CREATE INDEX "FKI_D_DIVERSION_ACTUAL-LU_UNITS1"
  ON "WADE"."D_DIVERSION_ACTUAL"
  USING btree
  ("UNIT_RATE");

-- Index: "WADE"."FKI_D_DIVERSION_ACTUAL-LU_VALUE_TYPE"

-- DROP INDEX "WADE"."FKI_D_DIVERSION_ACTUAL-LU_VALUE_TYPE";

CREATE INDEX "FKI_D_DIVERSION_ACTUAL-LU_VALUE_TYPE"
  ON "WADE"."D_DIVERSION_ACTUAL"
  USING btree
  ("VALUE_TYPE_VOLUME");

-- Index: "WADE"."FKI_D_DIVERSION_ACTUAL-LU_VALUE_TYPE1"

-- DROP INDEX "WADE"."FKI_D_DIVERSION_ACTUAL-LU_VALUE_TYPE1";

CREATE INDEX "FKI_D_DIVERSION_ACTUAL-LU_VALUE_TYPE1"
  ON "WADE"."D_DIVERSION_ACTUAL"
  USING btree
  ("VALUE_TYPE_RATE");

-- Index: "WADE"."FKI_D_DIVERSION_ACTUAL-METHODS"

-- DROP INDEX "WADE"."FKI_D_DIVERSION_ACTUAL-METHODS";

CREATE INDEX "FKI_D_DIVERSION_ACTUAL-METHODS"
  ON "WADE"."D_DIVERSION_ACTUAL"
  USING btree
  ("METHOD_ID_VOLUME");

-- Index: "WADE"."FKI_D_DIVERSION_ACTUAL-METHODS1"

-- DROP INDEX "WADE"."FKI_D_DIVERSION_ACTUAL-METHODS1";

CREATE INDEX "FKI_D_DIVERSION_ACTUAL-METHODS1"
  ON "WADE"."D_DIVERSION_ACTUAL"
  USING btree
  ("METHOD_ID_RATE");

