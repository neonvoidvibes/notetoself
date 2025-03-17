import SwiftUI

/// A central location for all UI styling, ensuring a consistent, modern, dark-themed aesthetic
/// with neon accents, large typography, subtle blur, and minimalist design.
struct UIStyles {
    // MARK: - Colors
    /// Primary dark background for the app
    static let backgroundColor = Color("BackgroundColor").opacity(0.95) // Fallback to a near-black
    /// Main text color on dark backgrounds
    static let textColor = Color.white
    /// Neon accent (for Gen Z appeal)
    static let accentColor = Color(red: 0.87, green: 0.05, blue: 0.65) // bright neon pink
    /// Card backgrounds with subtle transparency
    static let cardBackgroundColor = Color.white.opacity(0.06)
    /// Optional thin lines or outlines
    static let thinLineColor = Color.white.opacity(0.15)

    // MARK: - Typography
    /// Large heading font
    static let headingFont = Font.system(size: 32, weight: .bold, design: .default)
    /// Body font
    static let bodyFont = Font.system(size: 20, weight: .regular, design: .rounded)
    /// A smaller subheading or label font
    static let subheadingFont = Font.system(size: 16, weight: .medium, design: .rounded)

    // MARK: - Animations & Transitions
    /// Smooth fade transition
    static let smoothTransition = AnyTransition.opacity.animation(.easeInOut(duration: 0.3))

    // MARK: - Custom Button Style
    struct PrimaryButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(UIStyles.bodyFont)
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(UIStyles.accentColor)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(UIStyles.accentColor, lineWidth: configuration.isPressed ? 2 : 0)
                )
                .shadow(color: UIStyles.accentColor.opacity(0.3), radius: 8, x: 0, y: 4)
                .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
        }
    }

    // MARK: - Card Style
    struct CardViewModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .padding()
                .background(UIStyles.cardBackgroundColor)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(UIStyles.thinLineColor, lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 3)
        }
    }

    // MARK: - Background
    /// Provides a subtle blurred background with a dark tint for a modern look.
    static func defaultBackgroundView() -> some View {
        // Using iOS 15+ .background(.ultraThinMaterial) approach for simplicity:
        // If lower iOS support is needed, add a UIVisualEffectView-based blur manually.
        ZStack {
            Color.black.ignoresSafeArea()
            // Subtle blur layer
            if #available(iOS 15.0, *) {
                Color.black
                    .opacity(0.5)
                    .blur(radius: 20, opaque: false)
                    .ignoresSafeArea()
            }
        }
    }
}

// Convenient card style extension
extension View {
    func applyCardStyle() -> some View {
        self.modifier(UIStyles.CardViewModifier())
    }
}