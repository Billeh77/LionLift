import SwiftUI

struct ScheduledRideView: View {
    var flightInfo: FlightInfo?
    var flightDate: String? // Initial date passed in as a string
    
    // Editable fields with default values from flightInfo
    @State private var flightNumber: String = ""
    @State private var departureAirport: String = ""
    @State private var arrivalAirport: String = ""
    @State private var flightTime: String = ""
    @State private var date: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Is this your Flight?")
                .font(.title)
                .padding(.bottom, 20)
            
            // Editable fields
            Text("Flight Number:")
            TextField("Flight Number", text: $flightNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 8)
            
            Text("From:")
            TextField("Departure Airport", text: $departureAirport)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 8)
            
            Text("To:")
            TextField("Arrival Airport", text: $arrivalAirport)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 8)
            
            Text("Date:")
            TextField("Date", text: $date)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 8)
            
            Text("Time:")
            TextField("Flight Time", text: $flightTime)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 8)
            
            Spacer()
            
            Button(action: saveEdits) {
                Text("Save Changes")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Scheduled Ride")
        .onAppear {
            // Set default values from flightInfo when view appears
            flightNumber = flightInfo?.flnr ?? ""
            departureAirport = flightInfo?.departureName ?? ""
            arrivalAirport = flightInfo?.arrivalName ?? ""
            date = flightDate ?? ""
            flightTime = flightInfo?.scheduledArrivalLocal ?? ""
        }
    }
    
    func saveEdits() {
        // Implement save functionality here, e.g., updating a model or saving to a database.
        print("Edits saved:")
        print("Flight Number: \(flightNumber)")
        print("Departure Airport: \(departureAirport)")
        print("Arrival Airport: \(arrivalAirport)")
        print("Date: \(date)")
        print("Flight Time: \(flightTime)")
    }
}
