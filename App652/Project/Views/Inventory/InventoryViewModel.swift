//
//  InventoryViewModel.swift
//  App652
//
//  Created by IGOR on 29/06/2024.
//

import SwiftUI
import CoreData

final class InventoryViewModel: ObservableObject {
    
    @AppStorage("added") var added: Int = 0

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    @Published var isSettings: Bool = false
    
    @Published var photos: [String] = ["1", "2", "3"]
    @Published var currentPhoto = ""
    
    @Published var statuses: [String] = ["New", "Used", "For repairs", "Defective"]
    @Published var currentStatus = ""

    @Published var inPhoto = ""
    @Published var inName = ""
    @Published var inQuantity = ""
    @Published var inModel = ""
    @Published var inStatus = ""

    @Published var inventories: [InventoryModel] = []
    @Published var selectedInventory: InventoryModel?

    func addInventory() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "InventoryModel", into: context) as! InventoryModel

        loan.inPhoto = inPhoto
        loan.inName = inName
        loan.inQuantity = inQuantity
        loan.inModel = inModel
        loan.inStatus = inStatus

        CoreDataStack.shared.saveContext()
    }

    func fetchInventories() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<InventoryModel>(entityName: "InventoryModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.inventories = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.inventories = []
        }
    }
}
