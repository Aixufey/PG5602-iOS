//
//  StoreView.swift
//  lesson3
//
//  Created by Jack Xia on 23/10/2023.
//

import SwiftUI
import CoreData

struct StoreView: View {
    
    // Environment var for App to reference this with .manageObjectContext
    @Environment(\.managedObjectContext) var moc
    
    // When fetching from database, we need to sort it on a type, here we sort by name ascending of collection type FetchedResults
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var stores: FetchedResults<Store>
    
    var body: some View {

        
        VStack {
            ForEach(stores) { store in
                VStack {
                    Text(store.name ?? "N/A")
                    // Text(store.latitude) maybe need more than key: "name" ??
                }
                
                
            }
            
            Button("Insert store") {
                // Store is auto generated according to Entity Model which we created
                let entity = NSEntityDescription.entity(forEntityName: "Store", in: moc)!
                let store = Store(entity: entity, insertInto: moc)
                store.name = "testbutikk 1"
                store.longtitude = 10.31234
                store.latitude = 52.12315
                store.openingHour = Date().description(with: .current)
                
                moc.saveAndPrintError()
                
            } // Button
            
            // Deleting in Core Data
            Button("Delete all") {
                for store in stores {
                    moc.delete(store)
                }
                
                moc.saveAndPrintError()
            }
            
        } // VStack
        .onAppear {
            if moc.hasChanges {
                moc.rollback()
            } else {
                
            }
        }
    } // body
}

struct StoreView_Previews: PreviewProvider {
    static var previews: some View {
        StoreView()
    }
}


// Extension is extention a custom helper function to the existing NSManagedObjectcontext
// A refactoring of code.
extension NSManagedObjectContext {
    func saveAndPrintError() {
        do {
            try self.save()
        } catch let error {
            print(error)
        }
    }
}
