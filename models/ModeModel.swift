import SwiftUI

// MARK: - CalmMode Enum
enum CalmMode: String, CaseIterable, Identifiable {
    case breathe   = "Breathe"
    case meditate  = "Meditate"
    case standUp   = "Stand Up"

    var id: String { self.rawValue }

    // Display title
    var title: String { self.rawValue }

    // SF Symbol icon name
    var icon: String {
        switch self {
        case .breathe:  return "wind"
        case .meditate: return "figure.mind.and.body"
        case .standUp:  return "figure.stand"
        }
    }

    // Accent color per mode
    var color: Color {
        switch self {
        case .breathe:  return Color(red: 0.66, green: 0.84, blue: 0.71) // Soft green
        case .meditate: return Color(red: 0.72, green: 0.82, blue: 0.90) // Calm blue
        case .standUp:  return Color(red: 0.98, green: 0.85, blue: 0.70) // Warm peach
        }
    }

    // Cue texts shown during the 2-min session
    var cues: [String] {
        switch self {
        case .breathe:
            return [
                "Breathe in slowly...",
                "Hold gently...",
                "Breathe out fully...",
                "You're doing great.",
                "Breathe in...",
                "Hold...",
                "Let it go...",
                "Feel the calm."
            ]
        case .meditate:
            return [
                "Close your eyes.",
                "Notice your breath.",
                "Let thoughts pass by.",
                "You are here. That's enough.",
                "Soften your face.",
                "Relax your shoulders.",
                "Be still for a moment.",
                "You are calm."
            ]
        case .standUp:
            return [
                "Stand up slowly.",
                "Roll your shoulders back.",
                "Stretch your arms up high.",
                "Take a deep breath.",
                "Shake out your hands.",
                "Roll your neck gently.",
                "Plant your feet firmly.",
                "You've got this."
            ]
        }
    }
}
