//
//  CustomToolBarView.swift
//  coreDataDemo
//
//  Created by Ankush on 17/03/23.
//

import SwiftUI

struct CustomToolBarView: View {
    
    @Binding var moveToAddBusiness: Bool
    @Binding var moveToAddDepartment: Bool
    @Binding var moveToAddEmployee: Bool
    
    var body: some View {
        HStack(spacing: 4.0) {
            
            Button {
                moveToAddBusiness.toggle()
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 18, height: 18.0)
                        .foregroundColor(.black)
                    Text("Business")
                        .modifier(ToolBarTextViewModifier())
                }
                .modifier(ToolBarButtonViewModifier(color: .cyan))
            }
            
            Button {
                moveToAddDepartment.toggle()
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 18, height: 18.0)
                        .foregroundColor(.black)
                    Text("Department")
                        .foregroundColor(.black)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .modifier(ToolBarButtonViewModifier(color: .green))
                
            }
            
            Button {
                moveToAddEmployee.toggle()
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 18, height: 18.0)
                        .foregroundColor(.black)
                    Text("Employee")
                        .modifier(ToolBarTextViewModifier())
                }
                .modifier(ToolBarButtonViewModifier(color: .red))
            }
        }
        .padding(.horizontal, 6.0)
    }
}

struct CustomToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        CustomToolBarView(moveToAddBusiness: .constant(true), moveToAddDepartment: .constant(true), moveToAddEmployee: .constant(true))
    }
}
