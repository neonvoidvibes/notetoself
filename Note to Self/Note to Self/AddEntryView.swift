import SwiftUI
import CoreData // Added for JournalEntry

struct AddEntryView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss

    @State private var text: String = ""
    @State private var selectedMood: Mood?

    var body: some View {
        VStack(spacing: 20) {
            TextField("What's on your mind?", text: $text)
                .font(UIStyles.bodyFont)
                .foregroundColor(UIStyles.textColor)
                .padding()
                .background(UIStyles.cardBackgroundColor)
                .cornerRadius(10)
                .submitLabel(.done)
                .focused(true) // Auto-focus for speed

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(Mood.allCases) { mood in
                        Button(action: {
                            selectedMood = mood
                        }) {
                            Text(mood.rawValue)
                                .font(.largeTitle)
                                .padding(8)
                                .background(selectedMood == mood ? UIStyles.accentColor : Color.clear)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.horizontal)
            }

            Button("Save") {
                let newEntry = JournalEntry(context: context)
                newEntry.text = text.isEmpty ? nil : text
                newEntry.mood = selectedMood?.rawValue
                newEntry.timestamp = Date()
                try? context.save()
                dismiss()
            }
            .buttonStyle(UIStyles.PrimaryButtonStyle())
            .disabled(text.isEmpty && selectedMood == nil)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(UIStyles.backgroundColor)
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

// Assuming PersistenceController for previews
