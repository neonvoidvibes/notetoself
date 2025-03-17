import Foundation

enum Mood: String, CaseIterable, Identifiable {
    case happy = "😊"
    case sad = "😢"
    case angry = "😠"
    case excited = "😃"
    case calm = "😌"

    var id: String { rawValue }
}
