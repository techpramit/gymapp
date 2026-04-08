import SwiftUI

enum AppScreen {
    case welcome
    case onboarding
    case results
}

struct ContentView: View {
    @EnvironmentObject var userProfile: UserProfile
    @State private var currentScreen: AppScreen = .welcome

    var body: some View {
        Group {
            switch currentScreen {
            case .welcome:
                WelcomeView {
                    currentScreen = .onboarding
                }
            case .onboarding:
                OnboardingContainerView(
                    onComplete: { currentScreen = .results },
                    onBack: { currentScreen = .welcome }
                )
            case .results:
                ResultsTabView {
                    userProfile.reset()
                    currentScreen = .welcome
                }
            }
        }
        .animation(.easeInOut, value: currentScreen)
    }
}

#Preview {
    ContentView()
        .environmentObject(UserProfile())
}
