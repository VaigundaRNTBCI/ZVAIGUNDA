@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Projection BAS'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZVAI_C_BOOKING_M_BAS
  as projection on zvai_i_booking_m
{
  key TravelId,
  key BookingId,
      BookingDate,
      
      @ObjectModel.text.element: ['CustomerName', '_Customer.FirstName']
      CustomerId,
      _Customer.LastName as CustomerName,
      
      @ObjectModel.text.element: ['CarrierName']
      CarrierId,
      _Carrier.Name as CarrierName,
      
      @ObjectModel.text.element: ['ConnectionName']
      ConnectionId,
      _Connection._Airline.Name as ConnectionName,
      
      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      CurrencyCode,
      
      @ObjectModel.text.element: ['BookingStatusText']
      BookingStatus,
      _Status._Text.Text as BookingStatusText : localized,
      
      LastChangedAt,
      /* Associations */
      _BookingSuppl : redirected to composition child ZVAI_C_BOOKING_SUPPL_M_BAS,
      _Carrier,
      _Connection,
      _Customer,
      _Status,
      _Travel       : redirected to parent ZVAI_C_TRAVEL_M_BAS
}
