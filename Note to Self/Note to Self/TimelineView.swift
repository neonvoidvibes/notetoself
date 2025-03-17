import SwiftUI
import CoreData // Added for JournalEntry

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
        .background(UIStyles.defaultBackgroundView())
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