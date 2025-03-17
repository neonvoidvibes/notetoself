import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = true

    var body: some View {
        Form {
            Toggle("Dark Mode", isOn: $isDarkMode)
                .font(UIStyles.bodyFont)
                .foregroundColor(UIStyles.textColor)
        }
        .navigationTitle("Settings")
        .background(UIStyles.backgroundColor)
    }
}
