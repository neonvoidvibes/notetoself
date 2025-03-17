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

// TimelineView.swift
import SwiftUI

struct TimelineView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject private var viewModel: TimelineViewModel

    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: TimelineViewModel(context: context))
    }

    var body: some View {
        VStack(spacing: 20) {
            StreakView(entries: viewModel.entries)
            Text("Streak: \(viewModel.streak) days")
                .font(UIStyles.bodyFont)
                .foregroundColor(UIStyles.textColor)

            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(viewModel.entries) { entry in
                        EntryCardView(entry: entry)
                    }
                }
                .padding()
            }
        }
        .background(UIStyles.backgroundColor)
        .onAppear {
            viewModel.fetchEntries()
        }
    }
}

// EntryCardView.swift
import SwiftUI

struct EntryCardView: View {
    let entry: JournalEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(entry.timestamp!, style: .date)
                .font(UIStyles.bodyFont)
                .foregroundColor(UIStyles.textColor.opacity(0.7))
            if let text = entry.text {
                Text(text)
                    .font(UIStyles.bodyFont)
                    .foregroundColor(UIStyles.textColor)
            }
            if let mood = entry.mood {
                Text(mood)
                    .font(.largeTitle)
            }
        }
        .applyCardStyle()
    }
}
