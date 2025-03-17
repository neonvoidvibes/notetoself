import SwiftUI
import CoreData

struct TimelineView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \JournalEntry.timestamp, ascending: false)]
    ) private var entries: FetchedResults<JournalEntry>

    var body: some View {
        VStack(spacing: 20) {
            // Show last 7 days indicator
            StreakView(entries: Array(entries))

            // Compute dynamic streak count
            Text("Streak: \(calculateStreak(in: entries)) days")
                .font(UIStyles.bodyFont)
                .foregroundColor(UIStyles.textColor)

            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(entries) { entry in
                        EntryCardView(entry: entry)
                    }
                }
                .padding()
            }
        }
        .background(UIStyles.defaultBackgroundView())
    }

    private func calculateStreak(in entries: FetchedResults<JournalEntry>) -> Int {
        let sortedEntries = entries.sorted { ($0.timestamp ?? .distantPast) > ($1.timestamp ?? .distantPast) }
        var streakCount = 0
        var currentDate = Calendar.current.startOfDay(for: Date())

        for entry in sortedEntries {
            guard let timestamp = entry.timestamp else { continue }
            let entryDate = Calendar.current.startOfDay(for: timestamp)

            if entryDate == currentDate {
                streakCount += 1
                // Move currentDate back 1 day
                if let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) {
                    currentDate = previousDay
                }
            } else if entryDate < currentDate {
                // Any gap breaks the streak
                break
            }
        }
        return streakCount
    }
}

// Restoring EntryCardView definition here
struct EntryCardView: View {
    let entry: JournalEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let timestamp = entry.timestamp {
                Text(timestamp, style: .date)
                    .font(UIStyles.bodyFont)
                    .foregroundColor(UIStyles.textColor.opacity(0.7))
            }

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