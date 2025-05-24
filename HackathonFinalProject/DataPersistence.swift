import Foundation
import CoreData
import SwiftUI
class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "DataModel") //Load the core data model
    
    static let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0].appending(path: "DataModel.sqlite")
    
    
    let description = NSPersistentStoreDescription.init(url: url)
    
    init() { //Set up the core data model
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = false
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { descriptions, error in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
            }
        }
    }
    
    
}
extension Binding { //Add an extension to the binding class that unwraps optional binded values
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

