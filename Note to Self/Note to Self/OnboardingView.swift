import SwiftUI

struct OnboardingView: View {
    @Binding var hasSeenOnboarding: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Note to Self")
                .font(UIStyles.headingFont)
                .foregroundColor(UIStyles.textColor)
            Text("Capture your day in under 30 seconds")
                .font(UIStyles.bodyFont)
                .foregroundColor(UIStyles.textColor.opacity(0.7))
            Button("Get Started") {
                hasSeenOnboarding = true
            }
            .buttonStyle(UIStyles.PrimaryButtonStyle())
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(UIStyles.defaultBackgroundView())
    }
}