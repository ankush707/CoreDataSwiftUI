//
//  ListInnerButtonView.swift
//  coreDataDemo
//
//  Created by Ankush on 18/03/23.
//

import SwiftUI

struct ListInnerButtonView: View {
    
    var str: String
    @Binding var tempArr: [String]
    
    var singleSelectionBool: Bool
    
    var body: some View {
        Button {
            withAnimation(.easeInOut) {
                if !tempArr.contains(str) {
                    if singleSelectionBool {
                        tempArr = []
                        tempArr.append(str)
                    } else {
                        tempArr.append(str)
                    }
                    
                    
                } else {
                    tempArr.removeAll { element in
                        element == str
                    }
                }
            }
        } label: {
            HStack {
                
                if tempArr.contains(str) {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 18, height: 18.0)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                }
                Text(str)
                
                Spacer()
            }
            .modifier(TextFieldViewModifier())
        }
    }
}

struct ListInnerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ListInnerButtonView(str: "Engineering", tempArr: .constant(["Marketing", "Engineering"]), singleSelectionBool: false)
    }
}
