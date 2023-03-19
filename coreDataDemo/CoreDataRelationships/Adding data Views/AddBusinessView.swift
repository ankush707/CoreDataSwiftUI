//
//  AddBusinessView.swift
//  coreDataDemo
//
//  Created by Ankush on 17/03/23.
//

import SwiftUI



struct AddBusinessView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModelObj: DataViewModel
    
    
    @State var businessStr: String = ""
    
    @State var showDepartments: Bool = false
    @State var showEmployees: Bool = false
    
    @State var deptArr: [String] = []
    @State var empArr: [String] = []
    
    @State var employessDict: [[String: Any]] = []
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    Image(systemName: "arrowshape.backward.fill")
                        .resizable()
                        .frame(width: 18, height: 18.0)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    Text("Add Business")
                        .modifier(TitleViewModifier())
                    Spacer()
                }
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
                ScrollView(.vertical) {
                    
                    VStack(alignment: .leading) {
                        
                        Group {
                            TitleView(title: "Business Name:")
                            TextField("Enter business name", text: $businessStr)
                                .modifier(TextFieldViewModifier())
                        }
                        
                        
                        Group {
                            
                            TitleView(title: "Departments:")
                            ButtonView(title: "Show departments", buttonAction: $showDepartments)
                            
                            if showDepartments {
                                LazyVStack {
                                    ForEach(viewModelObj.departmentsArr, id: \.self) { deps in
                                        if let str = deps.name {
                                            ListInnerButtonView(str: str, tempArr: $deptArr, singleSelectionBool: false)
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
                            if !businessStr.isEmpty {
                                viewModelObj.addBusiness(name: businessStr, department: self.deptArr, employee: self.empArr)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }, label: {
                            Text("SAVE")
                                .modifier(SaveViewModifier())
                            
                        })
                        .padding(.top, 32.0)
                        
                    }//Outter V stack
                    .frame(maxWidth: .infinity)
                    .padding(.all)
                }
            }//Scroll View
            
        }//Navigation View
        .navigationBarHidden(true)
    }//Body
}

struct AddBusinessView_Previews: PreviewProvider {
    static var previews: some View {
        AddBusinessView(viewModelObj: DataViewModel())
    }
}
