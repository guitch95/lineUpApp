import SwiftUI
import Playgrounds

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Programme", systemImage: "list.bullet") {
                ProgramView()
            }

            Tab("Planning", systemImage: "calendar") {
                PlanningView()
            }

            Tab("Favoris", systemImage: "heart.fill") {
                FavorisView()
            }

            Tab("Profile", systemImage: "person.fill") {
                ProfileView()
            }
        }
        .tint(.redBtn)
    }
}

#Preview {
    ContentView()
}

