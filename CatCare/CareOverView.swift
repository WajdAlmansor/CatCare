//
//  CareOverView.swift
//  CatCare
//
//  Created by Wajd on 26/03/1446 AH.
//

import SwiftUI

struct CareOverView: View {
    
    var body: some View {
        Text(makeAttributedText())
    .font(.custom("SF Pro Regular", size: 28))
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .padding()   .position(x: 100, y: 104)
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


#Preview {
    CareOverView()
}

