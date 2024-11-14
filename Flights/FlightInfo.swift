import Foundation

struct FlightInfo: Decodable, Hashable, Equatable {
    let flnr: String
    let date: String?
    let scheduledDepartureUtc: String?
    let actualDepartureUtc: String?
    let scheduledDepartureLocal: String?
    let actualDepartureLocal: String?
    let actualDepartureIsEstimated: Bool?
    let departureIcao: String?
    let departureIata: String?
    let departureName: String?
    let departureCity: String?
    let arrivalIcao: String?
    let arrivalIata: String?
    let arrivalName: String?
    let arrivalCity: String?
    let arrivalTerminal: String?
    let scheduledArrivalUtc: String?
    let actualArrivalUtc: String?
    let scheduledArrivalLocal: String?
    let actualArrivalLocal: String?
    let actualArrivalIsEstimated: Bool?
    let status: String?
    let airlineIata: String?
    let airlineIcao: String?
    let airlineName: String?
}
