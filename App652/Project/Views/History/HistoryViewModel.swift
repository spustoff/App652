//
//  HistoryViewModel.swift
//  App652
//
//  Created by IGOR on 29/06/2024.
//

import SwiftUI
import CoreData

final class HistoryViewModel: ObservableObject {
    
    @AppStorage("added") var added: Int = 0

    @Published var isAdd: Bool = false
    @Published var isDelete: Bool = false
    @Published var isDetail: Bool = false
    @Published var isSettings: Bool = false
    
    @Published var photos: [String] = ["1", "2", "3"]
    @Published var currentPhoto = ""
    
    @Published var statuses: [String] = ["New", "Used", "For repairs", "Defective"]
    @Published var currentStatus = ""

    @Published var hisName = ""
    @Published var hisDate = ""
    @Published var hisComment = ""

    @Published var notes: [HistoryModel] = []
    @Published var selectedNote: HistoryModel?

    func addNotes() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "HistoryModel", into: context) as! HistoryModel

        loan.hisName = hisName
        loan.hisDate = hisDate
        loan.hisComment = hisComment

        CoreDataStack.shared.saveContext()
    }

    func fetchNotes() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<HistoryModel>(entityName: "HistoryModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.notes = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.notes = []
        }
    }
}
