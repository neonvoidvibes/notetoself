// Persistence.swift
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

static let preview: PersistenceController = {
    let controller = PersistenceController(inMemory: true)
    return controller
}()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Note_to_Self")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}