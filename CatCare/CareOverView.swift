//
//  CareOverView.swift
//  CatCare
//
//  Created by Wajd on 26/03/1446 AH.
//

import SwiftUI

struct CareOverView: View {
    
    var body: some View {
        
        ZStack{
           
    Image("orange normal")
    .resizable()
    .scaledToFit()
    .frame(width: 500, height: 900)
    .position(x: 200, y: 350)
     
            
            
            
    Text(makeAttributedText())
        .font(.custom("SF Pro Regular", size: 28))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()   .position(x: 100, y: 104)
            
            
            HStack(spacing: 30) {
        RoundedRectangle(cornerRadius: 20)
        .fill(Color.customOrange)
        .frame(width: 144, height: 170)
        
        
        RoundedRectangle(cornerRadius: 20)
        .fill(Color.customOrange)
        .frame(width: 200, height: 170)
        .overlay(
            
            
  VStack( spacing:5) {
      Text("CatName")
          .offset(x:-50,y:-10)
          .foregroundColor(.white)
          //.font(.system(size: 15))
                                    
      Text("Food")
       .font(.headline)
  .foregroundColor(.black)
    .frame(maxWidth: .infinity, alignment: .leading)
 .padding(.leading, 15)

                                           
                
                       
                
 Rectangle()
.fill(Color.white)
.frame(width: 200, height: 2)

 Text("Water")
   .font(.headline)
  .foregroundColor(.black)
  .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.leading, 15)
                
Rectangle()
.fill(Color.white)
.frame(width: 200, height: 2)
                                       
                                    
Text("Literbox")
  .font(.headline)
 .foregroundColor(.black)
  .frame(maxWidth: .infinity, alignment: .leading)
   .padding(.leading, 15)
}
    .padding(.top, 15)
  )
                
                       }
            
      .padding(.top, 150)
      .position(x: 200, y: 150)
        }
       
    }

func makeAttributedText() -> AttributedString {
       var attributedString = AttributedString("Care overview")

       if let range = attributedString.range(of: "Care") {
           attributedString[range].foregroundColor = .orange
       }

       if let range = attributedString.range(of: "overview") {
           attributedString[range].foregroundColor = .black
       }
       
       return attributedString
   }
}

extension Color {
    static let customOrange = Color(red: 1.0, green: 0.776, blue: 0.631)  // #FFC6A1
}


#Preview {
    CareOverView()
}

