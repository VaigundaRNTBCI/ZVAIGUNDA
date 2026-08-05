@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Connection'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@UI.headerInfo: { typeName: 'Connection', typeNamePlural: 'Connections', title: { type: #STANDARD, value: 'ConnectionId' }, description: { type: #STANDARD, value: 'CarrierId' } }
define view entity ZVAI_CDS_Connection
  as select from /dmo/connection as Connection
  association [1..*] to zvai_cds_flight_r as _Flight on  $projection.CarrierId    = _Flight.CarrierId
                                                     and $projection.ConnectionId = _Flight.ConnectionId
  association[1] to zvai_i_CARRIER_r as _Carrier on $projection.CarrierId = _Carrier.CarrierId
{
      @UI.facet:[{ id: 'Connection',
                   type: #IDENTIFICATION_REFERENCE,
                   position: 10,
                   label: 'Connection Details' },
                 { id: 'Flights',
                 type: #LINEITEM_REFERENCE,
                 position: 20,
                 label: 'Flight Details',
                 targetElement: '_Flight'
               }]
      @UI.identification: [{ position: 10, label: 'Airline Id' }]
      @UI.lineItem: [{ position: 10, label: 'Airline' }]
      @ObjectModel.text.association: '_Carrier'
      @Search.defaultSearchElement: true
  key carrier_id      as CarrierId,
      @UI.identification: [{ position: 20, label: 'Connection Id' }]
      @UI.selectionField: [{ position: 30 }]
      @UI.lineItem: [{ position: 20, label: 'Connection' }]
      @Search.defaultSearchElement: true
  key connection_id   as ConnectionId,
      @UI.identification: [{ position: 30, label: 'From Airport Number' }]
      @UI.selectionField: [{ position: 10 }]
      @UI.lineItem: [{ position: 30, label: 'From Airport' }]
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: { name :'zvai_i_airport_r', element: 'AirportId' } }]
      airport_from_id as AirportFromId,
      @UI.identification: [{ position: 40, label: 'To Airport Number' }]
      @UI.selectionField: [{ position: 20 }]
      @UI.lineItem: [{ position: 40, label: 'To Airport' }]
      @Search.defaultSearchElement: true
      @EndUserText.label: 'Airport To ID'
      airport_to_id   as AirportToId,
      @UI.identification: [{ position: 50, label: 'Departure Time' }]
      @UI.lineItem: [{ position: 50, label: 'Departure Time' }]
      departure_time  as DepartureTime,
      @UI.identification: [{ position: 60, label: 'Arrival Time' }]
      @UI.lineItem: [{ position: 60, label: 'Arrival Time' }]
      arrival_time    as ArrivalTime,
      @UI.identification: [{ position: 70, label: 'Distance' }]
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      distance        as Distance,
      distance_unit   as DistanceUnit,
      _Flight,
      @Search.defaultSearchElement: true
      _Carrier
}
