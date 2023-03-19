//
//  CoreDataWithMVVmView.swift
//  coreDataDemo
//
//  Created by Ankush on 13/03/23.
//

import SwiftUI

struct CoreDataWithMVVmView: View {
    
    @StateObject var modelObj: UserViewModel = UserViewModel()
    
    @State var firstNameStr: String = ""
    @State var lastNameStr: String = ""
    
    @State var updateUserStr: String = ""
    @State var update: Bool = false
    
    @State private var selectedMovie: UserEntity? = nil
    
    var body: some View {
        NavigationView {
            
            VStack {
                VStack {
                    HStack {
                        TextField("Add first Name", text: $firstNameStr)
                            .font(.headline)
                            .frame(height: 44.0)
                        
                        TextField("Add last Name", text: $lastNameStr)
                            .font(.headline)
                            .frame(height: 44.0)
                    }
                    
                    Button {
                        withAnimation {
                            if self.firstNameStr != "" && self.lastNameStr != "" {
                                self.modelObj.addUser(firstName: self.firstNameStr , lastName: self.lastNameStr)
                                self.firstNameStr = ""
                                self.lastNameStr = ""
                            }
                            
                        }
                    } label: {
                        Text("Add User")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(width: UIScreen.main.bounds.width - 70)
                        .foregroundColor(Color.white)
                        .padding(.all)
                    }
                    .background(.cyan)
                }
                .padding(.all)
                
                
                List {
                    ForEach(modelObj.users) { user in
                        
                        
                        Text(self.getStr(fName: user.firstName, lName: user.lastName))
                            .onTapGesture {
                                selectedMovie = user
                                update.toggle()
                            }
                            .alert("Update", isPresented: $update) {
                                TextField("current user: \(selectedMovie?.firstName ?? "")", text: $updateUserStr)
                                
                                Button {
                                    modelObj.updateItem(user: selectedMovie, itemName: self.updateUserStr)
                                } label: {
                                    Text("Update")
                                }

                            }
                    }
                    
                    .onDelete(perform: modelObj.deleteItems(offsets: ))
                }
            }
            
            .navigationTitle("User List")
        }
    }
    
    func getStr(fName: String?, lName: String?) -> String {
        
        var str = "\(fName ?? "") : "
        str += lName ?? ""
        return str
    }
}

struct CoreDataWithMVVmView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataWithMVVmView()
    }
}
