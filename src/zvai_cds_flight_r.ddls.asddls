@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Information'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define view entity zvai_cds_flight_r
  as select from /dmo/flight
  association [1] to zvai_i_CARRIER_r as _Carrier on $projection.CarrierId = _Carrier.CarrierId
{
      @UI.lineItem: [{position: 10, label: 'Carrier ID'}]
      @ObjectModel.text.association: '_Carrier'
  key carrier_id     as CarrierId,
      @UI.lineItem: [{position: 20, label: 'Connection ID'}]
  key connection_id  as ConnectionId,
      @UI.lineItem: [{position: 30, label: 'Flight Date'}]
  key flight_date    as FlightDate,
      @UI.lineItem: [{position: 40, label: 'Price'}]
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price          as Price,
      @UI.lineItem: [{position: 50, label: 'Currency Code'}]
      currency_code  as CurrencyCode,
      @UI.lineItem: [{position: 60, label: 'Plane Type ID'}]
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      plane_type_id  as PlaneTypeId,
      @UI.lineItem: [{position: 70, label: 'Seats Max'}]
      seats_max      as SeatsMax,
      @UI.lineItem: [{position: 80, label: 'Seats Occupied'}]
      seats_occupied as SeatsOccupied,
      _Carrier
}
