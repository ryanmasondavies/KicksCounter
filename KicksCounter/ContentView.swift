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
    @State var appState: AppState
 
    var body: some View {
        KicksView(appState: $appState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appState: AppState(kicks: [Kick(), Kick()])).accentColor(Color("Accent"))
    }
}
