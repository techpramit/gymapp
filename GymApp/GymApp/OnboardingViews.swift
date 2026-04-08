import SwiftUI

// MARK: - Welcome View

struct WelcomeView: View {
    let onGetStarted: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(red: 0.05, green: 0.05, blue: 0.15), Color(red: 0.1, green: 0.2, blue: 0.4)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()

                // Logo / icon
                ZStack {
                    Circle()
                        .fill(Color.orange.opacity(0.2))
                        .frame(width: 140, height: 140)
                    Image(systemName: "figure.strengthtraining.traditional")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.orange)
                }

                VStack(spacing: 12) {
                    Text("GymApp")
                        .font(.system(size: 44, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)

                    Text("Your Personal Fitness Coach")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                }

                VStack(spacing: 16) {
                    FeatureBadge(icon: "dumbbell.fill",  text: "Custom Workout Routines")
                    FeatureBadge(icon: "fork.knife",     text: "Personalised Diet Plans")
                    FeatureBadge(icon: "chart.bar.fill", text: "Goal-Based Programming")
                }

                Spacer()

                Button(action: onGetStarted) {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 40)
            }
        }
    }
}

private struct FeatureBadge: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .foregroundColor(.orange)
                .frame(width: 28)
            Text(text)
                .foregroundColor(.white.opacity(0.85))
            Spacer()
        }
        .padding(.horizontal, 48)
    }
}

// MARK: - Onboarding Container

struct OnboardingContainerView: View {
    @EnvironmentObject var userProfile: UserProfile
    let onComplete: () -> Void
    let onBack: () -> Void

    @State private var step: Int = 0
    private let totalSteps = 4

    var body: some View {
        ZStack {
            Color(red: 0.07, green: 0.07, blue: 0.12)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        if step == 0 { onBack() } else { withAnimation { step -= 1 } }
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("Step \(step + 1) of \(totalSteps)")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)

                // Progress bar
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.white.opacity(0.15))
                            .frame(height: 6)
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.orange)
                            .frame(width: geo.size.width * CGFloat(step + 1) / CGFloat(totalSteps), height: 6)
                            .animation(.spring(), value: step)
                    }
                }
                .frame(height: 6)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)

                // Step content
                Group {
                    switch step {
                    case 0: UserNameAgeView(onNext: { withAnimation { step = 1 } })
                    case 1: GoalSelectionView(onNext: { withAnimation { step = 2 } })
                    case 2: TrainingTypeView(onNext: { withAnimation { step = 3 } })
                    case 3: MusclePreferenceView(onNext: { onComplete() })
                    default: EmptyView()
                    }
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing),
                    removal: .move(edge: .leading)
                ))
            }
        }
    }
}

// MARK: - Step 1: Name & Age

struct UserNameAgeView: View {
    @EnvironmentObject var userProfile: UserProfile
    let onNext: () -> Void

    @State private var showValidation = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                StepHeader(
                    title: "Tell Us About You",
                    subtitle: "We'll use this to personalise your plan."
                )

                // Name
                VStack(alignment: .leading, spacing: 8) {
                    Label("Your Name", systemImage: "person.fill")
                        .font(.subheadline.bold())
                        .foregroundColor(.white.opacity(0.8))

                    TextField("e.g. Alex", text: $userProfile.name)
                        .textFieldStyle(.plain)
                        .padding()
                        .background(Color.white.opacity(0.08))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .overlay(
                            showValidation && userProfile.name.trimmingCharacters(in: .whitespaces).isEmpty
                                ? RoundedRectangle(cornerRadius: 12).stroke(Color.red, lineWidth: 1)
                                : nil
                        )
                }

                // Age
                VStack(alignment: .leading, spacing: 8) {
                    Label("Age", systemImage: "calendar")
                        .font(.subheadline.bold())
                        .foregroundColor(.white.opacity(0.8))

                    HStack {
                        Text("\(userProfile.age) yrs")
                            .font(.title2.bold())
                            .foregroundColor(.orange)
                            .frame(width: 80)

                        Slider(value: Binding(
                            get: { Double(userProfile.age) },
                            set: { userProfile.age = Int($0) }
                        ), in: 14...80, step: 1)
                        .accentColor(.orange)
                    }
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .cornerRadius(12)
                }

                // Weight
                VStack(alignment: .leading, spacing: 8) {
                    Label("Weight", systemImage: "scalemass.fill")
                        .font(.subheadline.bold())
                        .foregroundColor(.white.opacity(0.8))

                    HStack {
                        Text(String(format: "%.0f kg", userProfile.weightKg))
                            .font(.title2.bold())
                            .foregroundColor(.orange)
                            .frame(width: 80)

                        Slider(value: $userProfile.weightKg, in: 30...200, step: 1)
                            .accentColor(.orange)
                    }
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .cornerRadius(12)
                }

                // Height
                VStack(alignment: .leading, spacing: 8) {
                    Label("Height", systemImage: "ruler.fill")
                        .font(.subheadline.bold())
                        .foregroundColor(.white.opacity(0.8))

                    HStack {
                        Text(String(format: "%.0f cm", userProfile.heightCm))
                            .font(.title2.bold())
                            .foregroundColor(.orange)
                            .frame(width: 80)

                        Slider(value: $userProfile.heightCm, in: 100...220, step: 1)
                            .accentColor(.orange)
                    }
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .cornerRadius(12)
                }

                NextButton(title: "Next") {
                    showValidation = true
                    if userProfile.isProfileComplete {
                        onNext()
                    }
                }
            }
            .padding(24)
        }
    }
}

// MARK: - Step 2: Fitness Goal

struct GoalSelectionView: View {
    @EnvironmentObject var userProfile: UserProfile
    let onNext: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                StepHeader(
                    title: "What's Your Goal?",
                    subtitle: "Choose what you'd like to achieve."
                )

                ForEach(FitnessGoal.allCases) { goal in
                    SelectionCard(
                        emoji: goal.emoji,
                        title: goal.rawValue,
                        description: goal.description,
                        isSelected: userProfile.goal == goal
                    ) {
                        userProfile.goal = goal
                    }
                }

                NextButton(title: "Next", action: onNext)
            }
            .padding(24)
        }
    }
}

// MARK: - Step 3: Training Level

struct TrainingTypeView: View {
    @EnvironmentObject var userProfile: UserProfile
    let onNext: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                StepHeader(
                    title: "Training Experience",
                    subtitle: "Be honest — the right level gives the best results."
                )

                ForEach(TrainingLevel.allCases) { level in
                    SelectionCard(
                        emoji: level.emoji,
                        title: level.rawValue,
                        description: level.description,
                        isSelected: userProfile.trainingLevel == level
                    ) {
                        userProfile.trainingLevel = level
                    }
                }

                NextButton(title: "Next", action: onNext)
            }
            .padding(24)
        }
    }
}

// MARK: - Step 4: Muscle Training Preference

struct MusclePreferenceView: View {
    @EnvironmentObject var userProfile: UserProfile
    let onNext: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                StepHeader(
                    title: "Daily Training Style",
                    subtitle: "How many muscle groups do you want to train per session?"
                )

                ForEach(MuscleTrainingPreference.allCases) { preference in
                    SelectionCard(
                        emoji: preference.emoji,
                        title: preference.rawValue,
                        description: preference.description,
                        isSelected: userProfile.musclePreference == preference
                    ) {
                        userProfile.musclePreference = preference
                    }
                }

                NextButton(title: "Build My Plan 🚀", action: onNext)
            }
            .padding(24)
        }
    }
}

// MARK: - Shared Components

struct StepHeader: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.largeTitle.bold())
                .foregroundColor(.white)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.6))
        }
        .padding(.top, 8)
    }
}

struct SelectionCard: View {
    let emoji: String
    let title: String
    let description: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .top, spacing: 16) {
                Text(emoji)
                    .font(.largeTitle)
                    .frame(width: 44, height: 44)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.65))
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? .orange : .white.opacity(0.3))
                    .font(.title3)
            }
            .padding(16)
            .background(isSelected ? Color.orange.opacity(0.18) : Color.white.opacity(0.07))
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color.orange : Color.clear, lineWidth: 1.5)
            )
        }
    }
}

struct NextButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .cornerRadius(16)
        }
        .padding(.top, 8)
        .padding(.bottom, 24)
    }
}

// MARK: - Previews

#Preview("Welcome") {
    WelcomeView(onGetStarted: {})
}

#Preview("Onboarding") {
    OnboardingContainerView(onComplete: {}, onBack: {})
        .environmentObject(UserProfile())
}
