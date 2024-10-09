import SwiftUI

struct ChooseCat: View {
    // List of cat images
    let catImages = ["cat1", "cat2", "cat3", "cat4", "cat5"]
    
    // State variables
    @State private var currentIndex = 0 // Track the current image index
    @AppStorage("catName") private var catName: String = "" // Store cat name in UserDefaults
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background image
                Image("orange normal")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Title section
                    HStack {
                        Text("Choose your")
                            .font(.title)
                            .fontWeight(.medium)
                            .padding(.top, 100)
                        Text("cat")
                            .font(.title)
                            .fontWeight(.medium)
                            .padding(.top, 100)
                            .foregroundColor(.orange)
                    }
                    
                    Spacer() // Add space between title and image slider
                    
                    // Image slider section
                    HStack {
                        // Left button to navigate through images
                        Button(action: {
                            if currentIndex > 0 {
                                currentIndex -= 1
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.largeTitle)
                                .padding()
                        }
                        .disabled(currentIndex == 0) // Disable if at the first image
                        
                        // Display the current cat image
                        Image(catImages[currentIndex])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                        
                        // Right button to navigate through images
                        Button(action: {
                            if currentIndex < catImages.count - 1 {
                                currentIndex += 1
                            }
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.largeTitle)
                                .padding()
                        }
                        .disabled(currentIndex == catImages.count - 1) // Disable if at the last image
                    }
                    
                    Spacer() // Add space between the image slider and the text field
                    
                    // Cat name input field
                    TextField("Enter cat name", text: $catName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 20)
                    
                    // Next button to navigate to CareOverView
                    NavigationLink(destination: CareOverView(selectedImageIndex: currentIndex)) {
                        Text("Next")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(25)
                            .padding(.horizontal, 90)
                            .offset(y: -10)
                    }
                    .disabled(catName.isEmpty) // Disable button if no cat name is entered
                    
                    Spacer() // Add space at the bottom
                }
            }
        }
    }
}

struct CatSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseCat()
    }
}
