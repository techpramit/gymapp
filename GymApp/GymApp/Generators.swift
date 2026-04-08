import Foundation

// MARK: - Routine Generator

struct RoutineGenerator {

    /// Generates a full weekly workout plan based on the user's profile.
    static func generate(for profile: UserProfile) -> WeeklyWorkoutPlan {
        switch profile.musclePreference {
        case .singleMuscle:   return singleMusclePlan(profile: profile)
        case .twoMuscles:     return twoMusclesPlan(profile: profile)
        case .multipleMuscles: return fullBodyPlan(profile: profile)
        }
    }

    // MARK: Single Muscle Per Day (6-day PPL bro-split)

    private static func singleMusclePlan(profile: UserProfile) -> WeeklyWorkoutPlan {
        let level = profile.trainingLevel
        let days = [
            WorkoutDay(
                dayName: "Monday",
                muscleGroups: [.chest],
                exercises: ExerciseDatabase.exercises(for: .chest, level: level)
            ),
            WorkoutDay(
                dayName: "Tuesday",
                muscleGroups: [.back],
                exercises: ExerciseDatabase.exercises(for: .back, level: level)
            ),
            WorkoutDay(
                dayName: "Wednesday",
                muscleGroups: [.legs],
                exercises: ExerciseDatabase.exercises(for: .legs, level: level)
            ),
            WorkoutDay(
                dayName: "Thursday",
                muscleGroups: [.shoulders],
                exercises: ExerciseDatabase.exercises(for: .shoulders, level: level)
            ),
            WorkoutDay(
                dayName: "Friday",
                muscleGroups: [.biceps],
                exercises: ExerciseDatabase.exercises(for: .biceps, level: level)
                    + ExerciseDatabase.exercises(for: .triceps, level: level)
            ),
            WorkoutDay(
                dayName: "Saturday",
                muscleGroups: [.core],
                exercises: ExerciseDatabase.exercises(for: .core, level: level)
                    + Array(ExerciseDatabase.exercises(for: .cardio, level: level).prefix(2))
            ),
            WorkoutDay(
                dayName: "Sunday",
                muscleGroups: [],
                exercises: [],
                isRestDay: true
            ),
        ]
        return WeeklyWorkoutPlan(
            planName: "6-Day Single Muscle Focus",
            days: days,
            goal: profile.goal,
            level: level,
            musclePreference: .singleMuscle
        )
    }

    // MARK: Two Muscles Per Day (Push / Pull / Legs split – 3-day repeated)

    private static func twoMusclesPlan(profile: UserProfile) -> WeeklyWorkoutPlan {
        let level = profile.trainingLevel

        let pushExercises =
            ExerciseDatabase.exercises(for: .chest, level: level)
            + ExerciseDatabase.exercises(for: .shoulders, level: level)
            + ExerciseDatabase.exercises(for: .triceps, level: level)

        let pullExercises =
            ExerciseDatabase.exercises(for: .back, level: level)
            + ExerciseDatabase.exercises(for: .biceps, level: level)

        let legsExercises =
            ExerciseDatabase.exercises(for: .legs, level: level)
            + ExerciseDatabase.exercises(for: .core, level: level)

        let days = [
            WorkoutDay(dayName: "Monday",    muscleGroups: [.chest, .shoulders, .triceps], exercises: pushExercises),
            WorkoutDay(dayName: "Tuesday",   muscleGroups: [.back, .biceps],               exercises: pullExercises),
            WorkoutDay(dayName: "Wednesday", muscleGroups: [.legs, .core],                 exercises: legsExercises),
            WorkoutDay(dayName: "Thursday",  muscleGroups: [.chest, .shoulders, .triceps], exercises: pushExercises),
            WorkoutDay(dayName: "Friday",    muscleGroups: [.back, .biceps],               exercises: pullExercises),
            WorkoutDay(dayName: "Saturday",  muscleGroups: [.legs, .core],                 exercises: legsExercises),
            WorkoutDay(dayName: "Sunday",    muscleGroups: [],                             exercises: [], isRestDay: true),
        ]
        return WeeklyWorkoutPlan(
            planName: "Push / Pull / Legs (6-Day)",
            days: days,
            goal: profile.goal,
            level: level,
            musclePreference: .twoMuscles
        )
    }

    // MARK: Multiple Muscles Per Day (Full-Body, 4 days/week)

    private static func fullBodyPlan(profile: UserProfile) -> WeeklyWorkoutPlan {
        let level = profile.trainingLevel

        // Pick a representative selection of exercises per session (2 per group)
        func pick(_ group: MuscleGroup, count: Int = 2) -> [Exercise] {
            Array(ExerciseDatabase.exercises(for: group, level: level).prefix(count))
        }

        let sessionA: [Exercise] = pick(.chest) + pick(.back) + pick(.legs) + pick(.core)
        let sessionB: [Exercise] = pick(.shoulders) + pick(.biceps) + pick(.triceps)
            + pick(.legs) + pick(.cardio, count: 1)

        let days = [
            WorkoutDay(dayName: "Monday",    muscleGroups: [.chest, .back, .legs, .core],                  exercises: sessionA),
            WorkoutDay(dayName: "Tuesday",   muscleGroups: [],                                              exercises: [], isRestDay: true),
            WorkoutDay(dayName: "Wednesday", muscleGroups: [.shoulders, .biceps, .triceps, .legs, .cardio], exercises: sessionB),
            WorkoutDay(dayName: "Thursday",  muscleGroups: [],                                              exercises: [], isRestDay: true),
            WorkoutDay(dayName: "Friday",    muscleGroups: [.chest, .back, .legs, .core],                  exercises: sessionA),
            WorkoutDay(dayName: "Saturday",  muscleGroups: [.shoulders, .biceps, .triceps, .legs, .cardio], exercises: sessionB),
            WorkoutDay(dayName: "Sunday",    muscleGroups: [],                                              exercises: [], isRestDay: true),
        ]
        return WeeklyWorkoutPlan(
            planName: "Full-Body Split (4-Day)",
            days: days,
            goal: profile.goal,
            level: level,
            musclePreference: .multipleMuscles
        )
    }
}

// MARK: - Diet Plan Generator

struct DietPlanGenerator {

    static func generate(for profile: UserProfile) -> DietPlan {
        let calories  = profile.dailyCalories
        let protein   = profile.dailyProteinGrams
        // Remaining calories split 40 % carbs, 20 % fat (after protein)
        let proteinCal = protein * 4
        let remaining  = max(calories - proteinCal, 0)
        let carbs      = Int(Double(remaining) * 0.65 / 4)
        let fats       = Int(Double(remaining) * 0.35 / 9)

        let meals = buildMeals(goal: profile.goal, totalCalories: calories, protein: protein)

        let tips = buildTips(goal: profile.goal)

        return DietPlan(
            planName: planName(for: profile.goal),
            dailyCalories: calories,
            proteinGrams: protein,
            carbGrams: carbs,
            fatGrams: fats,
            meals: meals,
            hydrationLitres: profile.goal == .gainWeight ? 3.5 : 3.0,
            tips: tips,
            goal: profile.goal
        )
    }

    // MARK: Helpers

    private static func planName(for goal: FitnessGoal) -> String {
        switch goal {
        case .gainWeight:  return "Muscle-Building Diet Plan"
        case .loseWeight:  return "Fat-Loss Diet Plan"
        case .maintain:    return "Maintenance Diet Plan"
        }
    }

    private static func buildMeals(goal: FitnessGoal, totalCalories: Int, protein: Int) -> [Meal] {
        switch goal {
        case .gainWeight:
            return [
                Meal(name: "Breakfast", time: "7:00 AM",
                     foods: ["4 whole eggs scrambled", "2 slices wholegrain toast", "1 cup oats with banana",
                             "250 ml whole milk"],
                     calories: Int(Double(totalCalories) * 0.25),
                     proteinGrams: Int(Double(protein) * 0.25), carbGrams: 80, fatGrams: 20),
                Meal(name: "Mid-Morning Snack", time: "10:00 AM",
                     foods: ["Greek yogurt (200 g)", "Handful of mixed nuts", "1 apple"],
                     calories: Int(Double(totalCalories) * 0.12),
                     proteinGrams: Int(Double(protein) * 0.15), carbGrams: 30, fatGrams: 15),
                Meal(name: "Lunch", time: "1:00 PM",
                     foods: ["200 g grilled chicken breast", "1.5 cups brown rice", "Large mixed salad",
                             "1 tbsp olive oil dressing"],
                     calories: Int(Double(totalCalories) * 0.28),
                     proteinGrams: Int(Double(protein) * 0.30), carbGrams: 90, fatGrams: 12),
                Meal(name: "Pre-Workout Snack", time: "4:00 PM",
                     foods: ["Protein shake (30 g whey)", "1 banana", "Rice cakes (2 pieces)"],
                     calories: Int(Double(totalCalories) * 0.12),
                     proteinGrams: Int(Double(protein) * 0.18), carbGrams: 50, fatGrams: 3),
                Meal(name: "Post-Workout / Dinner", time: "7:00 PM",
                     foods: ["250 g lean beef or salmon", "Sweet potato (medium)", "Steamed broccoli",
                             "Cottage cheese (150 g)"],
                     calories: Int(Double(totalCalories) * 0.23),
                     proteinGrams: Int(Double(protein) * 0.12), carbGrams: 60, fatGrams: 18),
            ]

        case .loseWeight:
            return [
                Meal(name: "Breakfast", time: "7:30 AM",
                     foods: ["3 egg whites + 1 whole egg omelette", "Spinach & mushrooms",
                             "1 slice wholegrain toast"],
                     calories: Int(Double(totalCalories) * 0.22),
                     proteinGrams: Int(Double(protein) * 0.25), carbGrams: 25, fatGrams: 8),
                Meal(name: "Mid-Morning Snack", time: "10:30 AM",
                     foods: ["Casein protein shake (25 g)", "1 medium apple"],
                     calories: Int(Double(totalCalories) * 0.10),
                     proteinGrams: Int(Double(protein) * 0.15), carbGrams: 20, fatGrams: 2),
                Meal(name: "Lunch", time: "1:00 PM",
                     foods: ["180 g grilled chicken or tuna", "Large leafy green salad",
                             "1/2 cup quinoa", "2 tbsp balsamic vinegar dressing"],
                     calories: Int(Double(totalCalories) * 0.28),
                     proteinGrams: Int(Double(protein) * 0.30), carbGrams: 35, fatGrams: 8),
                Meal(name: "Afternoon Snack", time: "4:00 PM",
                     foods: ["Cottage cheese (150 g)", "Celery sticks", "Cucumber slices"],
                     calories: Int(Double(totalCalories) * 0.10),
                     proteinGrams: Int(Double(protein) * 0.15), carbGrams: 8, fatGrams: 3),
                Meal(name: "Dinner", time: "7:00 PM",
                     foods: ["200 g white fish or turkey breast", "Roasted vegetables",
                             "1/2 cup brown rice"],
                     calories: Int(Double(totalCalories) * 0.30),
                     proteinGrams: Int(Double(protein) * 0.15), carbGrams: 40, fatGrams: 10),
            ]

        case .maintain:
            return [
                Meal(name: "Breakfast", time: "7:00 AM",
                     foods: ["2 whole eggs + 2 whites", "1 cup oats", "Mixed berries",
                             "Black coffee or green tea"],
                     calories: Int(Double(totalCalories) * 0.25),
                     proteinGrams: Int(Double(protein) * 0.22), carbGrams: 60, fatGrams: 12),
                Meal(name: "Mid-Morning Snack", time: "10:00 AM",
                     foods: ["Handful of almonds (30 g)", "1 banana"],
                     calories: Int(Double(totalCalories) * 0.10),
                     proteinGrams: Int(Double(protein) * 0.08), carbGrams: 28, fatGrams: 14),
                Meal(name: "Lunch", time: "1:00 PM",
                     foods: ["180 g grilled chicken or fish", "Brown rice (1 cup)",
                             "Mixed vegetables stir-fry", "1 tbsp olive oil"],
                     calories: Int(Double(totalCalories) * 0.28),
                     proteinGrams: Int(Double(protein) * 0.30), carbGrams: 65, fatGrams: 12),
                Meal(name: "Post-Workout Snack", time: "4:30 PM",
                     foods: ["Whey protein shake (25 g)", "1 piece of fruit"],
                     calories: Int(Double(totalCalories) * 0.12),
                     proteinGrams: Int(Double(protein) * 0.20), carbGrams: 25, fatGrams: 2),
                Meal(name: "Dinner", time: "7:00 PM",
                     foods: ["200 g lean protein (chicken, beef, tofu)", "Sweet potato",
                             "Green salad", "Avocado (1/4)"],
                     calories: Int(Double(totalCalories) * 0.25),
                     proteinGrams: Int(Double(protein) * 0.20), carbGrams: 50, fatGrams: 14),
            ]
        }
    }

    private static func buildTips(goal: FitnessGoal) -> [String] {
        switch goal {
        case .gainWeight:
            return [
                "Eat within 30–60 min of waking to kickstart muscle protein synthesis.",
                "Consume a fast-digesting protein (whey) + simple carbs within 30 min post-workout.",
                "Track calories to ensure you stay in a consistent calorie surplus of 300–500 kcal.",
                "Prioritise sleep (7–9 hours) — growth hormone peaks during deep sleep.",
                "Limit cardio to 2 low-intensity sessions per week to avoid burning excess calories.",
                "Increase calories gradually (100–200 kcal/week) to minimise fat gain.",
            ]
        case .loseWeight:
            return [
                "Maintain a calorie deficit of 400–500 kcal/day for steady, sustainable fat loss.",
                "Prioritise protein at every meal to preserve lean muscle while cutting.",
                "Drink 3–4 litres of water daily; hunger is often disguised thirst.",
                "Include 2–3 cardio sessions per week (20–30 min moderate intensity).",
                "Avoid liquid calories — sodas, juices, and alcohol can quickly erase your deficit.",
                "Get 7–8 hours of sleep; poor sleep raises cortisol and increases fat retention.",
            ]
        case .maintain:
            return [
                "Monitor your weight weekly and adjust calories if you trend up or down.",
                "Keep protein high (1.6–2 g/kg) to support ongoing muscle maintenance.",
                "Vary your training to avoid plateaus and maintain motivation.",
                "Choose whole foods over processed options for micronutrient density.",
                "Include healthy fats (avocado, nuts, olive oil) for hormonal health.",
                "Periodically cycle between slight surplus and slight deficit to optimise body composition.",
            ]
        }
    }
}
