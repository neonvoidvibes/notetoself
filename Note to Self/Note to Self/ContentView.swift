import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @AppStorage("isDarkMode") var isDarkMode: Bool = true

    var body: some View {
        Group {
            if hasSeenOnboarding {
                MainView()
            } else {
                OnboardingView(hasSeenOnboarding: $hasSeenOnboarding)
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .background(UIStyles.defaultBackgroundView())
    }
}