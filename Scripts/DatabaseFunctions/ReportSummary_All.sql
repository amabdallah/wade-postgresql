-- FUNCTION: "WADE_R"."ReportSummary_All"(text)

-- DROP FUNCTION "WADE_R"."ReportSummary_All"(text);

CREATE OR REPLACE FUNCTION "WADE_R"."ReportSummary_All"(
	orgid text,
	OUT text_output xml)
    RETURNS xml
    LANGUAGE 'plpgsql'
    COST 1000.0
    STABLE 
AS $function$

BEGIN

text_output:= (SELECT STRING_AGG
	(XMLELEMENT
		(name "WC:Report",
		XMLCONCAT(
			(SELECT XMLFOREST
				("REPORT_ID" AS "WC:ReportIdentifier", 
				"REPORTING_DATE" AS "WC:ReportingDate",
				"REPORTING_YEAR" AS "WC:ReportingYear", 
				"REPORT_NAME" AS "WC:ReportName", 
				"REPORT_LINK" AS "WC:ReportLink",
				"YEAR_TYPE" AS "WC:YearType")
			), 
			(SELECT "WADE_R"."GeospatialRefSummary"
				(orgid,"REPORT_ID",'ALL')
			),
			(SELECT "WADE_R"."ReportUnitSummary_All"
				(orgid,"REPORT_ID")
			)
			)
		)::text,''
	)

	FROM 

	"WADE"."REPORT" A WHERE "ORGANIZATION_ID"=orgid);

	

RETURN;

		

END

  

$function$;

ALTER FUNCTION "WADE_R"."ReportSummary_All"(text)
    OWNER TO postgres;

