import XCTest
@testable import GymApp

// MARK: - Routine Generator Tests

final class RoutineGeneratorTests: XCTestCase {

    // MARK: Single-Muscle Plan

    func testSingleMusclePlanHasSevenDays() {
        let profile = makeProfile(preference: .singleMuscle)
        let plan = RoutineGenerator.generate(for: profile)
        XCTAssertEqual(plan.days.count, 7)
    }

    func testSingleMusclePlanLastDayIsRest() {
        let profile = makeProfile(preference: .singleMuscle)
        let plan = RoutineGenerator.generate(for: profile)
        XCTAssertTrue(plan.days.last?.isRestDay == true)
    }

    func testSingleMusclePlanName() {
        let profile = makeProfile(preference: .singleMuscle)
        let plan = RoutineGenerator.generate(for: profile)
        XCTAssertFalse(plan.planName.isEmpty)
    }

    func testSingleMuscleActiveDaysHaveExercises() {
        let profile = makeProfile(preference: .singleMuscle)
        let plan = RoutineGenerator.generate(for: profile)
        let activeDays = plan.days.filter { !$0.isRestDay }
        for day in activeDays {
            XCTAssertFalse(day.exercises.isEmpty, "\(day.dayName) has no exercises")
        }
    }

    // MARK: Two-Muscles Plan (PPL)

    func testTwoMusclesPlanHasSevenDays() {
        let profile = makeProfile(preference: .twoMuscles)
        let plan = RoutineGenerator.generate(for: profile)
        XCTAssertEqual(plan.days.count, 7)
    }

    func testTwoMusclesPlanHasOneRestDay() {
        let profile = makeProfile(preference: .twoMuscles)
        let plan = RoutineGenerator.generate(for: profile)
        let restDays = plan.days.filter(\.isRestDay)
        XCTAssertEqual(restDays.count, 1)
    }

    func testTwoMusclesPlanActiveDaysHaveExercises() {
        for level in TrainingLevel.allCases {
            let profile = makeProfile(preference: .twoMuscles, level: level)
            let plan = RoutineGenerator.generate(for: profile)
            let activeDays = plan.days.filter { !$0.isRestDay }
            for day in activeDays {
                XCTAssertFalse(day.exercises.isEmpty, "\(level) \(day.dayName) has no exercises")
            }
        }
    }

    // MARK: Full-Body Plan

    func testFullBodyPlanHasSevenDays() {
        let profile = makeProfile(preference: .multipleMuscles)
        let plan = RoutineGenerator.generate(for: profile)
        XCTAssertEqual(plan.days.count, 7)
    }

    func testFullBodyPlanHasThreeRestDays() {
        let profile = makeProfile(preference: .multipleMuscles)
        let plan = RoutineGenerator.generate(for: profile)
        let restDays = plan.days.filter(\.isRestDay)
        XCTAssertEqual(restDays.count, 3)
    }

    // MARK: Level variations

    func testAllLevelsAndPreferencesProducePlans() {
        for level in TrainingLevel.allCases {
            for preference in MuscleTrainingPreference.allCases {
                let profile = makeProfile(preference: preference, level: level)
                let plan = RoutineGenerator.generate(for: profile)
                XCTAssertFalse(plan.planName.isEmpty)
                XCTAssertEqual(plan.days.count, 7)
            }
        }
    }

    func testGoalIsPreservedInPlan() {
        for goal in FitnessGoal.allCases {
            let profile = makeProfile(preference: .twoMuscles, goal: goal)
            let plan = RoutineGenerator.generate(for: profile)
            XCTAssertEqual(plan.goal, goal)
        }
    }

    // MARK: Exercise Database

    func testChestBeginnerExercisesNotEmpty() {
        let exercises = ExerciseDatabase.exercises(for: .chest, level: .beginner)
        XCTAssertFalse(exercises.isEmpty)
    }

    func testAllMuscleGroupsHaveExercisesForAllLevels() {
        let groups: [MuscleGroup] = [.chest, .back, .shoulders, .biceps, .triceps, .legs, .core]
        for group in groups {
            for level in TrainingLevel.allCases {
                let exercises = ExerciseDatabase.exercises(for: group, level: level)
                XCTAssertFalse(exercises.isEmpty, "\(group.rawValue) / \(level.rawValue) is empty")
            }
        }
    }

    // MARK: Helpers

    private func makeProfile(
        preference: MuscleTrainingPreference = .twoMuscles,
        level: TrainingLevel = .beginner,
        goal: FitnessGoal = .gainWeight
    ) -> UserProfile {
        let p = UserProfile()
        p.musclePreference = preference
        p.trainingLevel    = level
        p.goal             = goal
        return p
    }
}

// MARK: - Diet Plan Generator Tests

final class DietPlanGeneratorTests: XCTestCase {

    func testGainWeightPlanHasHigherCalories() {
        let gainProfile = makeProfile(goal: .gainWeight)
        let loseProfile = makeProfile(goal: .loseWeight)
        let gainPlan = DietPlanGenerator.generate(for: gainProfile)
        let losePlan = DietPlanGenerator.generate(for: loseProfile)
        XCTAssertGreaterThan(gainPlan.dailyCalories, losePlan.dailyCalories)
    }

    func testAllGoalsProduceMeals() {
        for goal in FitnessGoal.allCases {
            let plan = DietPlanGenerator.generate(for: makeProfile(goal: goal))
            XCTAssertFalse(plan.meals.isEmpty, "\(goal.rawValue) has no meals")
        }
    }

    func testPlanCaloriesArePositive() {
        for goal in FitnessGoal.allCases {
            let plan = DietPlanGenerator.generate(for: makeProfile(goal: goal))
            XCTAssertGreaterThan(plan.dailyCalories, 0)
        }
    }

    func testPlanProteinIsPositive() {
        for goal in FitnessGoal.allCases {
            let plan = DietPlanGenerator.generate(for: makeProfile(goal: goal))
            XCTAssertGreaterThan(plan.proteinGrams, 0)
        }
    }

    func testPlanHasTips() {
        for goal in FitnessGoal.allCases {
            let plan = DietPlanGenerator.generate(for: makeProfile(goal: goal))
            XCTAssertFalse(plan.tips.isEmpty, "\(goal.rawValue) has no tips")
        }
    }

    func testPlanNameIsNotEmpty() {
        for goal in FitnessGoal.allCases {
            let plan = DietPlanGenerator.generate(for: makeProfile(goal: goal))
            XCTAssertFalse(plan.planName.isEmpty)
        }
    }

    func testGoalIsPreservedInDietPlan() {
        for goal in FitnessGoal.allCases {
            let plan = DietPlanGenerator.generate(for: makeProfile(goal: goal))
            XCTAssertEqual(plan.goal, goal)
        }
    }

    func testHydrationIsPositive() {
        for goal in FitnessGoal.allCases {
            let plan = DietPlanGenerator.generate(for: makeProfile(goal: goal))
            XCTAssertGreaterThan(plan.hydrationLitres, 0)
        }
    }

    // MARK: User Profile Tests

    func testUserProfileBMICalculation() {
        let profile = UserProfile()
        profile.weightKg = 70
        profile.heightCm = 175
        let expectedBMI = 70 / (1.75 * 1.75)
        XCTAssertEqual(profile.bmi, expectedBMI, accuracy: 0.01)
    }

    func testUserProfileIsCompleteWhenNameIsSet() {
        let profile = UserProfile()
        profile.name = "Test User"
        profile.age = 25
        XCTAssertTrue(profile.isProfileComplete)
    }

    func testUserProfileIsIncompleteWithEmptyName() {
        let profile = UserProfile()
        profile.name = ""
        XCTAssertFalse(profile.isProfileComplete)
    }

    func testUserProfileReset() {
        let profile = UserProfile()
        profile.name = "Alex"
        profile.age = 30
        profile.goal = .loseWeight
        profile.reset()
        XCTAssertEqual(profile.name, "")
        XCTAssertEqual(profile.age, 20)
        XCTAssertEqual(profile.goal, .gainWeight)
    }

    // MARK: Helpers

    private func makeProfile(goal: FitnessGoal = .gainWeight) -> UserProfile {
        let p = UserProfile()
        p.name       = "Test"
        p.age        = 25
        p.weightKg   = 75
        p.heightCm   = 175
        p.goal       = goal
        return p
    }
}
