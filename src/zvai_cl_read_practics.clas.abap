CLASS zvai_cl_read_practics DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zvai_cl_read_practics IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*   1. Short Read method 1
*    READ ENTITY zvai_i_travel_m
*      FROM VALUE #( ( %key-travelId = '0000000001'
*                      %control = VALUE #( AgencyId = if_abap_behv=>mk-on
*                                          CustomerId = if_abap_behv=>mk-on
*                                          BeginDate = if_abap_behv=>mk-on ) ) )
*      RESULT DATA(lt_result_short)
*      FAILED DATA(lt_failed_short).

**   1. Short Read method 2
*    READ ENTITY zvai_i_travel_m
*      FIELDS ( travelId
*			   beginDate
*			   endDate
*			   agencyId
*			   customerId )
*      WITH VALUE #( ( %key-travelId = '0000000001' ) )
*      RESULT DATA(lt_result_short)
*      FAILED DATA(lt_failed_short).

**   1. Short Read method 3
*    READ ENTITY zvai_i_travel_m
*      ALL FIELDS
*      WITH VALUE #( ( %key-travelId = '0000000001' )
*                    ( %key-travelId = '0000000002' ) )
*      RESULT DATA(lt_result_short)
*      FAILED DATA(lt_failed_short).

*   1. Short Read method 4
    out->write( |Short entity| ).
    out->write( |--------------| ).
    READ ENTITY zvai_i_travel_m
      BY \_Booking
      ALL FIELDS
      WITH VALUE #( ( %key-travelId = '0000000001' )
                    ( %key-travelId = '0000000002' ) )
      RESULT DATA(lt_result_short)
      FAILED DATA(lt_failed_short).

    IF lt_failed_short IS NOT INITIAL.
      out->write( |Failed to read entity| ).
    ELSE.
      out->write( lt_result_short ).
    ENDIF.

*   2. Long Read method 1
    out->write( |Long entity| ).
    out->write( |--------------| ).
    READ ENTITIES OF zvai_i_travel_m

      ENTITY zvai_i_travel_m
*      by \_Booking
      ALL FIELDS
      WITH VALUE #( ( %key-travelId = '0000000001' )
                    ( %key-travelId = '0000000002' ) )
      RESULT DATA(lt_travel_long)

      ENTITY zvai_i_booking_m
      ALL FIELDS
      WITH VALUE #( ( %key-travelId = '0000000001' %key-BookingId = '0000000001' )
					( %key-travelId = '0000000002' %key-BookingId = '0000000001' ) )
      RESULT DATA(lt_booking_long)

      FAILED DATA(lt_failed_long).

    IF lt_failed_long IS NOT INITIAL.
      out->write( |Failed to read entity| ).
    ELSE.
      out->write( lt_travel_long ).
      out->write( lt_booking_long ).
    ENDIF.

*   2. Dynamic Read method 1
    out->write( |Dynamic entity| ).
    out->write( |--------------| ).

    DATA:lt_optab     TYPE abp_behv_retrievals_tab,
         lt_travel_im TYPE TABLE FOR READ IMPORT zvai_i_travel_m,
         lt_travel_rl TYPE TABLE FOR READ RESULT zvai_i_travel_m,
         lt_booking_im type table for read import zvai_i_travel_m\_Booking,
         lt_booking_rl type table for read result zvai_i_travel_m\_Booking.

    lt_travel_im = VALUE #( ( %key-TravelId = '0000000001'
                              %control = VALUE #( AgencyId   = if_abap_behv=>mk-on
                                                  BeginDate  = if_abap_behv=>mk-on
                                                  CustomerId = if_abap_behv=>mk-on
                                                  )
                           ) ).

    lt_booking_im = VALUE #( ( %key-TravelId  = '0000000001'
*							  %key-BookingId = '0000000001'
							  %control = VALUE #( TravelId      = if_abap_behv=>mk-on
												  BookingId     = if_abap_behv=>mk-on
												  BookingDate   = if_abap_behv=>mk-on
												  BookingStatus = if_abap_behv=>mk-on
												  )
						   ) ).		

    lt_optab = VALUE #(
                       ( op = if_abap_behv=>op-r-read
                         entity_name = 'ZVAI_I_TRAVEL_M'
 						 instances = REF #( lt_travel_im )
 						 results = REF #( lt_travel_rl )
 						)
 						( op = if_abap_behv=>op-r-read_ba
 						 entity_name = 'ZVAI_I_TRAVEL_M'
						 sub_name    = '_BOOKING'
						 instances = REF #( lt_booking_im )
						 results = REF #( lt_booking_rl )
 					   )
 					   ).
 					
    READ ENTITIES OPERATIONS lt_optab
         FAILED DATA(lt_failed_dyn).

    	IF sy-subrc <> 0.
      	  out->write( |Failed to read entity| ).
    	ELSE.
      	  out->write( lt_travel_rl ).
      	  out->write( lt_booking_rl ).
    	ENDIF.

  ENDMETHOD.

ENDCLASS.
