import SwiftUI

@main struct LineUpApp: App {
    @State private var authService = AuthService()
    @State private var favoriteService = FavoriteService()

    var body: some Scene {
        WindowGroup {
            Group {
                if authService.isRestoringSession {
                    ProgressView()
                } else if authService.isLoggedIn{
                    ContentView()
                } else {
                    MainView()
                }
            }
            .environment(authService)
            .environment(favoriteService)
            .task {
                await authService.restoreSession()  // if valid token in UserDefault user is connected nothing authentification
            }
        }
    }
}
