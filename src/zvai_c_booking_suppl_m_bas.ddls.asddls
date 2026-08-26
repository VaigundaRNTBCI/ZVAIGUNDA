@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Suppliment Projection BAS'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZVAI_C_BOOKING_SUPPL_M_BAS
  as projection on zvai_i_booking_suppl_m
{
  key TravelId,
  key BookingId,
  key BookingSupplementId,
      
      @ObjectModel.text.element: ['SupplementText']
      SupplementId,
      _SupplementText.Description as SupplementText : localized,
            
      @Semantics.amount.currencyCode: 'CurrencyCode'
      Price,
      CurrencyCode,
      LastChangedAt,
      /* Associations */
      _Booking : redirected to parent ZVAI_C_BOOKING_M_BAS,
      _Supplement,
      _SupplementText,
      _Travel  : redirected to ZVAI_C_TRAVEL_M_BAS
}
