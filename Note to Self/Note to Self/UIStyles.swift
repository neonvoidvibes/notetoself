import SwiftUI

struct UIStyles {
    // Colors
    static let backgroundColor = Color.black
    static let textColor = Color.white
    static let accentColor = Color.blue // Neon accent for Gen Z appeal
    static let cardBackgroundColor = Color.gray.opacity(0.2)

    // Typography
    static let headingFont = Font.system(size: 28, weight: .bold, design: .default)
    static let bodyFont = Font.system(size: 18, weight: .regular, design: .default)

    // Button Style
    struct PrimaryButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(UIStyles.bodyFont)
                .padding()
                .background(UIStyles.accentColor)
                .foregroundColor(.white)
                .cornerRadius(10)
                .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        }
    }

    // Card Style
    struct CardViewModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding()
                .background(UIStyles.cardBackgroundColor)
                .cornerRadius(15)
                .shadow(radius: 5)
        }
    }

    // Animations
    static let smoothTransition = AnyTransition.opacity.animation(.easeInOut(duration: 0.3))
}

// Extension for convenience
extension View {
    func applyCardStyle() -> some View {
        self.modifier(UIStyles.CardViewModifier())
    }
}
