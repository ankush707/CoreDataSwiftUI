//
//  ContentView.swift
//  coreDataDemo
//
//  Created by Ankush on 10/03/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Users.name, ascending: true)],
        animation: .default)
    private var users: FetchedResults<Users>

    @State var userStr: String = ""
    @State var updateUserStr: String = ""
    @State var update: Bool = false
    
    @State private var selectedMovie: Users? = nil
    
    var body: some View {
        NavigationView {
            
            VStack {
                VStack {
                    
                    TextField("Add user here", text: $userStr)
                        .font(.headline)
                        .frame(height: 44.0)
                    Button {
                        self.addItem(itemName: self.userStr)
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
                    ForEach(users) { user in
                        
                        Text(user.name ?? "")
                            .onTapGesture {
                                selectedMovie = user
                                update.toggle()
                            }
                            .alert("Update", isPresented: $update) {
                                TextField("current user: \(selectedMovie?.name ?? "")", text: $updateUserStr)
                                
                                Button {
                                    self.updateItem(user: selectedMovie, itemName: self.updateUserStr)
                                } label: {
                                    Text("Update")
                                }

                            }
                    }
                    
                    .onDelete(perform: deleteItems)
                }
            }
            
            .navigationTitle("User List")
        }
    }

    private func addItem( itemName: String) {
        withAnimation {
            if itemName != "" {
                let newItem = Users(context: viewContext)
                newItem.name = itemName
                self.userStr = ""
                self.saveData()
                
            }
        }
    }

    private func updateItem(user: Users? ,itemName: String) {
        withAnimation {
            if itemName != "" {
                
                user?.name = itemName
                self.updateUserStr = ""
                self.saveData()
                
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { users[$0] }.forEach(viewContext.delete)

            self.saveData()
        }
    }
    
    private func saveData() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
