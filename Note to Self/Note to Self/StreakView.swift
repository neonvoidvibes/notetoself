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
                    .frame(width: 14, height: 14)
                    .shadow(color: UIStyles.accentColor.opacity(hasEntry ? 0.4 : 0.0), radius: 4, x: 0, y: 2)
            }
        }
        .padding()
    }

    private func getLast7Days() -> [Date] {
        let today = Calendar.current.startOfDay(for: Date())
        return (0..<7).map { Calendar.current.date(byAdding: .day, value: -$0, to: today)! }.reversed()
    }
}