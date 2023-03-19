//
//  AddDepartmentView.swift
//  coreDataDemo
//
//  Created by Ankush on 17/03/23.
//

import SwiftUI

struct AddDepartmentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModelObj: DataViewModel
    
    @State var departmentStr: String = ""
    
    @State var showBusinesses: Bool = false
    @State var showEmployees: Bool = false
    
    @State var busArr: [String] = []
    @State var empArr: [String] = []
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    Image(systemName: "arrowshape.backward.fill")
                        .resizable()
                        .frame(width: 18, height: 18.0)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    Text("Add Department")
                        .modifier(TitleViewModifier())
                    Spacer()
                }
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
                
                ScrollView(.vertical) {
                    
                    VStack(alignment: .leading) {
                        
                        Group {
                            TitleView(title: "Department Name:")
                            TextField("Enter department name", text: $departmentStr)
                                .modifier(TextFieldViewModifier())
                        }
                        
                        
                        Group {
                            
                            TitleView(title: "Businesses:")
                            ButtonView(title: "Show Businesses", buttonAction: $showBusinesses)
                            
                            if showBusinesses {
                                LazyVStack {
                                    ForEach(viewModelObj.businessesArr, id: \.self) { deps in
                                        if let str = deps.name {
                                            ListInnerButtonView(str: str, tempArr: $busArr, singleSelectionBool: false)
                                        }
                                    }
                                }
                                .padding(.vertical, 6.0)
                            }
                        }
                        
                        
                        Group {
                            
                            TitleView(title: "Employees:")
                            ButtonView(title: "Show employees", buttonAction: $showEmployees)
                            
                            
                            if showEmployees {
                                
                                LazyVStack {
                                    ForEach(viewModelObj.employessArr, id: \.self) { emp in
                                        
                                        if let str = emp.name {
                                            ListInnerButtonView(str: str, tempArr: $empArr, singleSelectionBool: false)
                                        }
                                    }
                                }
                                .padding(.vertical, 6.0)
                            }
                        }
                        
                        Button(action: {
                            if !departmentStr.isEmpty {
                                viewModelObj.addDepartment(name: departmentStr, business: self.busArr, employee: self.empArr)
                                
                                presentationMode.wrappedValue.dismiss()
                            }
                        }, label: {
                            Text("SAVE")
                                .modifier(SaveViewModifier())
                            
                        })
                        .padding(.top, 32.0)
                    }
                }//Outter V stack
                .frame(maxWidth: .infinity)
                .padding(.all)
                
            }//ScrollView
        }//Navigation View
        .navigationBarHidden(true)
    }//body
}

struct AddDepartmentView_Previews: PreviewProvider {
    static var previews: some View {
        AddDepartmentView(viewModelObj: DataViewModel())
    }
}
