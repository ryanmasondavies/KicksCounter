import SwiftUI

struct TodayView: View {
    @Binding var appState: AppState
    @State var showHistory = false

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center, spacing: 24) {
                Spacer()
                KicksView(appState: $appState, date: Date(), showAdd: true)
                NavigationLink(destination: HistoryView(appState: $appState), isActive: $showHistory) {
                    Text("History")
                }
            }
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView(appState: .constant(AppState()))
    }
}
