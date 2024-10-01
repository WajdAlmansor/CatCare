import SwiftUI

struct ChooseCat: View {
    @State private var catName: String = ""

    var body: some View {
        ZStack {
            // Background image
            Image("orange normal") // The background image you saved in Assets
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()

            VStack {
                Spacer()

                // Title: Choose your cat
                Text("Choose your")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.black) +
                Text(" cat")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(.orange)

                Spacer()

                // Cat image with left and right arrows
                HStack {
                    Button(action: {
                        // Action for previous cat
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    Image("catImage") // Replace with your cat image asset
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)

                    Spacer()

                    Button(action: {
                        // Action for next cat
                    }) {
                        Image(systemName: "chevron.right")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 40)

                Spacer()

                // Cat name text field
                Text("What’s your cat name?")
                    .font(.headline)

                TextField("Enter cat name", text: $catName)
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(10)
                    .frame(width: 300)

                // Next button
                Button(action: {
                    // Next action
                }) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(Color.orange)
                        .cornerRadius(25)
                }
                .padding(.top, 20)

                Spacer()
            }
            .padding()
        }
    }
}

struct CatSelectionView_Previews: PreviewProvider {
    static var previews: some View {
       ChooseCat()
    }
}
