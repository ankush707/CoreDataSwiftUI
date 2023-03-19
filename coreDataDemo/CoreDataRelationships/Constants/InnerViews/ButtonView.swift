//
//  ButtonView.swift
//  coreDataDemo
//
//  Created by Ankush on 18/03/23.
//

import Foundation
import SwiftUI

struct ButtonView: View {
    
    var title: String
    @Binding var buttonAction: Bool
    
    var body: some View {
        Button(action: {
            buttonAction.toggle()
        }, label: {
            TitleView(title: title)
                .fontWeight(.bold)
                .padding(.bottom)
        })
        .modifier(TextFieldViewModifier())
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Show departments", buttonAction: .constant(true))
    }
}
