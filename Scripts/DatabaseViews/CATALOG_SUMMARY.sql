﻿-- View: "WADE_R"."CATALOG_SUMMARY"

-- DROP VIEW "WADE_R"."CATALOG_SUMMARY";

CREATE OR REPLACE VIEW "WADE_R"."CATALOG_SUMMARY" AS 
 SELECT a."ORGANIZATION_ID",
    a."REPORT_ID",
    a."DATACATEGORY",
    a."DATATYPE",
    a."STATE",
    a."REPORT_UNIT_ID",
    a."COUNTY_FIPS",
    a."HUC",
    count(a."ALLOCATION_ID") AS "NUMOFALLOCATIONS"
   FROM "WADE_R"."FULL_CATALOG" a
  GROUP BY a."ORGANIZATION_ID", a."REPORT_ID", a."DATACATEGORY", a."DATATYPE", a."STATE", a."REPORT_UNIT_ID", a."COUNTY_FIPS", a."HUC"
  ORDER BY a."DATACATEGORY" DESC;

ALTER TABLE "WADE_R"."CATALOG_SUMMARY"
  OWNER TO "WADE";
COMMENT ON VIEW "WADE_R"."CATALOG_SUMMARY"
  IS 'View to provide querable Catalog for catalog service.';
