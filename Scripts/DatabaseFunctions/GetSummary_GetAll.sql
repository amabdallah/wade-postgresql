-- FUNCTION: "WADE_R"."GetSummary_GetAll"(text)

-- DROP FUNCTION "WADE_R"."GetSummary_GetAll"(text);

CREATE OR REPLACE FUNCTION "WADE_R"."GetSummary_GetAll"(
	orgid text,
	OUT text_output xml)
    RETURNS xml
    LANGUAGE 'plpgsql'
    COST 1000.0
    STABLE 
AS $function$

DECLARE

namespace character varying;

BEGIN

namespace:='http://www.exchangenetwork.net/schema/WaDE/0.2';

text_output:= (SELECT STRING_AGG(

XMLELEMENT(name "WC:WaDE", XMLATTRIBUTES(namespace as "xmlns:WC"),
	XMLELEMENT(name "WC:Organization",
	XMLCONCAT((SELECT XMLFOREST
			("ORGANIZATION_ID" AS "WC:OrganizationIdentifier",
			"ORGANIZATION_NAME" AS "WC:OrganizationName", 
			"PURVUE_DESC" AS "WC:PurviewDescription",
			"WADE_URL" AS "WC:WaDEURLAddress")),
			XMLELEMENT(name "WC:Contact",
				(SELECT XMLFOREST
					("FIRST_NAME" AS "WC:FirstName",
					"MIDDLE_INITIAL" AS "WC:MiddleInitial",
					"LAST_NAME" AS "WC:LastName", 
					"TITLE" AS "WC:IndividualTitleText", 
					"EMAIL" AS "WC:EmailAddressText", 
					"PHONE" AS "WC:TelephoneNumberText", 
					"PHONE_EXT" AS "WC:PhoneExtensionText", 
					"FAX" AS "WC:FaxNumberText")),
					XMLELEMENT(name "WC:MailingAddress",
						(SELECT XMLFOREST
							("ADDRESS" AS "WC:MailingAddressText",
							"ADDRESS_EXT" AS "WC:SupplementalAddressText", 
							"CITY" AS "WC:MailingAddressCityName", 
							"STATE" AS "WC:MailingAddressStateUSPSCode", 
							"COUNTRY" AS "WC:MailingAddressCountryCode", 
							"ZIPCODE" AS "WC:MailingAddressZIPCode")
						))	
				),
			(SELECT "WADE_R"."ReportSummary_All"(orgid))
		)
	)
	)::text,'')

FROM "WADE"."ORGANIZATION" WHERE "ORGANIZATION_ID"=orgid);

RETURN;

END
  

$function$;

ALTER FUNCTION "WADE_R"."GetSummary_GetAll"(text)
    OWNER TO postgres;

