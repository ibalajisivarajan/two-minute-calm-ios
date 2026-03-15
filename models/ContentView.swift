import SwiftUI

// MARK: - App Entry Navigation
struct ContentView: View {
    @AppStorage("streak_count") private var streakCount: Int = 0

    var body: some View {
        NavigationStack {
            ZStack {
                // Background — Forest Stillness
                Color(hex: "#F2F5F0").ignoresSafeArea()

                VStack(spacing: 0) {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {

                            // MARK: Hero
                            HeroSection()

                            // MARK: Streak
                            StreakPill(count: streakCount)
                                .padding(.bottom, 28)

                            // MARK: Section label
                            HStack {
                                Text("CHOOSE YOUR RESET")
                                    .font(.system(size: 10, weight: .semibold))
                                    .tracking(1.8)
                                    .foregroundColor(Color(hex: "#7A8F80"))
                                Spacer()
                            }
                            .padding(.horizontal, 24)
                            .padding(.bottom, 11)

                            // MARK: Mode cards
                            VStack(spacing: 10) {
                                ForEach(CalmMode.allCases) { mode in
                                    NavigationLink(
                                        destination: PreSessionView(mode: mode)
                                    ) {
                                        ModeCard(mode: mode)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 24)

                            // MARK: Notification link
                            NotificationLink()
                                .padding(.top, 8)
                        }
                        .padding(.bottom, 32)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Hero Section
struct HeroSection: View {
    var body: some View {
        VStack(spacing: 14) {
            // App logo icon
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(
                        LinearGradient(
                            colors: [Color(hex: "#C8DDD0"), Color(hex: "#7FB08A")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 56, height: 56)
                    .shadow(color: Color(hex: "#3D6B4F").opacity(0.2), radius: 12, x: 0, y: 6)

                Image(systemName: "leaf")
                    .font(.system(size: 24, weight: .light))
                    .foregroundColor(.white)
            }

            VStack(spacing: 5) {
                Text("2 Minute\nCalm")
                    .font(.custom("Fraunces-Regular", size: 36))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(hex: "#1E2E23"))
                    .lineSpacing(2)

                Text("Your daily reset.")
                    .font(.system(size: 14, weight: .light))
                    .foregroundColor(Color(hex: "#7A8F80"))
            }
        }
        .padding(.top, 24)
        .padding(.bottom, 20)
    }
}

// MARK: - Streak Pill
struct StreakPill: View {
    let count: Int
    var body: some View {
        HStack(spacing: 7) {
            Image(systemName: "flame")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(hex: "#E07A5F"))
            Text("\(count) day streak")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(hex: "#7A8F80"))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white)
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color(hex: "#DDE8E0"), lineWidth: 1.5)
        )
        .shadow(color: Color(hex: "#3D6B4F").opacity(0.07), radius: 8, x: 0, y: 2)
    }
}

// MARK: - Mode Card
struct ModeCard: View {
    let mode: CalmMode

    var body: some View {
        HStack(spacing: 15) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(mode.iconBackground)
                    .frame(width: 50, height: 50)

                Image(systemName: mode.icon)
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(mode.color)
            }

            // Text
            VStack(alignment: .leading, spacing: 3) {
                Text(mode.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "#1E2E23"))

                Text("2 minute session")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(Color(hex: "#7A8F80"))
            }

            Spacer()

            // Chevron
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(hex: "#C8DDD0"))
        }
        .padding(17)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.clear, lineWidth: 1.5)
        )
        .shadow(color: Color(hex: "#3D6B4F").opacity(0.06), radius: 12, x: 0, y: 2)
    }
}

// MARK: - Notification Link
struct NotificationLink: View {
    var body: some View {
        HStack(spacing: 7) {
            Image(systemName: "bell")
                .font(.system(size: 13, weight: .light))
                .foregroundColor(Color(hex: "#7A8F80"))
            Text("Preview daily notification")
                .font(.system(size: 12))
                .foregroundColor(Color(hex: "#7A8F80"))
        }
        .padding(10)
    }
}
