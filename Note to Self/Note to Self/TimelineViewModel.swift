import CoreData

class TimelineViewModel: ObservableObject {
    @Published var entries: [JournalEntry] = []
    @Published var streak: Int = 0

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchEntries()
    }

    func fetchEntries() {
        let request: NSFetchRequest<JournalEntry> = JournalEntry.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \JournalEntry.timestamp, ascending: false)]
        do {
            entries = try context.fetch(request)
            calculateStreak()
        } catch {
            print("Error fetching entries: \(error)")
        }
    }

    private func calculateStreak() {
        let sortedEntries = entries.sorted { $0.timestamp! > $1.timestamp! }
        var streakCount = 0
        var currentDate = Calendar.current.startOfDay(for: Date())

        for entry in sortedEntries {
            let entryDate = Calendar.current.startOfDay(for: entry.timestamp!)
            if entryDate == currentDate {
                streakCount += 1
                if let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) {
                    currentDate = previousDay
                }
            } else if entryDate < currentDate {
                break
            }
        }
        streak = streakCount
    }
}



