struct FlightInfo: Decodable, Hashable {
   let flnr: String
   let date: String?
   let scheduledDepartureLocal: String?
   let departureName: String?
   let arrivalTerminal: String?
}
