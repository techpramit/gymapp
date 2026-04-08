import SwiftUI

// MARK: - Results Tab View

struct ResultsTabView: View {
    @EnvironmentObject var userProfile: UserProfile
    let onRestart: () -> Void

    @State private var workoutPlan: WeeklyWorkoutPlan?
    @State private var dietPlan: DietPlan?

    var body: some View {
        ZStack {
            Color(red: 0.07, green: 0.07, blue: 0.12)
                .ignoresSafeArea()

            if let workout = workoutPlan, let diet = dietPlan {
                TabView {
                    RoutineView(plan: workout, onRestart: onRestart)
                        .tabItem {
                            Label("Routine", systemImage: "dumbbell.fill")
                        }

                    DietPlanView(plan: diet, onRestart: onRestart)
                        .tabItem {
                            Label("Diet Plan", systemImage: "fork.knife")
                        }
                }
                .accentColor(.orange)
            } else {
                ProgressView("Building your plan…")
                    .foregroundColor(.white)
                    .tint(.orange)
            }
        }
        .onAppear {
            workoutPlan = RoutineGenerator.generate(for: userProfile)
            dietPlan    = DietPlanGenerator.generate(for: userProfile)
        }
    }
}

// MARK: - Routine View

struct RoutineView: View {
    let plan: WeeklyWorkoutPlan
    let onRestart: () -> Void

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.07, green: 0.07, blue: 0.12)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Plan summary card
                        PlanSummaryCard(
                            icon: "dumbbell.fill",
                            title: plan.planName,
                            tags: [plan.goal.rawValue, plan.level.rawValue, plan.musclePreference.rawValue]
                        )
                        .padding(.horizontal, 16)

                        // Day cards
                        ForEach(plan.days) { day in
                            WorkoutDayCard(day: day)
                                .padding(.horizontal, 16)
                        }

                        RestartButton(action: onRestart)
                    }
                    .padding(.vertical, 16)
                }
            }
            .navigationTitle("My Routine")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Workout Day Card

struct WorkoutDayCard: View {
    let day: WorkoutDay
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            Button(action: { withAnimation(.spring()) { isExpanded.toggle() } }) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(day.dayName)
                            .font(.headline)
                            .foregroundColor(.white)

                        if day.isRestDay {
                            Text("Rest Day 😴")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        } else {
                            Text(day.muscleGroups.map { $0.rawValue }.joined(separator: " · "))
                                .font(.caption)
                                .foregroundColor(.orange)
                                .lineLimit(1)
                        }
                    }

                    Spacer()

                    if !day.isRestDay {
                        Text("\(day.exercises.count) exercises")
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.5))

                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.white.opacity(0.4))
                            .padding(.leading, 4)
                    }
                }
                .padding(16)
                .background(day.isRestDay ? Color.white.opacity(0.04) : Color.white.opacity(0.08))
                .cornerRadius(isExpanded ? 0 : 16)
                .cornerRadius(16, corners: [.topLeft, .topRight])
            }
            .buttonStyle(.plain)

            // Expandable exercise list
            if isExpanded && !day.isRestDay {
                VStack(spacing: 0) {
                    Divider().background(Color.white.opacity(0.1))

                    ForEach(day.exercises) { exercise in
                        ExerciseRow(exercise: exercise)
                        if exercise.id != day.exercises.last?.id {
                            Divider().background(Color.white.opacity(0.07)).padding(.leading, 16)
                        }
                    }
                }
                .background(Color.white.opacity(0.06))
                .cornerRadius(16, corners: [.bottomLeft, .bottomRight])
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}

// MARK: - Exercise Row

struct ExerciseRow: View {
    let exercise: Exercise
    @State private var showDetails = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: { withAnimation { showDetails.toggle() } }) {
                HStack(spacing: 12) {
                    Text(exercise.muscleGroup.emoji)
                        .frame(width: 32, height: 32)
                        .background(Color.orange.opacity(0.15))
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 2) {
                        Text(exercise.name)
                            .font(.subheadline.bold())
                            .foregroundColor(.white)
                        HStack(spacing: 8) {
                            PillTag(text: "\(exercise.sets) sets")
                            PillTag(text: "\(exercise.reps) reps")
                            PillTag(text: "\(exercise.restSeconds)s rest")
                        }
                    }

                    Spacer()

                    Image(systemName: showDetails ? "chevron.up" : "info.circle")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.4))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .buttonStyle(.plain)

            if showDetails {
                Text(exercise.instructions)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.65))
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
                    .transition(.opacity)
            }
        }
    }
}

// MARK: - Diet Plan View

struct DietPlanView: View {
    let plan: DietPlan
    let onRestart: () -> Void

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.07, green: 0.07, blue: 0.12)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // Plan summary card
                        PlanSummaryCard(
                            icon: "fork.knife",
                            title: plan.planName,
                            tags: ["\(plan.dailyCalories) kcal/day", plan.goal.rawValue]
                        )
                        .padding(.horizontal, 16)

                        // Macro overview
                        MacroCard(plan: plan)
                            .padding(.horizontal, 16)

                        // Meals
                        ForEach(plan.meals) { meal in
                            MealCard(meal: meal)
                                .padding(.horizontal, 16)
                        }

                        // Hydration
                        HydrationCard(litres: plan.hydrationLitres)
                            .padding(.horizontal, 16)

                        // Tips
                        TipsCard(tips: plan.tips)
                            .padding(.horizontal, 16)

                        RestartButton(action: onRestart)
                    }
                    .padding(.vertical, 16)
                }
            }
            .navigationTitle("My Diet Plan")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Macro Card

struct MacroCard: View {
    let plan: DietPlan

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Daily Macros")
                .font(.headline)
                .foregroundColor(.white)

            HStack(spacing: 12) {
                MacroCell(label: "Protein", value: "\(plan.proteinGrams)g", color: .blue)
                MacroCell(label: "Carbs",   value: "\(plan.carbGrams)g",   color: .green)
                MacroCell(label: "Fats",    value: "\(plan.fatGrams)g",    color: .yellow)
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.08))
        .cornerRadius(16)
    }
}

private struct MacroCell: View {
    let label: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2.bold())
                .foregroundColor(color)
            Text(label)
                .font(.caption2)
                .foregroundColor(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - Meal Card

struct MealCard: View {
    let meal: Meal
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: { withAnimation(.spring()) { isExpanded.toggle() } }) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(meal.name)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(meal.time)
                            .font(.caption)
                            .foregroundColor(.orange)
                    }
                    Spacer()
                    Text("\(meal.calories) kcal")
                        .font(.subheadline.bold())
                        .foregroundColor(.white.opacity(0.7))
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.white.opacity(0.4))
                        .padding(.leading, 4)
                }
                .padding(16)
            }
            .buttonStyle(.plain)

            if isExpanded {
                Divider().background(Color.white.opacity(0.1))

                VStack(alignment: .leading, spacing: 8) {
                    ForEach(meal.foods, id: \.self) { food in
                        HStack(spacing: 8) {
                            Circle()
                                .fill(Color.orange)
                                .frame(width: 6, height: 6)
                            Text(food)
                                .font(.subheadline)
                                .foregroundColor(.white.opacity(0.85))
                        }
                    }

                    Divider().background(Color.white.opacity(0.08))

                    HStack(spacing: 16) {
                        MealMacroTag(label: "P", value: "\(meal.proteinGrams)g", color: .blue)
                        MealMacroTag(label: "C", value: "\(meal.carbGrams)g",    color: .green)
                        MealMacroTag(label: "F", value: "\(meal.fatGrams)g",     color: .yellow)
                        Spacer()
                    }
                }
                .padding(16)
                .transition(.opacity)
            }
        }
        .background(Color.white.opacity(0.08))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }
}

private struct MealMacroTag: View {
    let label: String
    let value: String
    let color: Color

    var body: some View {
        HStack(spacing: 4) {
            Text(label)
                .font(.caption2.bold())
                .foregroundColor(color)
            Text(value)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
    }
}

// MARK: - Hydration Card

struct HydrationCard: View {
    let litres: Double

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "drop.fill")
                .font(.largeTitle)
                .foregroundColor(.cyan)
            VStack(alignment: .leading, spacing: 4) {
                Text("Daily Hydration")
                    .font(.headline)
                    .foregroundColor(.white)
                Text(String(format: "Aim for %.1f litres of water per day", litres))
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.65))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.cyan.opacity(0.1))
        .cornerRadius(16)
    }
}

// MARK: - Tips Card

struct TipsCard: View {
    let tips: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Nutrition Tips", systemImage: "lightbulb.fill")
                .font(.headline)
                .foregroundColor(.white)

            ForEach(tips, id: \.self) { tip in
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.orange)
                        .padding(.top, 1)
                    Text(tip)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
            }
        }
        .padding(16)
        .background(Color.white.opacity(0.06))
        .cornerRadius(16)
    }
}

// MARK: - Shared Helper Views

struct PlanSummaryCard: View {
    let icon: String
    let title: String
    let tags: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.orange)
                Text(title)
                    .font(.title3.bold())
                    .foregroundColor(.white)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        PillTag(text: tag)
                    }
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                colors: [Color.orange.opacity(0.2), Color.orange.opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.orange.opacity(0.3), lineWidth: 1)
        )
    }
}

struct PillTag: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption2.bold())
            .foregroundColor(.orange)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.orange.opacity(0.15))
            .cornerRadius(8)
    }
}

struct RestartButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Label("Start Over", systemImage: "arrow.counterclockwise")
                .font(.subheadline.bold())
                .foregroundColor(.white.opacity(0.7))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white.opacity(0.06))
                .cornerRadius(16)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 24)
    }
}

// MARK: - Corner-radius helper

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Previews

#Preview("Results") {
    let profile = UserProfile()
    profile.name = "Alex"
    profile.age = 25
    profile.goal = .gainWeight
    profile.trainingLevel = .intermediate
    profile.musclePreference = .twoMuscles
    return ResultsTabView(onRestart: {})
        .environmentObject(profile)
}
