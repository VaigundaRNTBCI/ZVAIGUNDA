@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Airport Info'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define view entity zvai_i_airport_r
  as select from /dmo/airport
{
      @Search.defaultSearchElement: true
  key airport_id as AirportId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      name       as Name,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      city       as City,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      country    as Country
}
