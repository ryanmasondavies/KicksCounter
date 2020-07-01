import SwiftUI

struct AppState: Codable {
    var kicks: [Kick] = []
}

struct ContentView: View {
    @ObservedObject var appStateStore: AppStateStore
 
    var body: some View {
        TabView {
            KicksView(appState: $appStateStore.appState)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Today")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appStateStore: AppStateStore()).accentColor(Color("Accent"))
    }
}
