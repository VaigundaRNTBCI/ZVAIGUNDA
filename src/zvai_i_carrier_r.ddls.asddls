@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CARRIER Information'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define view entity zvai_i_CARRIER_r
  as select from /dmo/carrier
{
  key carrier_id    as CarrierId,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      name          as Name,
      currency_code as CurrencyCode
}
