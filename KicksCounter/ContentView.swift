import SwiftUI

struct Kick {
    let date: Date

    init() {
        self.date = Date()
    }
}

struct AppState {
    var kicks: [Kick] = []
}

struct ContentView: View {
    @ObservedObject var appStateStore: AppStateStore
 
    var body: some View {
        KicksView(appState: $appStateStore.appState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appStateStore: AppStateStore()).accentColor(Color("Accent"))
    }
}
