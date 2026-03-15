import SwiftUI

struct SessionView: View {

    @ObservedObject var viewModel: SessionViewModel
    @Environment(\.dismiss) private var dismiss

    // Controls navigation to CompletionView
    @State private var navigateToCompletion: Bool = false

    // Breathing orb animation
    @State private var isExpanded: Bool = false

    var body: some View {
        ZStack {
            // Background
            Color(hex: "#F2F5F0").ignoresSafeArea()

            // Soft radial glow behind orb
            RadialGradient(
                colors: [
                    Color(hex: "#7FB08A").opacity(0.18),
                    Color.clear
                ],
                center: .center,
                startRadius: 0,
                endRadius: 220
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {

                // MARK: Top bar
                HStack {
                    Button { viewModel.endSession(); dismiss() } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(hex: "#1E2E23"))
                            .frame(width: 38, height: 38)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: 2)
                    }

                    Spacer()

                    Text(viewModel.mode.title.uppercased())
                        .font(.system(size: 11, weight: .semibold))
                        .tracking(1.4)
                        .foregroundColor(Color(hex: "#3D6B4F"))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 6)
                        .background(Color(hex: "#3D6B4F").opacity(0.1))
                        .clipShape(Capsule())

                    Spacer()

                    Button { viewModel.endSession(); dismiss() } label: {
                        Text("End")
                            .font(.system(size: 13))
                            .foregroundColor(Color(hex: "#7A8F80"))
                    }
                    .frame(width: 38)
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)

                Spacer()

                // MARK: Timer
                VStack(spacing: 4) {
                    Text(viewModel.timerString)
                        .font(.custom("Fraunces-Regular", size: 68))
                        .foregroundColor(Color(hex: "#1E2E23"))
                        .monospacedDigit()
                        .animation(nil, value: viewModel.timerString)

                    Text("remaining")
                        .font(.system(size: 11, weight: .light))
                        .tracking(1)
                        .textCase(.uppercase)
                        .foregroundColor(Color(hex: "#7A8F80"))
                }
                .padding(.bottom, 32)

                // MARK: Breathing orb
                ZStack {
                    // Outer ring
                    Circle()
                        .fill(Color(hex: "#7FB08A").opacity(0.12))
                        .frame(width: 176, height: 176)
                        .scaleEffect(isExpanded ? 1.08 : 0.88)

                    // Mid ring
                    Circle()
                        .fill(Color(hex: "#7FB08A").opacity(0.18))
                        .frame(width: 136, height: 136)
                        .scaleEffect(isExpanded ? 1.1 : 0.9)

                    // Core
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: "#B2D8BC"), Color(hex: "#6DAA7A")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 96, height: 96)
                        .scaleEffect(isExpanded ? 1.12 : 0.88)
                        .shadow(
                            color: Color(hex: "#3D6B4F").opacity(0.28),
                            radius: 20, x: 0, y: 8
                        )
                        .overlay(
                            Image(systemName: viewModel.mode.icon)
                                .font(.system(size: 30, weight: .light))
                                .foregroundColor(.white)
                        )
                }
                .animation(
                    .easeInOut(duration: 2.5).repeatForever(autoreverses: true),
                    value: isExpanded
                )
                .padding(.bottom, 32)

                // MARK: Cue text
                Text(viewModel.currentCue)
                    .font(.custom("Fraunces-Regular", size: 22))
                    .foregroundColor(Color(hex: "#1E2E23"))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                    .frame(minHeight: 66)
                    .padding(.horizontal, 32)
                    .animation(.easeInOut(duration: 0.5), value: viewModel.currentCue)

                Spacer()

                // MARK: Progress bar
                VStack(spacing: 7) {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color(hex: "#C8DDD0"))
                                .frame(height: 3)

                            RoundedRectangle(cornerRadius: 4)
                                .fill(
                                    LinearGradient(
                                        colors: [Color(hex: "#7FB08A"), Color(hex: "#3D6B4F")],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .frame(
                                    width: geo.size.width * viewModel.progress,
                                    height: 3
                                )
                                .animation(.linear(duration: 1), value: viewModel.progress)
                        }
                    }
                    .frame(height: 3)

                    HStack {
                        Text("0:00")
                        Spacer()
                        Text("2:00")
                    }
                    .font(.system(size: 11))
                    .foregroundColor(Color(hex: "#7A8F80"))
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 36)
            }

            // MARK: Navigate to completion
            NavigationLink(
                destination: CompletionView(),
                isActive: $navigateToCompletion
            ) {
                EmptyView()
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            // Start orb animation
            isExpanded = true
        }
        .onChange(of: viewModel.sessionState) { state in
            if state == .complete {
                navigateToCompletion = true
            }
        }
    }
}
