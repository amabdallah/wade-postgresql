-- FUNCTION: "WADE_R"."ReportUnitSummary_All"(text, text)

-- DROP FUNCTION "WADE_R"."ReportUnitSummary_All"(text, text);

CREATE OR REPLACE FUNCTION "WADE_R"."ReportUnitSummary_All"(
	orgid text,
	reportid text,
	OUT tmp_output xml)
    RETURNS xml
    LANGUAGE 'plpgsql'
    COST 1000.0
    STABLE 
AS $function$

BEGIN

	tmp_output:=(SELECT STRING_AGG
		(XMLELEMENT
			(name "WC:ReportingUnit",
			XMLCONCAT (
					(SELECT XMLFOREST
						("REPORT_UNIT_ID" AS "WC:ReportingUnitIdentifier",
						"REPORTING_UNIT_NAME" as "WC:ReportingUnitName", 
						"REPORTING_UNIT_TYPE" AS "WC:ReportingUnitTypeName")
					),
					XMLELEMENT
						(name "WC:Location", 
						  
							(SELECT XMLFOREST
								(B."VALUE" AS "WC:StateCode", 
								"COUNTY_FIPS" AS "WC:CountyFipsCode", 
								"HUC" AS "WC:HydrologicUnitCode")
							)
						),
						(SELECT "WADE_R"."XML_AVAILABILITY_SUMMARY"
							(orgid,"REPORT_ID","REPORT_UNIT_ID")
						),							
						(SELECT "WADE_R"."XML_ALLOCATION_SUMMARY"
							(orgid, "REPORT_ID", "REPORT_UNIT_ID")
						),
						(SELECT "WADE_R"."XML_USE_SUMMARY"
							(orgid, "REPORT_ID", "REPORT_UNIT_ID")
						),
						(SELECT "WADE_R"."XML_SUPPLY_SUMMARY"
							(orgid, "REPORT_ID", "REPORT_UNIT_ID")
						),
						(SELECT "WADE_R"."XML_REGULATORY_SUMMARY"
							(orgid, "REPORT_ID", "REPORT_UNIT_ID")
						)
				)  
			
				
			)::text,''
		)
	

	FROM 

	"WADE"."REPORTING_UNIT" A LEFT OUTER JOIN "WADE"."LU_STATE" B ON (A."STATE"=B."LU_SEQ_NO") WHERE EXISTS 
	(SELECT B."REPORT_UNIT_ID" FROM "WADE_R"."SUMMARY_LOCATION_MV" B WHERE 
	A."ORGANIZATION_ID"=B."ORGANIZATION_ID" 
	AND A."REPORT_ID"=B."REPORT_ID" 
	AND A."REPORT_UNIT_ID"=B."REPORT_UNIT_ID" 
	AND B."ORGANIZATION_ID"=orgid 
	AND B."REPORT_ID"=reportid )
	AND A."ORGANIZATION_ID"=orgid
	AND A."REPORT_ID"=reportid);

RETURN;

END

  

$function$;

ALTER FUNCTION "WADE_R"."ReportUnitSummary_All"(text, text)
    OWNER TO postgres;

