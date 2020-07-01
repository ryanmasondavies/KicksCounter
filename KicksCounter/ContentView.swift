import SwiftUI

struct ContentView: View {
    @ObservedObject var appStateStore: AppStateStore
 
    var body: some View {
        TabView {
            KicksView(appState: $appStateStore.appState, date: Date(), showAdd: true)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Today")
                }
            HistoryView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("History")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appStateStore: AppStateStore()).accentColor(Color("Accent"))
    }
}
