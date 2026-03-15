import SwiftUI

struct PreSessionView: View {

    let mode: CalmMode

    // ViewModel created here — passed down to SessionView
    @StateObject private var viewModel: SessionViewModel

    // Controls countdown overlay visibility
    @State private var showCountdown: Bool = false
    @State private var countdownDisplay: Int = 3

    // Controls navigation to SessionView
    @State private var navigateToSession: Bool = false

    // For going back
    @Environment(\.dismiss) private var dismiss

    init(mode: CalmMode) {
        self.mode = mode
        _viewModel = StateObject(
            wrappedValue: SessionViewModel(mode: mode)
        )
    }

    var body: some View {
        ZStack {
            // Background
            Color(hex: "#F2F5F0").ignoresSafeArea()

            // Main content
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // MARK: Mode icon
                    ZStack {
                        RoundedRectangle(cornerRadius: 22)
                            .fill(mode.iconBackground)
                            .frame(width: 72, height: 72)

                        Image(systemName: mode.icon)
                            .font(.system(size: 30, weight: .light))
                            .foregroundColor(mode.color)
                    }
                    .padding(.top, 32)
                    .padding(.bottom, 16)

                    // MARK: Mode tag
                    Text(mode.title.uppercased())
                        .font(.system(size: 10, weight: .semibold))
                        .tracking(1.8)
                        .foregroundColor(mode.color)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 6)
                        .background(mode.color.opacity(0.1))
                        .clipShape(Capsule())
                        .padding(.bottom, 18)

                    // MARK: Title
                    Text(modeTitle)
                        .font(.custom("Fraunces-Regular", size: 28))
                        .foregroundColor(Color(hex: "#1E2E23"))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 12)

                    // MARK: Description
                    Text(mode.preSessionDescription)
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(Color(hex: "#7A8F80"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 28)

                    // MARK: Cue preview card
                    VStack(alignment: .leading, spacing: 0) {
                        Text("WHAT YOU'LL HEAR")
                            .font(.system(size: 10, weight: .semibold))
                            .tracking(1.5)
                            .foregroundColor(Color(hex: "#7A8F80"))
                            .padding(.bottom, 12)

                        ForEach(Array(mode.cues.enumerated()), id: \.offset) { index, cue in
                            HStack(spacing: 10) {
                                Circle()
                                    .fill(Color(hex: "#7FB08A"))
                                    .frame(width: 6, height: 6)

                                Text(cue)
                                    .font(.system(size: 13, weight: .light))
                                    .foregroundColor(Color(hex: "#1E2E23"))

                                Spacer()
                            }
                            .padding(.vertical, 7)

                            if index < mode.cues.count - 1 {
                                Divider()
                                    .background(Color(hex: "#DDE8E0"))
                            }
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(hex: "#DDE8E0"), lineWidth: 1.5)
                    )
                    .padding(.horizontal, 24)
                    .padding(.bottom, 28)

                    // MARK: Buttons
                    VStack(spacing: 10) {
                        // Begin
                        Button {
                            beginCountdown()
                        } label: {
                            Text("Begin Session")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color(hex: "#3D6B4F"))
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }

                        // Go back
                        Button {
                            dismiss()
                        } label: {
                            Text("Go Back")
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
                    .padding(.bottom, 32)
                }
            }

            // MARK: Countdown overlay
            if showCountdown {
                ZStack {
                    Color(hex: "#F2F5F0").ignoresSafeArea()

                    VStack(spacing: 12) {
                        Text("\(countdownDisplay)")
                            .font(.custom("Fraunces-Regular", size: 120))
                            .foregroundColor(Color(hex: "#3D6B4F"))
                            .animation(.easeInOut, value: countdownDisplay)

                        Text("Get ready...")
                            .font(.system(size: 14, weight: .light))
                            .tracking(1)
                            .foregroundColor(Color(hex: "#7A8F80"))
                            .textCase(.uppercase)
                    }
                }
                .transition(.opacity)
            }

            // MARK: Navigate to SessionView
            NavigationLink(
                destination: SessionView(viewModel: viewModel),
                isActive: $navigateToSession
            ) {
                EmptyView()
            }
        }
        .navigationBarHidden(true)
    }

    // MARK: - Helpers

    var modeTitle: String {
        switch mode {
        case .breathe:  return "Ready to breathe?"
        case .meditate: return "A moment of stillness."
        case .standUp:  return "Time to move a little."
        }
    }

    func beginCountdown() {
        showCountdown = true
        countdownDisplay = 3

        // Tick down 3 → 2 → 1 then launch session
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { countdownDisplay = 2 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { countdownDisplay = 1 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            viewModel.startCountdown()
            navigateToSession = true
            showCountdown = false
        }
    }
}
