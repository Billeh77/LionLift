import SwiftUI

struct ScheduledRideView: View {
    let flightInfo: FlightInfo
    let flightDate: Date?
    let numberOfPassengers: Int
    let luggageQuantity: Int
    let flightTime: Date

    @State private var flightNumber: String = ""
    @State private var airport: String = ""
    @State private var terminal: String = ""
    @State private var date: String = ""
    @State private var time: Date = Date()
    @State private var passengers: Int = 1
    @State private var luggage: Int = 1
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title
            Text("Is this your Flight?")
                .font(Font.custom("Roboto Flex", size: 24))
                .fontWeight(.bold)
                .padding(.bottom, 20)

            // Flight Number
            VStack(alignment: .leading, spacing: 4) {
                Text("Flight Number:")
                    .font(Font.custom("Roboto Flex", size: 16))
                TextField("Flight Number", text: $flightNumber)
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Light blue
                    .cornerRadius(5)
            }

            // Airport
            VStack(alignment: .leading, spacing: 4) {
                Text("Airport:")
                    .font(Font.custom("Roboto Flex", size: 16))
                TextField("Airport", text: $airport)
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Light blue
                    .cornerRadius(5)
            }

            // Terminal
            VStack(alignment: .leading, spacing: 4) {
                Text("Terminal:")
                    .font(Font.custom("Roboto Flex", size: 16))
                TextField("Terminal", text: $terminal)
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Light blue
                    .cornerRadius(5)
            }

            // Date
//            VStack(alignment: .leading, spacing: 4) {
//                Text("Date:")
//                    .font(Font.custom("Roboto Flex", size: 16))
//                TextField("Date", text: $date)
//                    .padding(.vertical, 8)
//                    .padding(.horizontal)
//                    .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Light blue
//                    .cornerRadius(5)
//            }

            // Time
            VStack(alignment: .leading, spacing: 4) {
                Text("Date and time:")
                    .font(Font.custom("Roboto Flex", size: 16))
                DatePicker("", selection: $time, displayedComponents: [.hourAndMinute, .date])
                    .labelsHidden()
                   
                    .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Light blue
                    .cornerRadius(5)
            }

            // Number of Passengers
            VStack(alignment: .leading, spacing: 4) {
                Text("Number of Passengers:")
                    .font(Font.custom("Roboto Flex", size: 16))
                TextField("Passengers", value: $passengers, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Light blue
                    .cornerRadius(5)
            }

            // Luggage
            VStack(alignment: .leading, spacing: 4) {
                Text("Luggage Quantity:")
                    .font(Font.custom("Roboto Flex", size: 16))
                TextField("Luggage", value: $luggage, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Light blue
                    .cornerRadius(5)
            }

            Spacer()

            // Save Changes Button
//            NavigationLink(destination: HomeView()) {
//                
//            }
//            .padding(.horizontal)
            
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save Changes")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0.0, green: 0.22, blue: 0.39)) // Navy blue
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
        .padding()
        
        .navigationBarBackButtonHidden()
        .onAppear {
            // Set default values from flightInfo when view appears
            flightNumber = flightInfo.flnr.isEmpty ? "N/A" : flightInfo.flnr
            airport = flightInfo.departureName ?? ""
            terminal = flightInfo.arrivalTerminal ?? ""
            date = formatDate(flightDate)
            time = flightTime // Already a Date
            passengers = numberOfPassengers
            luggage = luggageQuantity
        }
    }

    func formatDate(_ date: Date?) -> String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
