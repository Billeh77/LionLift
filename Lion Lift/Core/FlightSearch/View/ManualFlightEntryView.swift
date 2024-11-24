import SwiftUI

struct ManualFlightEntryView: View {
    @State private var selectedAirport: String = "JFK" // Default airport
    @State private var selectedTerminal: String = "Terminal 1" // Default terminal
    @State private var flightDate: Date = Date()
    @State private var flightTime: Date = Date()
    @State private var numberOfPassengers = 1
    @State private var luggageQuantity = 1
    @State private var shouldNavigateToScheduledRide = false

    let airports = ["JFK", "LGA", "EWR"]
    let terminalsByAirport: [String: [String]] = [
        "JFK": ["Terminal 1", "Terminal 2", "Terminal 4", "Terminal 5", "Terminal 7", "Terminal 8"],
        "LGA": ["Terminal A", "Terminal B", "Terminal C", "Terminal D"],
        "EWR": ["Terminal A", "Terminal B", "Terminal C"]
    ]
    let maxPassengers = 6

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Back to Home
                HStack {
                    NavigationLink(destination: HomeView()) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Home")
                        }
                        .font(Font.custom("Roboto Flex", size: 16))
                        .foregroundColor(Color(red: 0.0, green: 0.22, blue: 0.39)) // Navy blue
                    }
                    Spacer()
                }
                .padding(.top)

                // Title
                Text("Sorry, we couldn’t match your flight")
                    .font(Font.custom("Roboto Flex", size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(.top)

                // Subtitle
                Text("Enter Flight Details Manually")
                    .font(Font.custom("Roboto Flex", size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.bottom, 10)

                VStack(alignment: .leading, spacing: 16) {
                    // Airport Dropdown
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Airport")
                            .font(Font.custom("Roboto Flex", size: 16))
                            .foregroundColor(.black)
                        Menu {
                            ForEach(airports, id: \.self) { airport in
                                Button(action: {
                                    selectedAirport = airport
                                    selectedTerminal = terminalsByAirport[airport]?.first ?? ""
                                }) {
                                    Text(airport)
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedAirport)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Box color
                            .cornerRadius(5)
                        }
                        Divider() // Thin line
                    }

                    // Terminal Dropdown
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Terminal")
                            .font(Font.custom("Roboto Flex", size: 16))
                            .foregroundColor(.black)
                        Menu {
                            ForEach(terminalsByAirport[selectedAirport] ?? [], id: \.self) { terminal in
                                Button(action: {
                                    selectedTerminal = terminal
                                }) {
                                    Text(terminal)
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedTerminal)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.secondary)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                            .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Box color
                            .cornerRadius(5)
                        }
                        Divider() // Thin line
                    }

                    // Flight Date Picker
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Flight Date")
                            .font(Font.custom("Roboto Flex", size: 16))
                            .foregroundColor(.black)
                        DatePicker("", selection: $flightDate, displayedComponents: .date)
                            .labelsHidden()
                            .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Box color
                            .cornerRadius(5)
                        Divider() // Thin line
                    }

                    // Flight Time Picker
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Time at Airport")
                            .font(Font.custom("Roboto Flex", size: 16))
                            .foregroundColor(.black)
                        DatePicker("", selection: $flightTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Box color
                            .cornerRadius(5)
                        Divider() // Thin line
                    }

                    // Number of Passengers
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Number of Passengers")
                            .font(Font.custom("Roboto Flex", size: 16))
                            .foregroundColor(.black)
                        Picker("Number of Passengers", selection: $numberOfPassengers) {
                            ForEach(1...maxPassengers, id: \.self) { i in
                                Text("\(i)")
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Box color
                        .cornerRadius(5)
                        Divider() // Thin line
                    }

                    // Luggage Quantity
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Luggage Quantity")
                            .font(Font.custom("Roboto Flex", size: 16))
                            .foregroundColor(.black)
                        Picker("Luggage Quantity", selection: $luggageQuantity) {
                            ForEach(1...maxPassengers, id: \.self) { i in
                                Text("\(i)")
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Box color
                        .cornerRadius(5)
                        Divider() // Thin line
                    }
                }

                Spacer()

                // NavigationLink to ScheduledRideView
                NavigationLink(
                    destination: ScheduledRideView(
                        flightInfo: FlightInfo(
                            flnr: "N/A",
                            date: selectedAirport,
                            scheduledDepartureLocal: selectedTerminal,
                            departureName: "", // Optional field if not relevant
                            arrivalTerminal: ""
                        ),
                        flightDate: flightDate,
                        numberOfPassengers: numberOfPassengers,
                        luggageQuantity: luggageQuantity,
                        flightTime: flightTime // Pass the selected time
                    ),
                    isActive: $shouldNavigateToScheduledRide
                ) {
                    EmptyView()
                }


                // Next Button
                Button(action: {
                    shouldNavigateToScheduledRide = true
                }) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.0, green: 0.22, blue: 0.39)) // Navy blue
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .padding(.horizontal)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
           
        }
    }
       
}
