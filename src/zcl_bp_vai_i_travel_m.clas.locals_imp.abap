CLASS lhc_zvai_i_travel_m DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zvai_i_travel_m RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zvai_i_travel_m RESULT result.
    METHODS earlynumbering_create FOR NUMBERING
       entities FOR CREATE zvai_i_travel_m.

ENDCLASS.

CLASS lhc_zvai_i_travel_m IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.

  ENDMETHOD.

  METHOD earlynumbering_create.

    DATA(lt_entities) = entities.

    DELETE lt_entities WHERE TravelId IS NOT INITIAL.

* /DMO/TRAVEL_ID

    TRY.
        cl_numberrange_runtime=>number_get(
          EXPORTING
*     ignore_buffer     =
            nr_range_nr       = '01'
            object            = '/DMO/TRV_M'
            quantity          =  CONV #( lines( lt_entities ) )
*     subobject         =
*     toyear            =
          IMPORTING
            number            = DATA(lv_number)
            returncode        = DATA(lv_returncode)
            returned_quantity = DATA(lv_returned_quantity)
        ).
      CATCH cx_nr_object_not_found.
      CATCH cx_number_ranges INTO DATA(lo_error).

        LOOP AT lt_entities ASSIGNING FIELD-SYMBOL(<ls_entity>).
          APPEND VALUE #( %cid     = <ls_entity>-%cid
                          %key = <ls_entity>-%key )
                         TO failed-zvai_i_travel_m.

          APPEND VALUE #( %cid     = <ls_entity>-%cid
                      %key = <ls_entity>-%key
                      %msg   = lo_error )
                     TO reported-zvai_i_travel_m.

        ENDLOOP.
    ENDTRY.

    ASSERT lv_returned_quantity = lines( lt_entities ).

    DATA: lt_data TYPE TABLE FOR MAPPED zvai_i_travel_m.

    data(lv_curr_num) = lv_number - lv_returned_quantity .

    LOOP AT lt_entities ASSIGNING <ls_entity>.
      	 lv_curr_num = lv_curr_num + 1.
      	
      	 APPEND VALUE #( %cid     = <ls_entity>-%cid
      	                 TravelId = lv_curr_num )
      	                TO mapped-zvai_i_travel_m.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
