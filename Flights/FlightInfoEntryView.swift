import SwiftUI

enum NavigationDestination: Hashable {
    case scheduledRide(flightInfo: FlightInfo, flightDate: String) // Include flightDate here
    case manualEntry
}

struct FlightInfoEntryView: View {
    @State private var flightNumber: String = ""
    @State private var flightDate: String = ""
    @State private var numberOfPassengers = 1
    @State private var luggageQuantity = 1
    @State private var flightInfo: FlightInfo?
    @State private var showError = false
    @State private var isFetching = false
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                // Main Form
                Form {
                    Section {
                        TextField("Flight Number", text: $flightNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numbersAndPunctuation)
                            .padding(.vertical, 8) // Additional padding to match UI
                        
                        TextField("Flight Date", text: $flightDate)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numbersAndPunctuation)
                            .padding(.vertical, 8) // Additional padding to match UI

                        Picker("Number of Passengers", selection: $numberOfPassengers) {
                            ForEach(1..<10, id: \.self) { i in
                                Text("\(i)")
                            }
                        }
                        .padding(.vertical, 8)
                        
                        Picker("Luggage Quantity", selection: $luggageQuantity) {
                            ForEach(1..<10, id: \.self) { i in
                                Text("\(i)")
                            }
                        }
                        .padding(.vertical, 8)
                    } header: {
                        // Section header styled to match UI
                        Text("FLIGHT INFO")
                            .font(.headline)
                            .foregroundColor(Color(red: 0/255, green: 56/255, blue: 101/255)) // Custom color #003865
                            .padding(.bottom, 4)
                    }
                }
                .background(Color(UIColor.systemBackground)) // Optional to match background color
                .scrollContentBackground(.hidden) // Hide default background for forms in SwiftUI
                
                Spacer()

                // Save Button
                Button(action: fetchFlightInfo) {
                    Text("Save this Flight")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0, green: 56/255, blue: 101/255)) // Custom color #003865
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 20) // Extra bottom padding to match UI
                .disabled(isFetching || flightNumber.isEmpty)
                
                if showError {
                    Text("Could not fetch flight info. Please try again.")
                        .foregroundColor(.red)
                        .padding(.top)
                }
            }
            .navigationTitle("Flight Info")
            .navigationBarTitleDisplayMode(.inline) // Inline title with back button
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .scheduledRide(let flightInfo, let flightDate):
                    ScheduledRideView(flightInfo: flightInfo, flightDate: flightDate)
                case .manualEntry:
                    ManualFlightEntryView()
                }
            }
        }
    }
    
    func fetchFlightInfo() {
        isFetching = true
        showError = false
        
        let urlString = "https://flightera-flight-data.p.rapidapi.com/flight/info?flnr=\(flightNumber)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("c1f1bfc7e1msh21da0f3e0296bd5p1c5466jsn34a8550d2a3c", forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("flightera-flight-data.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isFetching = false
                
                if let error = error {
                    print("Error fetching flight info: \(error)")
                    showError = true
                    navigationPath.append(NavigationDestination.manualEntry)
                    return
                }
                
                guard let data = data else {
                    showError = true
                    navigationPath.append(NavigationDestination.manualEntry)
                    return
                }
                
                // Decode JSON response as an array of FlightInfo
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let flightInfoArray = try decoder.decode([FlightInfo].self, from: data)
                    
                    // Check if there's at least one item in the array
                    if let firstFlightInfo = flightInfoArray.first {
                        self.flightInfo = firstFlightInfo
                        navigationPath.append(NavigationDestination.scheduledRide(flightInfo: firstFlightInfo, flightDate: flightDate))
                    } else {
                        showError = true
                        navigationPath.append(NavigationDestination.manualEntry)
                    }
                } catch {
                    print("Error decoding response: \(error.localizedDescription)")
                    showError = true
                    navigationPath.append(NavigationDestination.manualEntry)
                }
            }
        }.resume()
    }
}
