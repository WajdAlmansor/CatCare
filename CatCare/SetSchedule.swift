import SwiftUI

struct SetSchedule: View {

    // State properties to manage user input and data
    @State private var wakeUp = Date.now // Time to wake up
    @State private var vaccinationDate = Date.now // Date for vaccination
    // Array to store multiple food times with their frequency
    @State private var foodTimes: [(time: Date, frequency: FoodFrequency)] = [(Date.now, .oneTime)]
    @State private var waterTime = Date.now // Time for water
    @State private var litterboxTime = Date.now // Time for litterbox

    // Enumeration for general frequency options
    enum Frequency: String, CaseIterable {
        case daily = "Daily"
        case weekly = "Weekly"
        case monthly = "Monthly"
    }

    // Enumeration for water frequency options
    enum WaterFrequency: String, CaseIterable {
        case daily = "Daily"
        case twiceDaily = "Twice Daily"
        case threeTimesDaily = "3 Times Daily"
    }

    // Enumeration for food frequency options
    enum FoodFrequency: String, CaseIterable {
        case daily = "Daily"
        case oneTime = "One-Time"
    }

    @State private var waterFrequency: WaterFrequency = .daily // Default water frequency
    @State private var literboxFrequency: Frequency = .daily // Default litterbox frequency

    // Closure for saving tasks
    var onSave: (([Task]) -> Void)?
    @State private var navigateToOverview: Bool = false // Navigation flag for overview
    @State private var tasks: [Task] = [] // Array to hold tasks

    var body: some View {
        
        // Navigation stack for managing views
        NavigationStack {
            ZStack {
                Color("backgroundGray").ignoresSafeArea() // Background color
                // Background image for the view
                Image("orange normal")
                    .resizable()
                    .scaledToFit()
                    .padding(-60)
                
                VStack(spacing: 20) {
                    
                    // Header Section with title and subtitle
                    VStack(alignment: .leading, spacing: 100) {
                        Text("Schedule")
                            .offset(x:-3,y:100)
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(Color.orange)
                        Text("your cat needs")
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                    .padding(.top, 20) // Adjusted top padding
                    
                    // Scrollable content starts here
                    VStack(spacing: 24) {
                        
                        // Food Section
                        ScrollView {
                            VStack(spacing: 30) {
                                Divider() // Divider for food section
                                Text("Food")
                                    .offset(x:-143)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.bottom, -10)
                                    .frame(alignment: .leading)
                                
                                // Loop through foodTimes to create UI for each food time
                                ForEach(foodTimes.indices, id: \.self) { index in
                                    HStack {
                                        Text("Time \(index + 1)") // Displaying the food time index
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                        Spacer()
                                        
                                        // Picker for selecting frequency of food
                                        Picker("Frequency", selection: $foodTimes[index].frequency) {
                                            ForEach(FoodFrequency.allCases, id: \.self) { frequency in
                                                Text(frequency.rawValue)
                                            }
                                        }
                                        .pickerStyle(MenuPickerStyle())
                                        .frame(width: 100)
                                        
                                        // DatePicker for selecting time for food
                                        DatePicker("", selection: $foodTimes[index].time, displayedComponents: .hourAndMinute)
                                            .labelsHidden()
                                            .frame(width: 100)
                                        
                                        // Button to delete the food time entry
                                        Button(action: {
                                            foodTimes.remove(at: index) // Remove food time at index
                                        }) {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                        .buttonStyle(BorderlessButtonStyle()) // Prevent row tap while deleting
                                    }
                                }
                                
                                // Button to add more food times
                                Button(action: {
                                    foodTimes.append((time: Date.now, frequency: .oneTime)) // Add new food time entry
                                }) {
                                    Text("Add food time +")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                            }
                            
                            Divider() // Divider between Food and Water Sections
                            
                            // Water Section
                            HStack {
                                Text("Water")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                // Picker for selecting water frequency
                                Picker("", selection: $waterFrequency) {
                                    ForEach(WaterFrequency.allCases, id: \.self) { frequency in
                                        Text(frequency.rawValue)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(width: 100)
                                // DatePicker for selecting time for water
                                DatePicker("", selection: $waterTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .frame(width: 100)
                            }
                            .padding(15)
                            
                            Divider() // Divider for separation
                            
                            // Litterbox Section
                            HStack {
                                Text("Litterbox")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                // Picker for selecting litterbox frequency
                                Picker("", selection: $literboxFrequency) {
                                    ForEach(Frequency.allCases, id: \.self) { frequency in
                                        Text(frequency.rawValue)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(width: 100)
                                // DatePicker for selecting time for litterbox
                                DatePicker("", selection: $litterboxTime, displayedComponents: .hourAndMinute)
                                    .labelsHidden()
                                    .frame(width: 100)
                            }
                            .padding(15)
                            
                            Divider() // Divider for separation
                            
                            // Vaccination Section
                            HStack {
                                Text("Appointment")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                // DatePicker for selecting vaccination date
                                DatePicker("", selection: $vaccinationDate, displayedComponents: .date)
                                    .datePickerStyle(CompactDatePickerStyle())
                                    .labelsHidden()
                                    .frame(width: 100)
                            }
                            .padding(15)
                        }
                        .background(
                            // Background for the scrollable content
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.white)
                                .shadow(radius: 5)
                        )
                        .padding(.horizontal, 20)
                        
                        // Done Button to save tasks and navigate to the overview
                        Button(action: {
                            saveTasks() // Call to save tasks
                            navigateToOverview = true // Trigger navigation
                        }) {
                            Text("Done")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange) // Button background color
                                .cornerRadius(25)
                        }
                        .padding(.horizontal, 90)
                        .padding(.top, 20) // Added top padding for better spacing
                        
                    }
                }
                .edgesIgnoringSafeArea(.top) // Ignore safe area for top edges
                // Navigation to CareOverView when navigateToOverview is true
                .navigationDestination(isPresented: $navigateToOverview) {
                    CareOverView(selectedImageIndex: 0)
                }
            }
        }
    }

    // Function to save tasks
    private func saveTasks() {
        // Create food tasks from foodTimes array
        let foodTaskTimes = foodTimes.map { foodTime in
            Task(time: DateFormatter.localizedString(from: foodTime.time, dateStyle: .none, timeStyle: .short), name: "Feed", isCompleted: false, frequency: foodTime.frequency.rawValue)
        }
        // Create an array of tasks including water, litterbox, and vaccination
        let tasks: [Task] = foodTaskTimes + [
            Task(time: DateFormatter.localizedString(from: waterTime, dateStyle: .none, timeStyle: .short), name: "Water", isCompleted: false, frequency: waterFrequency.rawValue),
            Task(time: DateFormatter.localizedString(from: litterboxTime, dateStyle: .none, timeStyle: .short), name: "Litterbox", isCompleted: false, frequency: literboxFrequency.rawValue),
            Task(time: DateFormatter.localizedString(from: vaccinationDate, dateStyle: .medium, timeStyle: .none), name: "Vaccination", isCompleted: false, frequency: "Once")
        ]
        onSave?(tasks) // Call onSave closure with the created tasks
    }
}

// Preview provider for SetSchedule view
struct SetSchedule_Previews: PreviewProvider {
    static var previews: some View {
        SetSchedule()
    }
}
