import SwiftUI

struct CompletionView: View {

    // Streak persistence
    @AppStorage("streak_count") private var streakCount: Int = 0
    @AppStorage("last_completion_date") private var lastCompletionDate: String = ""

    // Animation states
    @State private var checkVisible: Bool = false
    @State private var contentVisible: Bool = false

    // Navigation back to root
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // Background
            Color(hex: "#F2F5F0").ignoresSafeArea()

            // Soft bottom glow
            VStack {
                Spacer()
                RadialGradient(
                    colors: [
                        Color(hex: "#7FB08A").opacity(0.12),
                        Color.clear
                    ],
                    center: .center,
                    startRadius: 0,
                    endRadius: 280
                )
                .frame(height: 400)
            }
            .ignoresSafeArea()

            VStack(spacing: 0) {

                Spacer()

                // MARK: Check ring
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: "#A8D4B4"), Color(hex: "#3D6B4F")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 84, height: 84)
                        .shadow(
                            color: Color(hex: "#3D6B4F").opacity(0.3),
                            radius: 20, x: 0, y: 10
                        )

                    Image(systemName: "checkmark")
                        .font(.system(size: 34, weight: .medium))
                        .foregroundColor(.white)
                }
                .scaleEffect(checkVisible ? 1 : 0)
                .animation(
                    .spring(response: 0.5, dampingFraction: 0.6),
                    value: checkVisible
                )
                .padding(.bottom, 24)

                // MARK: Title + subtitle
                VStack(spacing: 8) {
                    Text("You did it.")
                        .font(.custom("Fraunces-Regular", size: 34))
                        .foregroundColor(Color(hex: "#1E2E23"))

                    Text("Two minutes, all yours.\nThat's what calm looks like.")
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(Color(hex: "#7A8F80"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                .padding(.bottom, 28)
                .opacity(contentVisible ? 1 : 0)
                .animation(.easeIn(duration: 0.4).delay(0.3), value: contentVisible)

                // MARK: Streak card
                VStack(alignment: .leading, spacing: 4) {
                    Text("CURRENT STREAK")
                        .font(.system(size: 10, weight: .semibold))
                        .tracking(1.5)
                        .foregroundColor(Color(hex: "#7A8F80"))

                    Text("\(streakCount)")
                        .font(.custom("Fraunces-Regular", size: 52))
                        .foregroundColor(Color(hex: "#3D6B4F"))
                        .monospacedDigit()

                    Text("days in a row")
                        .font(.system(size: 12, weight: .light))
                        .foregroundColor(Color(hex: "#7A8F80"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(22)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(hex: "#DDE8E0"), lineWidth: 1.5)
                )
                .shadow(color: Color(hex: "#3D6B4F").opacity(0.07), radius: 12, x: 0, y: 4)
                .padding(.horizontal, 24)
                .opacity(contentVisible ? 1 : 0)
                .animation(.easeIn(duration: 0.4).delay(0.5), value: contentVisible)

                Spacer()

                // MARK: Buttons
                VStack(spacing: 10) {

                    // Back to home
                    Button {
                        // Pop all the way back to root
                        dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            dismiss()
                        }
                    } label: {
                        Text("Back to Home")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(hex: "#3D6B4F"))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }

                    // Share
                    ShareLink(item: shareMessage) {
                        Text("Share this moment")
                            .font(.system(size: 14))
                            .foregroundColor(Color(hex: "#7A8F80"))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color(hex: "#DDE8E0"), lineWidth: 1.5)
                            )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
                .opacity(contentVisible ? 1 : 0)
                .animation(.easeIn(duration: 0.4).delay(0.7), value: contentVisible)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            updateStreak()
            // Staggered animations
            withAnimation { checkVisible = true }
            contentVisible = true
        }
    }

    // MARK: - Streak Logic
    private func updateStreak() {
        let today = todayString()

        if lastCompletionDate == today {
            // Already completed today — don't increment
            return
        }

        let yesterday = yesterdayString()

        if lastCompletionDate == yesterday {
            // Consecutive day — increment streak
            streakCount += 1
        } else {
            // Streak broken or first time — reset to 1
            streakCount = 1
        }

        lastCompletionDate = today
    }

    private func todayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }

    private func yesterdayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        return formatter.string(from: yesterday)
    }

    // MARK: - Share message
    private var shareMessage: String {
        "Just completed my \(streakCount)-day streak on 2 Minute Calm. Two minutes a day of breathing, meditation or movement. Try it."
    }
}
