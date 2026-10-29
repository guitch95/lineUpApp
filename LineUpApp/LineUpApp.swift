import SwiftUI

@main struct LineUpApp: App {
    @State private var authService = AuthService()

    var body: some Scene {
        WindowGroup {
            Group {
                if authService.isLoggedIn {
                    ContentView()
                } else {
                    MainView()
                }
            }
            .environment(authService)
            .task {
                await authService.restoreSession()  // if valid token in UserDefault user is connected nothing authentification
            }
        }
    }
}
