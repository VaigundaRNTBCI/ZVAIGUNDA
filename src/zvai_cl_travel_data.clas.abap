CLASS zvai_cl_travel_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zvai_cl_travel_data IMPLEMENTATION.

 METHOD if_oo_adt_classrun~main.
	
   DELETE FROM zvai_travel_m .
   delete from zvai_booking_m .
   delete from zvai_booksuppl_m .
   COMMIT WORK.

   INSERT zvai_travel_m FROM (
      SELECT * FROM /dmo/travel_m ) .

   COMMIT WORK.

   INSERT zvai_booking_m FROM (
      SELECT * FROM /dmo/booking_m ) .

   COMMIT WORK.

      INSERT zvai_booksuppl_m FROM (
      SELECT * FROM /dmo/booksuppl_m ) .

   COMMIT WORK.

   out->write( 'Tables loaded successfully.' ).

  ENDMETHOD.

ENDCLASS.
