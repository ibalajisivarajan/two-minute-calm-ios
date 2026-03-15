import SwiftUI
import Combine

// MARK: - Session State
enum SessionState {
    case idle
    case countdown
    case running
    case complete
}

// MARK: - SessionViewModel
class SessionViewModel: ObservableObject {

    // MARK: Published — SessionView reads these
    @Published var sessionState: SessionState = .idle
    @Published var secondsRemaining: Int = 120
    @Published var countdownNumber: Int = 3
    @Published var currentCue: String = ""
    @Published var progress: Double = 0.0

    // MARK: Private
    private var mode: CalmMode
    private var timer: AnyCancellable?
    private var cueIndex: Int = 0

    // MARK: Init
    init(mode: CalmMode) {
        self.mode = mode
        self.currentCue = mode.cues[0]
    }

    // MARK: - Start Countdown (3 seconds)
    func startCountdown() {
        sessionState = .countdown
        countdownNumber = 3

        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.countdownNumber > 1 {
                    self.countdownNumber -= 1
                } else {
                    self.timer?.cancel()
                    self.beginSession()
                }
            }
    }

    // MARK: - Begin Session (2 minutes)
    private func beginSession() {
        sessionState = .running
        secondsRemaining = 120
        cueIndex = 0
        currentCue = mode.cues[0]
        progress = 0.0

        var cueTimer: Double = 0

        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }

                if self.secondsRemaining > 0 {
                    self.secondsRemaining -= 1
                    self.progress = Double(120 - self.secondsRemaining) / 120.0

                    // Cycle cue text based on mode interval
                    cueTimer += 1
                    if cueTimer >= self.mode.cueInterval {
                        cueTimer = 0
                        self.cueIndex = (self.cueIndex + 1) % self.mode.cues.count
                        self.currentCue = self.mode.cues[self.cueIndex]
                    }
                } else {
                    self.timer?.cancel()
                    self.sessionState = .complete
                }
            }
    }

    // MARK: - End Session early
    func endSession() {
        timer?.cancel()
        sessionState = .idle
        secondsRemaining = 120
        progress = 0.0
        cueIndex = 0
        currentCue = mode.cues[0]
    }

    // MARK: - Formatted timer string
    var timerString: String {
        let m = secondsRemaining / 60
        let s = secondsRemaining % 60
        return String(format: "%d:%02d", m, s)
    }
}
