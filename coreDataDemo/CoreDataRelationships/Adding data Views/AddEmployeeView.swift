//
//  AddEmployeeView.swift
//  coreDataDemo
//
//  Created by Ankush on 17/03/23.
//

import SwiftUI

struct AddEmployeeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModelObj: DataViewModel
    
    @State var employeeStr: String = ""
    @State var salary: String = ""
    
    @State var showBusinesses: Bool = false
    @State var showDepartment: Bool = false
    @State var showDatePicker: Bool = false
    
    @State var busArr: [String] = []
    @State var dobStr: String = ""
    @State var deptArr: [String] = []
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    Image(systemName: "arrowshape.backward.fill")
                        .resizable()
                        .frame(width: 18, height: 18.0)
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    Text("Add Employee")
                        .modifier(TitleViewModifier())
                    Spacer()
                }
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        Group {
                            Text("Employee Name:")
                                .modifier(TitleViewModifier())
                            TextField("Enter employee name", text: $employeeStr)
                                .modifier(TextFieldViewModifier())
                            Text("Salary:")
                                .modifier(TitleViewModifier())
                            TextField("Enter salary", text: $salary)
                                .keyboardType(.numberPad)
                                .modifier(TextFieldViewModifier())
                            Text("Employee DOB:")
                                .modifier(TitleViewModifier())
                            
                            DatePicker(selection: .constant(Date()), label: { Text("Date") })
                        }
                        
                        Group {
                            
                            TitleView(title: "Businesses:")
                            ButtonView(title: "Show Businesses", buttonAction: $showBusinesses)
                            
                            if showBusinesses {
                                LazyVStack {
                                    ForEach(viewModelObj.businessesArr, id: \.self) { deps in
                                        if let str = deps.name {
                                            ListInnerButtonView(str: str, tempArr: $busArr, singleSelectionBool: true)
                                        }
                                    }
                                }
                                .padding(.vertical, 6.0)
                            }
                        }
                        
                        Group {
                            
                            TitleView(title: "Departments:")
                            ButtonView(title: "Show departments", buttonAction: $showDepartment)
                            
                            if showDepartment {
                                LazyVStack {
                                    ForEach(viewModelObj.departmentsArr, id: \.self) { deps in
                                        if let str = deps.name {
                                            ListInnerButtonView(str: str, tempArr: $deptArr, singleSelectionBool: true)
                                        }
                                    }
                                }
                                .padding(.vertical, 6.0)
                            }
                        }
                        
                        Button(action: {
                            if !employeeStr.isEmpty {
                                self.viewModelObj.addEmployee(name: employeeStr, dob: Date(), salary: Int32(salary) ?? 0, business: self.busArr, department: self.deptArr)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }, label: {
                            Text("SAVE")
                                .modifier(SaveViewModifier())
                            
                        })
                        .padding(.top, 32.0)
                    }//Outter V stack
                }//scroll view
                .frame(maxWidth: .infinity)
                .padding(.all)
            }//Scroll View
        }//Navigation View
        .navigationBarHidden(true)
    }//Body
}

struct AddEmployeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmployeeView(viewModelObj: DataViewModel())
    }
}
