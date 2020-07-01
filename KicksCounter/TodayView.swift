import SwiftUI

struct TodayView: View {
    @Binding var appState: AppState

    var body: some View {
        KicksView(appState: $appState, date: Date(), showAdd: true)
    }
}
