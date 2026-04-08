import Foundation

// MARK: - Exercise Database

struct ExerciseDatabase {

    // MARK: Chest

    static let chestBeginner: [Exercise] = [
        Exercise(name: "Push-Up",
                 muscleGroup: .chest, sets: 3, reps: "10–15",
                 restSeconds: 60,
                 instructions: "Start in a high-plank position. Lower your chest to the floor, then press back up.",
                 difficulty: .beginner),
        Exercise(name: "Incline Push-Up",
                 muscleGroup: .chest, sets: 3, reps: "10–15",
                 restSeconds: 60,
                 instructions: "Place hands on an elevated surface. Perform a push-up with body angled downward.",
                 difficulty: .beginner),
        Exercise(name: "Dumbbell Chest Press (Light)",
                 muscleGroup: .chest, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Lie on a bench, hold dumbbells at chest level, press up and lower slowly.",
                 difficulty: .beginner),
        Exercise(name: "Chest Fly (Machine)",
                 muscleGroup: .chest, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Sit on the pec-deck machine, bring arms together in front of chest.",
                 difficulty: .beginner),
    ]

    static let chestIntermediate: [Exercise] = [
        Exercise(name: "Barbell Bench Press",
                 muscleGroup: .chest, sets: 4, reps: "8–12",
                 restSeconds: 90,
                 instructions: "Lie on a flat bench, grip bar slightly wider than shoulder-width, lower to chest and press up.",
                 difficulty: .intermediate),
        Exercise(name: "Incline Dumbbell Press",
                 muscleGroup: .chest, sets: 3, reps: "10–12",
                 restSeconds: 90,
                 instructions: "Set bench to 30–45°, press dumbbells from chest level to full arm extension.",
                 difficulty: .intermediate),
        Exercise(name: "Cable Chest Fly",
                 muscleGroup: .chest, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Stand between cables set at shoulder height, bring handles together in a wide arc.",
                 difficulty: .intermediate),
        Exercise(name: "Dips (Chest Focus)",
                 muscleGroup: .chest, sets: 3, reps: "10–12",
                 restSeconds: 90,
                 instructions: "Lean slightly forward on parallel bars and lower until upper arms are parallel to floor.",
                 difficulty: .intermediate),
    ]

    static let chestAdvanced: [Exercise] = [
        Exercise(name: "Weighted Bench Press",
                 muscleGroup: .chest, sets: 5, reps: "4–6",
                 restSeconds: 180,
                 instructions: "Perform a flat barbell bench press with heavy load; use a spotter.",
                 difficulty: .advanced),
        Exercise(name: "Decline Barbell Press",
                 muscleGroup: .chest, sets: 4, reps: "6–8",
                 restSeconds: 120,
                 instructions: "Lie on a decline bench, press barbell from lower chest level.",
                 difficulty: .advanced),
        Exercise(name: "Cable Crossover",
                 muscleGroup: .chest, sets: 4, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Set cables high, cross handles in front of body targeting lower chest.",
                 difficulty: .advanced),
        Exercise(name: "Weighted Dips",
                 muscleGroup: .chest, sets: 4, reps: "8–10",
                 restSeconds: 120,
                 instructions: "Attach weight belt or use dip belt for added resistance.",
                 difficulty: .advanced),
    ]

    // MARK: Back

    static let backBeginner: [Exercise] = [
        Exercise(name: "Lat Pulldown (Light)",
                 muscleGroup: .back, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Sit at the machine, grip bar wide, pull down to chin level.",
                 difficulty: .beginner),
        Exercise(name: "Seated Cable Row",
                 muscleGroup: .back, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Sit upright, pull handle to abdomen, squeeze shoulder blades.",
                 difficulty: .beginner),
        Exercise(name: "Dumbbell Row (Light)",
                 muscleGroup: .back, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Support knee on bench, pull dumbbell to hip in a rowing motion.",
                 difficulty: .beginner),
        Exercise(name: "Superman",
                 muscleGroup: .back, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Lie face down, lift arms and legs simultaneously, hold 2 sec.",
                 difficulty: .beginner),
    ]

    static let backIntermediate: [Exercise] = [
        Exercise(name: "Pull-Up",
                 muscleGroup: .back, sets: 4, reps: "6–10",
                 restSeconds: 90,
                 instructions: "Hang from bar, pull chest to bar keeping core tight.",
                 difficulty: .intermediate),
        Exercise(name: "Barbell Bent-Over Row",
                 muscleGroup: .back, sets: 4, reps: "8–12",
                 restSeconds: 90,
                 instructions: "Hinge at hips, pull bar to lower ribcage, squeeze lats.",
                 difficulty: .intermediate),
        Exercise(name: "Lat Pulldown (Heavy)",
                 muscleGroup: .back, sets: 4, reps: "8–12",
                 restSeconds: 90,
                 instructions: "Use a challenging load; keep torso slightly reclined.",
                 difficulty: .intermediate),
        Exercise(name: "T-Bar Row",
                 muscleGroup: .back, sets: 3, reps: "10–12",
                 restSeconds: 90,
                 instructions: "Straddle the bar, pull handle to chest with elbows wide.",
                 difficulty: .intermediate),
    ]

    static let backAdvanced: [Exercise] = [
        Exercise(name: "Weighted Pull-Up",
                 muscleGroup: .back, sets: 5, reps: "5–8",
                 restSeconds: 120,
                 instructions: "Add weight via belt; focus on full range of motion.",
                 difficulty: .advanced),
        Exercise(name: "Deadlift",
                 muscleGroup: .back, sets: 4, reps: "4–6",
                 restSeconds: 180,
                 instructions: "Hip-hinge to grip the bar, drive hips forward to stand, lower controlled.",
                 difficulty: .advanced),
        Exercise(name: "Pendlay Row",
                 muscleGroup: .back, sets: 4, reps: "6–8",
                 restSeconds: 120,
                 instructions: "From a dead-stop each rep, explosively pull barbell to lower chest.",
                 difficulty: .advanced),
        Exercise(name: "Meadows Row",
                 muscleGroup: .back, sets: 4, reps: "8–10",
                 restSeconds: 90,
                 instructions: "Stand perpendicular to landmine, row with single arm for full lat stretch.",
                 difficulty: .advanced),
    ]

    // MARK: Shoulders

    static let shouldersBeginner: [Exercise] = [
        Exercise(name: "Dumbbell Lateral Raise",
                 muscleGroup: .shoulders, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Raise dumbbells to shoulder height with slight elbow bend.",
                 difficulty: .beginner),
        Exercise(name: "Dumbbell Front Raise",
                 muscleGroup: .shoulders, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Alternate raising dumbbells to eye level, thumb up.",
                 difficulty: .beginner),
        Exercise(name: "Seated Dumbbell Press",
                 muscleGroup: .shoulders, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Sit upright, press dumbbells from ear height overhead.",
                 difficulty: .beginner),
    ]

    static let shouldersIntermediate: [Exercise] = [
        Exercise(name: "Overhead Press (Barbell)",
                 muscleGroup: .shoulders, sets: 4, reps: "8–12",
                 restSeconds: 90,
                 instructions: "Press bar from chin to lockout overhead; keep core braced.",
                 difficulty: .intermediate),
        Exercise(name: "Arnold Press",
                 muscleGroup: .shoulders, sets: 3, reps: "10–12",
                 restSeconds: 90,
                 instructions: "Start with palms facing you, rotate outward as you press up.",
                 difficulty: .intermediate),
        Exercise(name: "Cable Lateral Raise",
                 muscleGroup: .shoulders, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Using a low cable, raise arm to shoulder height in a lateral arc.",
                 difficulty: .intermediate),
        Exercise(name: "Face Pull",
                 muscleGroup: .shoulders, sets: 3, reps: "15–20",
                 restSeconds: 60,
                 instructions: "Pull rope to face level, elbows high, targeting rear delts.",
                 difficulty: .intermediate),
    ]

    static let shouldersAdvanced: [Exercise] = [
        Exercise(name: "Push Press",
                 muscleGroup: .shoulders, sets: 5, reps: "5–8",
                 restSeconds: 120,
                 instructions: "Slight dip then drive bar overhead using leg momentum.",
                 difficulty: .advanced),
        Exercise(name: "Seated Barbell Press (Behind Neck)",
                 muscleGroup: .shoulders, sets: 4, reps: "8–10",
                 restSeconds: 90,
                 instructions: "Lower bar behind head to shoulder level; requires good mobility.",
                 difficulty: .advanced),
        Exercise(name: "Handstand Push-Up",
                 muscleGroup: .shoulders, sets: 3, reps: "6–10",
                 restSeconds: 120,
                 instructions: "Against a wall in a handstand position, lower head to floor and press up.",
                 difficulty: .advanced),
    ]

    // MARK: Biceps

    static let bicepsBeginner: [Exercise] = [
        Exercise(name: "Dumbbell Curl",
                 muscleGroup: .biceps, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Stand with dumbbells at sides, curl upward keeping elbows fixed.",
                 difficulty: .beginner),
        Exercise(name: "Hammer Curl",
                 muscleGroup: .biceps, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Neutral grip curl targeting brachialis; thumbs point up throughout.",
                 difficulty: .beginner),
        Exercise(name: "Resistance Band Curl",
                 muscleGroup: .biceps, sets: 3, reps: "15–20",
                 restSeconds: 60,
                 instructions: "Stand on band, curl handles toward shoulders.",
                 difficulty: .beginner),
    ]

    static let bicepsIntermediate: [Exercise] = [
        Exercise(name: "Barbell Curl",
                 muscleGroup: .biceps, sets: 4, reps: "8–12",
                 restSeconds: 90,
                 instructions: "Grip bar shoulder-width, curl to chin, lower slowly.",
                 difficulty: .intermediate),
        Exercise(name: "Incline Dumbbell Curl",
                 muscleGroup: .biceps, sets: 3, reps: "10–12",
                 restSeconds: 90,
                 instructions: "Lean back on incline bench, arms hang; curl for full stretch.",
                 difficulty: .intermediate),
        Exercise(name: "Concentration Curl",
                 muscleGroup: .biceps, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Seated, brace arm against inner thigh, curl dumbbell to shoulder.",
                 difficulty: .intermediate),
    ]

    static let bicepsAdvanced: [Exercise] = [
        Exercise(name: "EZ-Bar Preacher Curl",
                 muscleGroup: .biceps, sets: 4, reps: "8–10",
                 restSeconds: 90,
                 instructions: "Use preacher bench to isolate; lower fully for maximum stretch.",
                 difficulty: .advanced),
        Exercise(name: "Cable Curl",
                 muscleGroup: .biceps, sets: 4, reps: "10–12",
                 restSeconds: 60,
                 instructions: "Low-cable curl keeps constant tension throughout the range.",
                 difficulty: .advanced),
        Exercise(name: "Spider Curl",
                 muscleGroup: .biceps, sets: 3, reps: "10–12",
                 restSeconds: 60,
                 instructions: "Lie face-down on incline bench, arms hang, curl bar to forehead.",
                 difficulty: .advanced),
    ]

    // MARK: Triceps

    static let tricepsBeginner: [Exercise] = [
        Exercise(name: "Triceps Pushdown (Rope)",
                 muscleGroup: .triceps, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Stand at cable, push rope down and flare at the bottom.",
                 difficulty: .beginner),
        Exercise(name: "Overhead Triceps Extension (Dumbbell)",
                 muscleGroup: .triceps, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Hold one dumbbell with both hands overhead, lower behind head.",
                 difficulty: .beginner),
        Exercise(name: "Bench Dips",
                 muscleGroup: .triceps, sets: 3, reps: "10–15",
                 restSeconds: 60,
                 instructions: "Hands on bench edge behind you, lower body by bending elbows.",
                 difficulty: .beginner),
    ]

    static let tricepsIntermediate: [Exercise] = [
        Exercise(name: "Close-Grip Bench Press",
                 muscleGroup: .triceps, sets: 4, reps: "8–12",
                 restSeconds: 90,
                 instructions: "Use shoulder-width grip on barbell bench press.",
                 difficulty: .intermediate),
        Exercise(name: "Skull Crusher",
                 muscleGroup: .triceps, sets: 3, reps: "10–12",
                 restSeconds: 90,
                 instructions: "Lie on bench, lower EZ-bar to forehead, press back up.",
                 difficulty: .intermediate),
        Exercise(name: "Triceps Dips (Parallel Bars)",
                 muscleGroup: .triceps, sets: 3, reps: "10–15",
                 restSeconds: 90,
                 instructions: "Keep torso upright to target triceps; lower until elbows at 90°.",
                 difficulty: .intermediate),
    ]

    static let tricepsAdvanced: [Exercise] = [
        Exercise(name: "Weighted Triceps Dips",
                 muscleGroup: .triceps, sets: 4, reps: "8–10",
                 restSeconds: 120,
                 instructions: "Add weight via belt; keep torso upright for maximum triceps activation.",
                 difficulty: .advanced),
        Exercise(name: "Tate Press",
                 muscleGroup: .triceps, sets: 4, reps: "10–12",
                 restSeconds: 90,
                 instructions: "Lie on bench, dumbbells pointed to ceiling, lower to chest, press up.",
                 difficulty: .advanced),
        Exercise(name: "Cable Overhead Triceps Extension",
                 muscleGroup: .triceps, sets: 4, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Face away from cable, extend arms overhead from rope attachment.",
                 difficulty: .advanced),
    ]

    // MARK: Legs

    static let legsBeginner: [Exercise] = [
        Exercise(name: "Bodyweight Squat",
                 muscleGroup: .legs, sets: 3, reps: "15–20",
                 restSeconds: 60,
                 instructions: "Feet shoulder-width, squat until thighs parallel to floor.",
                 difficulty: .beginner),
        Exercise(name: "Dumbbell Lunge",
                 muscleGroup: .legs, sets: 3, reps: "10–12 each leg",
                 restSeconds: 60,
                 instructions: "Step forward and lower rear knee toward floor.",
                 difficulty: .beginner),
        Exercise(name: "Leg Press (Light)",
                 muscleGroup: .legs, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Place feet shoulder-width on platform, press to full extension.",
                 difficulty: .beginner),
        Exercise(name: "Lying Leg Curl",
                 muscleGroup: .legs, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Curl weight toward glutes, squeeze hamstrings at top.",
                 difficulty: .beginner),
        Exercise(name: "Standing Calf Raise",
                 muscleGroup: .legs, sets: 3, reps: "15–20",
                 restSeconds: 60,
                 instructions: "Rise onto toes, hold 1 sec at top, lower fully.",
                 difficulty: .beginner),
    ]

    static let legsIntermediate: [Exercise] = [
        Exercise(name: "Barbell Back Squat",
                 muscleGroup: .legs, sets: 4, reps: "8–12",
                 restSeconds: 120,
                 instructions: "Bar on traps, descend until thighs parallel, drive through heels.",
                 difficulty: .intermediate),
        Exercise(name: "Romanian Deadlift",
                 muscleGroup: .legs, sets: 4, reps: "10–12",
                 restSeconds: 90,
                 instructions: "Hinge at hips with soft knees, lower bar along legs to mid-shin.",
                 difficulty: .intermediate),
        Exercise(name: "Leg Press",
                 muscleGroup: .legs, sets: 4, reps: "10–12",
                 restSeconds: 90,
                 instructions: "High foot position targets hamstrings and glutes.",
                 difficulty: .intermediate),
        Exercise(name: "Walking Lunge",
                 muscleGroup: .legs, sets: 3, reps: "12 each leg",
                 restSeconds: 90,
                 instructions: "Step forward, lower rear knee, stand, continue forward.",
                 difficulty: .intermediate),
        Exercise(name: "Seated Leg Curl",
                 muscleGroup: .legs, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Full stretch at top, squeeze at bottom of curl.",
                 difficulty: .intermediate),
    ]

    static let legsAdvanced: [Exercise] = [
        Exercise(name: "Barbell Front Squat",
                 muscleGroup: .legs, sets: 5, reps: "4–6",
                 restSeconds: 180,
                 instructions: "Bar rests on front delts, elbows high, deep squat.",
                 difficulty: .advanced),
        Exercise(name: "Bulgarian Split Squat",
                 muscleGroup: .legs, sets: 4, reps: "8–10 each leg",
                 restSeconds: 120,
                 instructions: "Rear foot elevated, hold dumbbells, lower front leg to 90°.",
                 difficulty: .advanced),
        Exercise(name: "Hack Squat",
                 muscleGroup: .legs, sets: 4, reps: "8–12",
                 restSeconds: 120,
                 instructions: "Use machine, deep range of motion for quad development.",
                 difficulty: .advanced),
        Exercise(name: "Nordic Hamstring Curl",
                 muscleGroup: .legs, sets: 3, reps: "6–8",
                 restSeconds: 120,
                 instructions: "Kneel with feet anchored, lower body slowly under hamstring control.",
                 difficulty: .advanced),
        Exercise(name: "Standing Machine Calf Raise (Heavy)",
                 muscleGroup: .legs, sets: 5, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Full range of motion; pause at stretch at bottom.",
                 difficulty: .advanced),
    ]

    // MARK: Core

    static let coreBeginner: [Exercise] = [
        Exercise(name: "Plank",
                 muscleGroup: .core, sets: 3, reps: "20–30 sec",
                 restSeconds: 60,
                 instructions: "Hold push-up position on forearms; keep hips level.",
                 difficulty: .beginner),
        Exercise(name: "Crunch",
                 muscleGroup: .core, sets: 3, reps: "15–20",
                 restSeconds: 60,
                 instructions: "Lie on back, curl shoulders toward knees, exhale at top.",
                 difficulty: .beginner),
        Exercise(name: "Leg Raise",
                 muscleGroup: .core, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Lie flat, raise legs to 90°, lower slowly without touching floor.",
                 difficulty: .beginner),
    ]

    static let coreIntermediate: [Exercise] = [
        Exercise(name: "Hanging Knee Raise",
                 muscleGroup: .core, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Hang from bar, raise knees to chest, lower with control.",
                 difficulty: .intermediate),
        Exercise(name: "Cable Crunch",
                 muscleGroup: .core, sets: 3, reps: "15–20",
                 restSeconds: 60,
                 instructions: "Kneel below cable, crunch elbows toward knees.",
                 difficulty: .intermediate),
        Exercise(name: "Russian Twist",
                 muscleGroup: .core, sets: 3, reps: "20 total",
                 restSeconds: 60,
                 instructions: "Sit at 45°, hold plate, rotate side to side.",
                 difficulty: .intermediate),
        Exercise(name: "Ab Wheel Rollout",
                 muscleGroup: .core, sets: 3, reps: "10–12",
                 restSeconds: 90,
                 instructions: "From knees, roll forward keeping core tight, roll back.",
                 difficulty: .intermediate),
    ]

    static let coreAdvanced: [Exercise] = [
        Exercise(name: "Dragon Flag",
                 muscleGroup: .core, sets: 4, reps: "6–8",
                 restSeconds: 90,
                 instructions: "Lying on bench, raise straight body up and lower controlled.",
                 difficulty: .advanced),
        Exercise(name: "Hanging Leg Raise (Straight Leg)",
                 muscleGroup: .core, sets: 4, reps: "10–12",
                 restSeconds: 90,
                 instructions: "Hang from bar, raise straight legs to parallel or higher.",
                 difficulty: .advanced),
        Exercise(name: "Pallof Press",
                 muscleGroup: .core, sets: 3, reps: "12–15",
                 restSeconds: 60,
                 instructions: "Stand perpendicular to cable, press out and resist rotation.",
                 difficulty: .advanced),
    ]

    // MARK: Cardio

    static let cardio: [Exercise] = [
        Exercise(name: "Treadmill Walk/Jog",
                 muscleGroup: .cardio, sets: 1, reps: "20–30 min",
                 restSeconds: 0,
                 instructions: "Moderate pace; aim to keep heart rate at 60–70% max.",
                 difficulty: .beginner),
        Exercise(name: "Cycling (Stationary Bike)",
                 muscleGroup: .cardio, sets: 1, reps: "20–30 min",
                 restSeconds: 0,
                 instructions: "Maintain moderate resistance, steady cadence.",
                 difficulty: .beginner),
        Exercise(name: "Jump Rope",
                 muscleGroup: .cardio, sets: 5, reps: "1 min on / 30 sec off",
                 restSeconds: 30,
                 instructions: "Keep knees soft; land on balls of feet.",
                 difficulty: .intermediate),
        Exercise(name: "HIIT Sprint Intervals",
                 muscleGroup: .cardio, sets: 8, reps: "20 sec sprint / 40 sec walk",
                 restSeconds: 40,
                 instructions: "Sprint at 90% effort, recover at walking pace.",
                 difficulty: .advanced),
        Exercise(name: "Rowing Machine",
                 muscleGroup: .cardio, sets: 1, reps: "20 min",
                 restSeconds: 0,
                 instructions: "Drive with legs first, lean back slightly, pull to lower chest.",
                 difficulty: .intermediate),
    ]

    // MARK: - Lookup helpers

    static func exercises(for muscleGroup: MuscleGroup, level: TrainingLevel) -> [Exercise] {
        switch (muscleGroup, level) {
        case (.chest, .beginner):       return chestBeginner
        case (.chest, .intermediate):   return chestIntermediate
        case (.chest, .advanced):       return chestAdvanced
        case (.back, .beginner):        return backBeginner
        case (.back, .intermediate):    return backIntermediate
        case (.back, .advanced):        return backAdvanced
        case (.shoulders, .beginner):   return shouldersBeginner
        case (.shoulders, .intermediate): return shouldersIntermediate
        case (.shoulders, .advanced):   return shouldersAdvanced
        case (.biceps, .beginner):      return bicepsBeginner
        case (.biceps, .intermediate):  return bicepsIntermediate
        case (.biceps, .advanced):      return bicepsAdvanced
        case (.triceps, .beginner):     return tricepsBeginner
        case (.triceps, .intermediate): return tricepsIntermediate
        case (.triceps, .advanced):     return tricepsAdvanced
        case (.legs, .beginner):        return legsBeginner
        case (.legs, .intermediate):    return legsIntermediate
        case (.legs, .advanced):        return legsAdvanced
        case (.core, .beginner):        return coreBeginner
        case (.core, .intermediate):    return coreIntermediate
        case (.core, .advanced):        return coreAdvanced
        case (.cardio, _):              return cardio
        default:                        return []
        }
    }
}
