@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zvai_c_booking_m
  as projection on zvai_i_booking_m
{
  key TravelId,
  key BookingId,
      BookingDate,
      @ObjectModel.text.element: [ 'CustomerName' ]
      CustomerId,
      _Customer.LastName as CustomerName,
      @ObjectModel.text.element: [ 'CarrierName' ]
      CarrierId,
      _Carrier.Name as CarrierName,
      @ObjectModel.text.element: [ 'ConnectionName' ]
      ConnectionId,
      _Connection._Airline.Name as ConnectionName,
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      @ObjectModel.text.element: [ 'BookingStatusText' ]
      BookingStatus,
      _Status._Text.Text as  BookingStatusText : localized,
      LastChangedAt,
      /* Associations */
      _Status,
      _BookingSuppl : redirected to composition child zvai_c_booking_suppl_m,
      _Carrier,
      _Connection,
      _Customer,
      _Travel : redirected to parent zvai_c_travel_m
}
