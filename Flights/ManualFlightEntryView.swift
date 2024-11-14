import SwiftUI

struct ManualFlightEntryView: View {
    @State private var flightNumber: String = ""
    @State private var airport: String = ""
    @State private var terminal: String = ""
    @State private var airline: String = ""
    @State private var timeAtAirport: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Sorry, we couldn’t match your flight")
                .font(.title2)
                .bold()
                .padding(.top)
            
            Text("You can try entering your flight number again")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            TextField("Flight Number", text: $flightNumber)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .padding(.bottom, 16)
            
            // Corrected "OR" with horizontal dividers
            HStack {
                Divider().frame(height: 1).background(Color.gray)
                Text("OR")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Divider().frame(height: 1).background(Color.gray)
            }
            .padding(.vertical, 8)
            
            Text("Enter Flight Details Manually")
                .font(.headline)
            
            TextField("Airport", text: $airport)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(5)
            
            TextField("Terminal", text: $terminal)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(5)
            
            TextField("Airline", text: $airline)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(5)
            
            TextField("Time at airport", text: $timeAtAirport)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(5)
            
            Spacer()
            
            HStack {
                Spacer()
                Button(action: {
                    // Handle manual entry submission
                }) {
                    Image(systemName: "arrow.right")
                        .font(.title)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding(.bottom, 20)
            }
        }
        .padding(.horizontal)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
