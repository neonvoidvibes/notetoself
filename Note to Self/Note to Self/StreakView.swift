import SwiftUI

struct StreakView: View {
    let entries: [JournalEntry]

    var body: some View {
        let last7Days = getLast7Days()
        HStack(spacing: 8) {
            ForEach(last7Days, id: \.self) { day in
                let hasEntry = entries.contains { Calendar.current.isDate($0.timestamp!, inSameDayAs: day) }
                Circle()
                    .fill(hasEntry ? UIStyles.accentColor : UIStyles.cardBackgroundColor)
                    .frame(width: 10, height: 10)
            }
        }
        .padding()
    }

    private func getLast7Days() -> [Date] {
        let today = Calendar.current.startOfDay(for: Date())
        return (0..<7).map { Calendar.current.date(byAdding: .day, value: -$0, to: today)! }.reversed()
    }
}
