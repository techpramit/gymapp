import Foundation
import Combine

// MARK: - Enums

enum FitnessGoal: String, CaseIterable, Codable, Identifiable {
    case gainWeight = "Gain Weight"
    case loseWeight = "Lose Weight"
    case maintain = "Maintain Weight"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .gainWeight: return "💪"
        case .loseWeight: return "🔥"
        case .maintain: return "⚖️"
        }
    }

    var description: String {
        switch self {
        case .gainWeight: return "Build muscle mass and increase body weight"
        case .loseWeight: return "Burn fat and reduce body weight"
        case .maintain: return "Keep current weight and improve fitness"
        }
    }
}

enum TrainingLevel: String, CaseIterable, Codable, Identifiable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .beginner: return "🌱"
        case .intermediate: return "🚀"
        case .advanced: return "🏆"
        }
    }

    var description: String {
        switch self {
        case .beginner: return "0–6 months of training experience"
        case .intermediate: return "6 months – 2 years of training experience"
        case .advanced: return "2+ years of consistent training"
        }
    }
}

enum MuscleTrainingPreference: String, CaseIterable, Codable, Identifiable {
    case singleMuscle = "Single Muscle Daily"
    case twoMuscles = "Two Muscles Daily"
    case multipleMuscles = "Multiple Muscles Daily"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .singleMuscle: return "🎯"
        case .twoMuscles: return "⚡️"
        case .multipleMuscles: return "🔄"
        }
    }

    var description: String {
        switch self {
        case .singleMuscle: return "Focus intensely on one muscle group per session"
        case .twoMuscles: return "Train two complementary muscle groups per session"
        case .multipleMuscles: return "Full-body or multi-group sessions for maximum frequency"
        }
    }
}

enum MuscleGroup: String, CaseIterable, Codable, Identifiable {
    case chest = "Chest"
    case back = "Back"
    case shoulders = "Shoulders"
    case biceps = "Biceps"
    case triceps = "Triceps"
    case legs = "Legs"
    case core = "Core"
    case cardio = "Cardio"
    case fullBody = "Full Body"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .chest: return "🏋️"
        case .back: return "🔙"
        case .shoulders: return "🙆"
        case .biceps: return "💪"
        case .triceps: return "💪"
        case .legs: return "🦵"
        case .core: return "⭕"
        case .cardio: return "🏃"
        case .fullBody: return "🔄"
        }
    }
}

// MARK: - User Profile

class UserProfile: ObservableObject {
    @Published var name: String = ""
    @Published var age: Int = 20
    @Published var weightKg: Double = 70
    @Published var heightCm: Double = 170
    @Published var goal: FitnessGoal = .gainWeight
    @Published var trainingLevel: TrainingLevel = .beginner
    @Published var musclePreference: MuscleTrainingPreference = .twoMuscles

    var isProfileComplete: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty && age > 0
    }

    var bmi: Double {
        let heightM = heightCm / 100
        return weightKg / (heightM * heightM)
    }

    /// Mifflin–St Jeor BMR with moderate activity (TDEE × 1.55), adjusted for goal.
    var dailyCalories: Int {
        // Using male formula as approximation; a production app would ask gender.
        let bmr = 10 * weightKg + 6.25 * heightCm - 5 * Double(age) + 5
        let tdee = bmr * 1.55
        switch goal {
        case .gainWeight:   return Int(tdee + 500)
        case .loseWeight:   return Int(tdee - 500)
        case .maintain:     return Int(tdee)
        }
    }

    /// Protein target: 2 g/kg for muscle gain, 2.2 g/kg for fat loss, 1.6 g/kg for maintain.
    var dailyProteinGrams: Int {
        switch goal {
        case .gainWeight:   return Int(weightKg * 2.0)
        case .loseWeight:   return Int(weightKg * 2.2)
        case .maintain:     return Int(weightKg * 1.6)
        }
    }

    func reset() {
        name = ""
        age = 20
        weightKg = 70
        heightCm = 170
        goal = .gainWeight
        trainingLevel = .beginner
        musclePreference = .twoMuscles
    }
}

// MARK: - Exercise

struct Exercise: Identifiable, Codable {
    let id: UUID
    let name: String
    let muscleGroup: MuscleGroup
    let sets: Int
    let reps: String        // e.g. "8–12" or "12–15"
    let restSeconds: Int
    let instructions: String
    let difficulty: TrainingLevel

    init(
        id: UUID = UUID(),
        name: String,
        muscleGroup: MuscleGroup,
        sets: Int,
        reps: String,
        restSeconds: Int,
        instructions: String,
        difficulty: TrainingLevel
    ) {
        self.id = id
        self.name = name
        self.muscleGroup = muscleGroup
        self.sets = sets
        self.reps = reps
        self.restSeconds = restSeconds
        self.instructions = instructions
        self.difficulty = difficulty
    }
}

// MARK: - Workout Plan

struct WorkoutDay: Identifiable, Codable {
    let id: UUID
    let dayName: String             // e.g. "Monday"
    let muscleGroups: [MuscleGroup]
    let exercises: [Exercise]
    let isRestDay: Bool

    init(
        id: UUID = UUID(),
        dayName: String,
        muscleGroups: [MuscleGroup] = [],
        exercises: [Exercise] = [],
        isRestDay: Bool = false
    ) {
        self.id = id
        self.dayName = dayName
        self.muscleGroups = muscleGroups
        self.exercises = exercises
        self.isRestDay = isRestDay
    }
}

struct WeeklyWorkoutPlan: Identifiable, Codable {
    let id: UUID
    let planName: String
    let days: [WorkoutDay]
    let goal: FitnessGoal
    let level: TrainingLevel
    let musclePreference: MuscleTrainingPreference

    init(
        id: UUID = UUID(),
        planName: String,
        days: [WorkoutDay],
        goal: FitnessGoal,
        level: TrainingLevel,
        musclePreference: MuscleTrainingPreference
    ) {
        self.id = id
        self.planName = planName
        self.days = days
        self.goal = goal
        self.level = level
        self.musclePreference = musclePreference
    }
}

// MARK: - Diet Plan

struct Meal: Identifiable, Codable {
    let id: UUID
    let name: String        // e.g. "Breakfast"
    let time: String        // e.g. "7:00 AM"
    let foods: [String]
    let calories: Int
    let proteinGrams: Int
    let carbGrams: Int
    let fatGrams: Int

    init(
        id: UUID = UUID(),
        name: String,
        time: String,
        foods: [String],
        calories: Int,
        proteinGrams: Int,
        carbGrams: Int,
        fatGrams: Int
    ) {
        self.id = id
        self.name = name
        self.time = time
        self.foods = foods
        self.calories = calories
        self.proteinGrams = proteinGrams
        self.carbGrams = carbGrams
        self.fatGrams = fatGrams
    }
}

struct DietPlan: Identifiable, Codable {
    let id: UUID
    let planName: String
    let dailyCalories: Int
    let proteinGrams: Int
    let carbGrams: Int
    let fatGrams: Int
    let meals: [Meal]
    let hydrationLitres: Double
    let tips: [String]
    let goal: FitnessGoal

    init(
        id: UUID = UUID(),
        planName: String,
        dailyCalories: Int,
        proteinGrams: Int,
        carbGrams: Int,
        fatGrams: Int,
        meals: [Meal],
        hydrationLitres: Double,
        tips: [String],
        goal: FitnessGoal
    ) {
        self.id = id
        self.planName = planName
        self.dailyCalories = dailyCalories
        self.proteinGrams = proteinGrams
        self.carbGrams = carbGrams
        self.fatGrams = fatGrams
        self.meals = meals
        self.hydrationLitres = hydrationLitres
        self.tips = tips
        self.goal = goal
    }
}
