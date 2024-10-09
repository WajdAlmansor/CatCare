import SwiftUI

struct CareOverView: View {
    // State variables for task completion
    @State private var isFirstFoodPawFilled = false
    @State private var isSecondFoodPawFilled = false
    @State private var isWaterPawFilled = false
    @State private var isLitterboxPawFilled = false
    
    // Store cat name in UserDefaults
    @AppStorage("catName") private var catName: String = ""
    
    // Receive selected image index as a parameter
    var selectedImageIndex: Int
    
    // List of cat images
    let catImages = ["cat1", "cat2", "cat3", "cat4", "cat5"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background image
                Image("orange normal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 500, height: 900)
                    .position(x: 200, y: 350)

                // Title "Care Overview"
                HStack {
                    Text("Care")
                        .foregroundColor(.orange)
                        .font(.custom("SF Pro Regular", size: 28))
                    Text("overview")
                        .font(.custom("SF Pro Regular", size: 28))
                }
                .position(x: 100, y: 104)

                // Main content: Cat image and task sections
                HStack(spacing: 30) {
                    // Left card with cat image
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.customOrange)
                        .frame(width: 144, height: 170)
                        .overlay(
                            // Navigation link to PerCheck with selected cat image
                            NavigationLink(destination: PerCheck()) {
                                Image(catImages[selectedImageIndex])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                            }
                        )
                    
                    // Right card with cat name and task sections
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.customOrange)
                        .frame(width: 200, height: 170)
                        .overlay(
                            VStack(spacing: 5) {
                                // Display cat name or default text
                                Text(catName.isEmpty ? "CatName" : catName)
                                    .offset(x: -50, y: -10)
                                    .foregroundColor(.black)
                                
                                // Food section
                                HStack {
                                    Text("Food")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 15)
                                    
                                    HStack(spacing: 5) {
                                        // First paw print toggle for food
                                        Image(systemName: isFirstFoodPawFilled ? "pawprint.fill" : "pawprint")
                                            .foregroundColor(.black)
                                            .onTapGesture {
                                                isFirstFoodPawFilled.toggle()
                                            }
                                        
                                        // Second paw print toggle for food, only if the first is filled
                                        Image(systemName: isSecondFoodPawFilled ? "pawprint.fill" : "pawprint")
                                            .foregroundColor(.black)
                                            .onTapGesture {
                                                if isFirstFoodPawFilled {
                                                    isSecondFoodPawFilled.toggle()
                                                }
                                            }
                                            .opacity(isFirstFoodPawFilled ? 1.0 : 0.5)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                }
                                .padding(.top, 5)
                                
                                // Separator line
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 200, height: 2)
                                
                                // Water section
                                HStack {
                                    Text("Water")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 15)
                                    
                                    // Paw print toggle for water
                                    HStack(spacing: 5) {
                                        Image(systemName: isWaterPawFilled ? "pawprint.fill" : "pawprint")
                                            .foregroundColor(.black)
                                            .onTapGesture {
                                                isWaterPawFilled.toggle()
                                            }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                }
                                .padding(.top, 5)
                                
                                // Separator line
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 200, height: 2)
                                
                                // Litterbox section
                                HStack {
                                    Text("Litterbox")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 15)
                                    
                                    // Paw print toggle for litterbox
                                    Image(systemName: isLitterboxPawFilled ? "pawprint.fill" : "pawprint")
                                        .foregroundColor(.black)
                                        .onTapGesture {
                                            isLitterboxPawFilled.toggle()
                                        }
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                .padding(.top, 5)
                            }
                            .padding(.top, 15)
                        )
                }
                .padding(.top, 150)
                .position(x: 200, y: 150)
                
                // Plus button at the top right
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: ChooseCat()) {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                        }
                        .padding()
                    }
                    Spacer()
                }
            }
        }
    }
}

// Custom color extension
extension Color {
    static let customOrange = Color(red: 1.0, green: 0.776, blue: 0.631)  // #FFC6A1
}

#Preview {
    CareOverView(selectedImageIndex: 0) // Default index for preview
}
