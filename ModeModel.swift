import SwiftUI

// MARK: - CalmMode
enum CalmMode: String, CaseIterable, Identifiable {
    case breathe  = "Breathe"
    case meditate = "Meditate"
    case standUp  = "Stand Up"

    var id: String { self.rawValue }

    var title: String { self.rawValue }

    // SF Symbols — closest match to our custom SVG icons
    var icon: String {
        switch self {
        case .breathe:  return "wind"
        case .meditate: return "circle.circle"
        case .standUp:  return "figure.stand"
        }
    }

    // Forest Stillness palette — mode accent colors
    var color: Color {
        switch self {
        case .breathe:  return Color(hex: "#3D6B4F") // Primary green
        case .meditate: return Color(hex: "#4A7FA5") // Calm blue
        case .standUp:  return Color(hex: "#B07D62") // Warm terracotta
        }
    }

    // Soft background per mode card icon
    var iconBackground: Color {
        switch self {
        case .breathe:  return Color(hex: "#E4F0E8")
        case .meditate: return Color(hex: "#E3EDF5")
        case .standUp:  return Color(hex: "#F5EDE3")
        }
    }

    // Cue texts shown during session
    var cues: [String] {
        switch self {
        case .breathe:
            return [
                "Breathe in slowly...",
                "Hold gently...",
                "Breathe out fully...",
                "Feel the calm.",
                "Breathe in again...",
                "Let it go...",
                "You are here.",
                "Notice the stillness."
            ]
        case .meditate:
            return [
                "Close your eyes.",
                "Notice your breath.",
                "Let thoughts pass like clouds.",
                "You are here, and that is enough.",
                "Soften your body.",
                "Rest in the stillness.",
                "You are calm.",
                "Breathe and be."
            ]
        case .standUp:
            return [
                "Stand up slowly.",
                "Roll your shoulders back.",
                "Stretch both arms overhead.",
                "Take one slow, full breath.",
                "Gently roll your neck.",
                "Shake out your hands.",
                "Plant both feet firmly.",
                "Well done. Sit back down."
            ]
        }
    }

    // Cue interval in seconds — meditate uses longer gap
    var cueInterval: Double {
        switch self {
        case .breathe:  return 4.0
        case .meditate: return 15.0
        case .standUp:  return 4.0
        }
    }

    // Pre-session description shown before starting
    var preSessionDescription: String {
        switch self {
        case .breathe:
            return "You'll be guided through a gentle breathing cycle. Read the cues below, then begin when you're ready."
        case .meditate:
            return "This session uses long, spaced prompts — no need to keep looking at the screen. Read them now, then close your eyes and let them guide you."
        case .standUp:
            return "Short movement prompts will guide you through a gentle body reset. No equipment needed — just a little space."
        }
    }
}

// MARK: - Color Hex Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8)  & 0xFF) / 255
        let b = Double(int         & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}