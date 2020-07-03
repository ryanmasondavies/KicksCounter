import SwiftUI

struct ContentView: View {
    @ObservedObject var appStateStore: AppStateStore
 
    var body: some View {
        NavigationView {
            TodayView(appState: $appStateStore.appState)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appStateStore: AppStateStore()).accentColor(Color("Accent"))
    }
}
