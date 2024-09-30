import SwiftUI

struct CatNeedsView: View {
    var body: some View {
        VStack(spacing: 20) {
            
            // Header Section
            VStack(alignment: .leading, spacing: 8) {
             Spacer()
                               Text("Schedule")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(Color.orange)
                
                Text("your cat needs")
                    .font(.system(size: 18))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            
            // Background abstract shape
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color.orange.opacity(0.3))
                    .frame(width: 33, height: 120)
                    .offset(x: 100, y: -40)
            }
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            
            // Schedule list section
            VStack(spacing: 24) {
                
                // Food Section
                HStack {
                    Text("Food")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    LabelView(labelText: "Daily")
                    TimeView(timeText: "8:00 AM")
                }
                .padding(15)
                
                Divider()
                
                // Water Section
                HStack {
                    Text("Water")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    LabelView(labelText: "Daily")
                    TimeView(timeText: "8:00 AM")
                }
                .padding(15)
                
                Divider()
                
                // Literbox Section
                HStack {
                    Text("Literbox")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    LabelView(labelText: "Daily")
                    TimeView(timeText: "8:00 AM")
                }
                .padding(15)
                
                Divider()
                
                // Vaccination Section
                HStack {
                    Text("Vaccination")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    LabelView(labelText: "June 2020")
                }
                .padding(15)
                
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(radius: 5)
            )
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .offset(y:-60)
            
            // Done Button
            Button(action: {}) {
                Text("Done")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .cornerRadius(25)
            }
            .padding(.horizontal, 80)
            
            Spacer()
        }
       
        .background(Color(UIColor.systemGray6))
        .edgesIgnoringSafeArea(.all) // Ensures the background stretches edge to edge
    }
}

struct LabelView: View {
    var labelText: String
    
    var body: some View {
        Text(labelText)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(.orange)
            .padding(.vertical, 5)
            .padding(.horizontal, 12)
            .background(Color.orange.opacity(0.1))
            .cornerRadius(10)
    }
}

struct TimeView: View {
    var timeText: String
    
    var body: some View {
        Text(timeText)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(.orange)
            .padding(.vertical, 5)
            .padding(.horizontal, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.orange, lineWidth: 1)
            )
    }
}

struct CatNeedsView_Previews: PreviewProvider {
    static var previews: some View {
        CatNeedsView()
    }
}
