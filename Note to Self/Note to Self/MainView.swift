import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var context
    @State private var showingAddEntry = false

    var body: some View {
        NavigationStack {
            TimelineView(context: context)
                .navigationTitle("Note to Self")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(UIStyles.accentColor)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                                .foregroundColor(UIStyles.accentColor)
                        }
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    Button(action: {
                        showingAddEntry = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background(UIStyles.accentColor)
                            .clipShape(Circle())
                    }
                    .padding()
                }
                .sheet(isPresented: $showingAddEntry) {
                    AddEntryView()
                        .environment(\.managedObjectContext, context)
                }
        }
        .accentColor(UIStyles.accentColor)
        .background(UIStyles.defaultBackgroundView())
    }
}