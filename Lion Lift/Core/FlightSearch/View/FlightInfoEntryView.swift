import SwiftUI

struct FlightInfoEntryView: View {
    @State private var flightNumber: String = ""
    @State private var flightDate: Date = Date()
    @State private var numberOfPassengers = 1
    @State private var luggageQuantity = 1
    @State private var luggageType = "Carry On"
    @State private var isFetching = false
    @State private var fetchedFlightInfo: FlightInfo?
    @State private var fetchedTime: Date = Date()
    @State private var shouldNavigateToManualEntry = false
    @State private var shouldNavigateToScheduledRide = false

    let luggageOptions = ["Carry On", "Medium", "Large"]
    let maxPassengers = 6

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                // Back Button
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

                // Title Text
                Text("Flight Info")
                    .font(Font.custom("Roboto Flex", size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.0, green: 0.22, blue: 0.39)) // Navy blue
                    .padding(.bottom, 24)

                // Flight Number Section
                HStack {
                    Text("Flight Number")
                        .font(Font.custom("Roboto Flex", size: 16))
                        .foregroundColor(.black)
                    Spacer()
                    TextField("", text: $flightNumber)
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Light blue
                        .cornerRadius(5)
                        .frame(width: 128, height: 45)
                        .padding(.trailing, 10)
                }
                Divider()

                // Flight Date Section
                HStack {
                    Text("Flight Date")
                        .font(Font.custom("Roboto Flex", size: 16))
                        .foregroundColor(.black)
                    Spacer()
                    DatePicker("", selection: $flightDate, displayedComponents: .date)
                        .labelsHidden()
                        .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Light blue
                        .cornerRadius(5)
                        .padding(.trailing, 10)
                }
                Divider()

                // Number of Passengers Section
                HStack {
                    Text("Number of Passengers")
                        .font(Font.custom("Roboto Flex", size: 16))
                        .foregroundColor(.black)
                    Spacer()
                    Picker("Number of Passengers", selection: $numberOfPassengers) {
                        ForEach(1...maxPassengers, id: \.self) { i in
                            Text("\(i)")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.vertical, 0.7)
                    .padding(.horizontal, 0.7)
                    .background(Color(red: 0.61, green: 0.79, blue: 0.92)) // Light blue
                    .cornerRadius(5)
                    .frame(width: 70)
                }
                Divider()

                // Luggage Section
                HStack {
                    Text("Luggage Quantity")
                        .font(Font.custom("Roboto Flex", size: 16))
                        .foregroundColor(.black)
                    Spacer()
                    Picker("Quantity", selection: $luggageQuantity) {
                        ForEach(1...maxPassengers, id: \.self) { i in
                            Text("\(i)")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.vertical, 0.7)
                    .padding(.horizontal, 0.7)
                    .background(Color(red: 0.61, green: 0.79, blue: 0.92))
                    .cornerRadius(5)
                    .frame(width: 70)
                }
                Divider()

                Spacer()

                // NavigationLink to Manual Entry
                NavigationLink(
                    destination: ManualFlightEntryView(),
                    isActive: $shouldNavigateToManualEntry
                ) {
                    EmptyView()
                }

                // NavigationLink to Scheduled Ride
                NavigationLink(
                    destination: ScheduledRideView(
                        flightInfo: fetchedFlightInfo ?? FlightInfo(
                            flnr: "N/A",
                            date: "",
                            scheduledDepartureLocal: "",
                            departureName: "",
                            arrivalTerminal: ""
                        ),
                        flightDate: flightDate,
                        numberOfPassengers: numberOfPassengers,
                        luggageQuantity: luggageQuantity,
                        flightTime: fetchedTime
                    ),
                    isActive: $shouldNavigateToScheduledRide
                ) {
                    EmptyView()
                }

                // Save Button
                Button(action: fetchFlightInfo) {
                    Text("Save this Flight")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.0, green: 0.22, blue: 0.39)) // Navy blue
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .disabled(isFetching || flightNumber.isEmpty)

                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func fetchFlightInfo() {
        isFetching = true

        let urlString = "https://flightera-flight-data.p.rapidapi.com/flight/info?flnr=\(flightNumber)"
        guard let url = URL(string: urlString) else {
            isFetching = false
            shouldNavigateToManualEntry = true
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("12f6dc954cmsh240a548da4506dap1aef90jsn1fa359867ca6", forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("flightera-flight-data.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isFetching = false

                if let error = error {
                    print("Error fetching flight info: \(error.localizedDescription)")
                    shouldNavigateToManualEntry = true
                    return
                }

                guard let data = data else {
                    shouldNavigateToManualEntry = true
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let flightInfoArray = try decoder.decode([FlightInfo].self, from: data)

                    if let firstFlightInfo = flightInfoArray.first {
                        fetchedFlightInfo = firstFlightInfo

                        // Extract and format time from scheduledDepartureLocal
                        if let apiTimeString = firstFlightInfo.scheduledDepartureLocal,
                           let apiTime = ISO8601DateFormatter().date(from: apiTimeString) {
                            fetchedTime = apiTime
                        } else {
                            fetchedTime = Date() // Default to now if time parsing fails
                        }

                        shouldNavigateToScheduledRide = true
                    } else {
                        shouldNavigateToManualEntry = true
                    }
                } catch {
                    print("Error decoding response: \(error.localizedDescription)")
                    shouldNavigateToManualEntry = true
                }
            }
        }.resume()
    }
}
