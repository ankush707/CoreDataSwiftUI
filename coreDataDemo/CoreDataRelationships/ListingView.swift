//
//  ListingView.swift
//  coreDataDemo
//
//  Created by Ankush on 17/03/23.
//

import SwiftUI

struct ListingView: View {
    
    @State var buttonPressed: Int = 0
    
    @State var moveToAddBusiness: Bool = false
    @State var moveToAddDepartment: Bool = false
    @State var moveToAddEmployee: Bool = false
    
    @StateObject var viewModel = DataViewModel()
    
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical) {
                
                Group {
                    NavigationLink(isActive: $moveToAddBusiness) {
                        AddBusinessView(viewModelObj: viewModel)
                    } label: {
                        EmptyView()
                    }
                    
                    NavigationLink(isActive: $moveToAddDepartment) {
                        AddDepartmentView(viewModelObj: viewModel)
                    } label: {
                        EmptyView()
                    }
                    
                    NavigationLink(isActive: $moveToAddEmployee) {
                        AddEmployeeView(viewModelObj: viewModel)
                    } label: {
                        EmptyView()
                    }
                }
                
                Group {
                    VStack(alignment: .leading) {
                        Text("Businesses")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.brown)
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(viewModel.businessesArr, id: \.self) { val in
                                    
                                    VStack(alignment: .leading) {
                                        Text(self.getName(nameStr: val.name))
                                            .modifier(HomeNameModifier())
                                        Text(self.getDepartmentsName(setOptional: val.departments))
                                            .modifier(HomeSubNamesModifier())
                                        Text(self.getEmployeesName(setOptional: val.employees))
                                            .modifier(HomeSubNamesModifier())
                                    }
                                    .modifier(HomeVstackModifier())
                                }
                            }
                        }
                        
                        Text("Departments")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.brown)
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(viewModel.departmentsArr, id: \.self) { val in
                                    
                                    VStack(alignment: .leading) {
                                        Text(self.getName(nameStr: val.name))
                                            .modifier(HomeNameModifier())
                                        Text(self.getBusinessesName(setOptional: val.businesses))
                                            .modifier(HomeSubNamesModifier())
                                        Text(self.getEmployeesName(setOptional: val.employees))
                                            .modifier(HomeSubNamesModifier())
                                    }
                                    .modifier(HomeVstackModifier())
                                }
                            }
                        }
                        
                        Text("Employees")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.brown)
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(viewModel.employessArr, id: \.self) { val in
                                    
                                    VStack(alignment: .leading) {
                                        Text(self.getName(nameStr: val.name))
                                            .modifier(HomeNameModifier())
                                        Text(self.getBusName(setOptional: val.businees))
                                            .modifier(HomeSubNamesModifier())
                                        Text(self.getDepName(setOptional: val.department))
                                            .modifier(HomeSubNamesModifier())
                                        
                                    }
                                    .modifier(HomeVstackModifier())
                                }
                            }
                            
                        }
                        
                    }
                }
                .padding(.horizontal)
            }//Outer Scroll view
            .navigationTitle("Core Data Example")
        }//Navigation view
        
        
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                
                CustomToolBarView(moveToAddBusiness: $moveToAddBusiness, moveToAddDepartment: $moveToAddDepartment, moveToAddEmployee: $moveToAddEmployee)
                    .padding(.horizontal, 12.0)
                
                
            }
        }
        
        
    }//body
    
    
    //Get Name
    private func getName(nameStr: String?) -> String {
        if let str = nameStr {
            return str
        }
        return ""
    }
    
    //Get Businesses
    private func getBusinessesName(setOptional: NSSet?) -> String {
        
        if let set = setOptional, set.count > 0 {
            var arrayStr : [String] = []
            for case let obj as BusinessesEntity in set.allObjects {
                arrayStr.append(obj.name ?? "")
                
            }
            let str = arrayStr.joined(separator: ", ")
            return "Businesses: " + str
        }
        return ""
    }
    
    //Get Departments
    private func getDepartmentsName(setOptional: NSSet?) -> String {
        
        if let set = setOptional, set.count > 0 {
            var arrayStr : [String] = []
            for case let obj as DepartmentsEntity in set.allObjects {
                arrayStr.append(obj.name ?? "")
                
            }
            let str = arrayStr.joined(separator: ", ")
            return "Departments: " + str
        }
        return ""
    }
    
    //Get Businesses
    private func getBusName(setOptional: BusinessesEntity?) -> String {
        
        if let set = setOptional {
            
            return "Business: " + (set.name ?? "")
        }
        return ""
    }
    
    //Get Departments
    private func getDepName(setOptional: DepartmentsEntity?) -> String {
        
        if let set = setOptional {
            
            return "Department: " + (set.name ?? "")
        }
        return ""
    }
    
    //Get Employees
    private func getEmployeesName(setOptional: NSSet?) -> String {
        if let set = setOptional, set.count > 0 {
            var arrayStr : [String] = []
            for case let obj as EmployeesEntity in set.allObjects {
                arrayStr.append(obj.name ?? "")
                
            }
            let str = arrayStr.joined(separator: ", ")
            return "Employees: " + str
        }
        return ""
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView()
    }
}
