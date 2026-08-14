@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Suppliment Projection view - Managed'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zvai_c_booking_suppl_m
  as projection on zvai_i_booking_suppl_m
{
  key TravelId,
  key BookingId,
  key BookingSupplementId,
      @ObjectModel.text.element: [ 'SupplementText' ]
      SupplementId,
      _SupplementText.Description as SupplementText : localized,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      LastChangedAt,
      /* Associations */
      _Booking : redirected to parent zvai_c_booking_m,
      _Supplement,
      _SupplementText,
      _Travel : redirected to zvai_c_travel_m
}
