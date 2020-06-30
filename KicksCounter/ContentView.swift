import SwiftUI

struct Kick {
    let date: Date

    init() {
        self.date = Date()
    }
}

struct AppState {
    var selectedTab: Int
    var kicks: [Kick] = []
}

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            Text("First View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("first")
                        Text("Today")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
