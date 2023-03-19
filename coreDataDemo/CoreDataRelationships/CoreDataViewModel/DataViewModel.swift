//
//  DataViewModel.swift
//  coreDataDemo
//
//  Created by Ankush on 17/03/23.
//

import Foundation
import UIKit
import CoreData

class DataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var businessesArr: [BusinessesEntity] = []
    @Published var departmentsArr: [DepartmentsEntity] = []
    @Published var employessArr: [EmployeesEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "coreDataDemo")
        
        container.loadPersistentStores { description, error in
            if let errorObj = error {
                print("Error in loading container: \(errorObj)")
                return
            }
            self.fetchBusinesses()
            self.fetchDepartments()
            self.fetchEmployess()
        }
    }
}


extension DataViewModel {
    
    //add Businesses
    func addBusiness(name: String, department: [String], employee: [String]) {
        
        let business = BusinessesEntity(context: container.viewContext)
        
        business.name = name
        if department.count > 0 {
            let set = NSMutableSet()
            for deptObj in departmentsArr {
                if department.contains(deptObj.name ?? "") {
                    set.add(deptObj)
                }
            }
          
            business.departments = set
        }
        
        if employee.count > 0 {
            let set = NSMutableSet()
            for empObj in employessArr {
                if employee.contains(empObj.name ?? "") {
                    set.add(empObj)
                }
            }
          
            business.employees = set
        }
        
        self.saveData()
        self.fetchBusinesses()
    }
    
    //add Departments
    func addDepartment(name: String, business: [String], employee: [String]) {
        let department = DepartmentsEntity(context: container.viewContext)
        department.name = name
        
        if business.count > 0 {
            let set = NSMutableSet()
            for busObj in businessesArr {
                if business.contains(busObj.name ?? "") {
                    set.add(busObj)
                }
            }
          
            department.businesses = set
        }
        
        
        if employee.count > 0 {
            let set = NSMutableSet()
            for empObj in employessArr {
                if employee.contains(empObj.name ?? "") {
                    set.add(empObj)
                }
            }
          
            department.employees = set
        }
        
        
        self.saveData()
        self.fetchDepartments()
    }
    
    //add Employees
     func addEmployee(name: String,dob: Date,salary: Int32, business: [String], department: [String]) {
        
        let employee = EmployeesEntity(context: container.viewContext)
        
        employee.name = name
        employee.dob = dob
        employee.salary = salary
         
         
         if business.count > 0 {
             
             for businessObj in businessesArr {
                 if business.contains(businessObj.name ?? "") {
                     employee.businees = businessObj
                 }
             }
         }
         
         if department.count > 0 {
             
             for deptObj in departmentsArr {
                 if department.contains(deptObj.name ?? "") {
                     employee.department = deptObj
                 }
             }
             
         }
         
         self.saveData()
         self.fetchEmployess()
    }
    
    
    
}


//MARK: - Fetching and Saving Data in Container
extension DataViewModel {
    
    //Save data in conatiner
    private func saveData() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error in saving Data: \(error)")
        }
    }
    
    private func fetchBusinesses() {
        
        let businessFetchRequest = NSFetchRequest<BusinessesEntity>(entityName: "BusinessesEntity")
        
        do {
            businessesArr = try container.viewContext.fetch(businessFetchRequest)
        } catch let error {
            print("error in fetching businesses: \(error)")
        }
    }
    
    private func fetchDepartments() {
        
        let departmentsFetchRequest = NSFetchRequest<DepartmentsEntity>(entityName: "DepartmentsEntity")
        
        do {
            departmentsArr = try container.viewContext.fetch(departmentsFetchRequest)
        } catch let error {
            print("error in fetching departments : \(error)")
        }
        
    }
    
    private func fetchEmployess() {
        let employeesFetchRequest = NSFetchRequest<EmployeesEntity>(entityName: "EmployeesEntity")
        
        do {
            employessArr = try container.viewContext.fetch(employeesFetchRequest)
        } catch let error {
            print("error in fetching employees: \(error)")
        }
    }
}
