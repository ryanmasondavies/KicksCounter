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
    @State var appState: AppState
 
    var body: some View {
        TabView(selection: $appState.selectedTab){
            KicksView(appState: $appState)
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
        ContentView(appState: AppState(selectedTab: 0, kicks: [Kick(), Kick()])).accentColor(Color("Accent"))
    }
}

struct KicksView: View {
    @Binding var appState: AppState

    var body: some View {
        NavigationView {
            VStack {
                Text("Kicks Today")
                    .font(.title)
                ZStack {
                    Circle()
                        .foregroundColor(.accentColor)
                    Text("\(appState.kicks.count)")
                        .font(.largeTitle)
                }
                .padding(.all, 32)
            }
            .navigationBarTitle("Today")
        }
    }
}
