{@outcomeOfInterest == 'condition'}?{
  SELECT c.CONCEPT_ID, c.CONCEPT_NAME,
  	MIN(u.SORT_ORDER) AS SORT_ORDER
  FROM @sourceData u
  	JOIN @vocabulary.CONCEPT c
  		ON c.CONCEPT_ID = u.CONDITION_CONCEPT_ID
    	AND c.DOMAIN_ID = 'Condition'
  WHERE DRUG_CONCEPT_ID IN (
  	SELECT DESCENDANT_CONCEPT_ID FROM @vocabulary.CONCEPT_ANCESTOR WHERE ANCESTOR_CONCEPT_ID IN (@conceptsOfInterest)
  )
  GROUP BY c.CONCEPT_ID, c.CONCEPT_NAME
}
{@outcomeOfInterest == 'drug'}?{
  SELECT c.CONCEPT_ID, c.CONCEPT_NAME,
  	MIN(u.SORT_ORDER) AS SORT_ORDER
  FROM @sourceData u
  	JOIN @vocabulary.CONCEPT c
  		ON c.CONCEPT_ID = u.DRUG_CONCEPT_ID
  		AND c.DOMAIN_ID = 'Drug'
  WHERE CONDITION_CONCEPT_ID IN (
  	SELECT DESCENDANT_CONCEPT_ID FROM @vocabulary.CONCEPT_ANCESTOR WHERE ANCESTOR_CONCEPT_ID IN (@conceptsOfInterest)
  )
  GROUP BY c.CONCEPT_ID, c.CONCEPT_NAME
}


