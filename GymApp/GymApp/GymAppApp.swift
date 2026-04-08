import SwiftUI

@main
struct GymAppApp: App {
    @StateObject private var userProfile = UserProfile()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userProfile)
        }
    }
}
