import SwiftUI

struct ChooseCat: View {
    // Cat image names from assets
    let catImages = ["cat1", "cat2", "cat3", "cat4"]  // Add your actual cat image names here
    
    // State variables
    @State private var currentIndex = 0  // To keep track of the currently displayed cat image
    @State private var catName = ""  // To store the cat's name input by the user
    
    var body: some View {
        ZStack {
            // Background image
            Image("orange normal")  // Use the background image from assets
                .resizable()
                .edgesIgnoringSafeArea(.all)  // Makes the background fill the whole screen
            
            VStack {
                // Title text
                
                HStack{
                    Text("Choose your")
                        .font(.title)
                        .fontWeight(.medium)
                        .padding(.top, 50)
                    Text("cat")
                        .font(.title)
                        .fontWeight(.medium)
                        .padding(.top, 50)
                        .foregroundColor(.orange)
                }
                //Text("Choose your")
                   // .font(.title)
                   // .fontWeight(.medium)
                  //  .padding(.top, 50)
                
                Spacer()
                    
                // Image slider for the cats with left and right arrows
                HStack {
                    // Left arrow
                    Button(action: {
                        if currentIndex > 0 {
                            currentIndex -= 1
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.largeTitle)
                            .padding()
                    }
                    .disabled(currentIndex == 0)  // Disable if already on the first cat
                    
                    // Cat image
                    Image(catImages[currentIndex])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    
                    // Right arrow
                    Button(action: {
                        if currentIndex < catImages.count - 1 {
                            currentIndex += 1
                        }
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.largeTitle)
                            .padding()
                    }
                    .disabled(currentIndex == catImages.count - 1)  // Disable if already on the last cat
                }
                
                Spacer()
                
                // Text field for the user to enter the cat's name
                TextField("Enter cat name", text: $catName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 20)
                
                // Next button
                Button(action: {
                    // Add your action for the next button here
                    print("Selected cat name: \(catName)")
                }) {
                    Text("Next")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
            }
          
        }
    }
}

struct CatSelectionView_previews: PreviewProvider {
    static var previews: some View {
       ChooseCat()
    }
}
