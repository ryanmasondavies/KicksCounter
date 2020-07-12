import SwiftUI

struct TimeframeAveragesView: View {
    @Binding var appState: AppState

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 4) {
                ForEach(Timeframe.allCases, id: \.self) {
                    KickSummaryCard(timeframe: $0, date: Date(), kicks: self.$appState.kicks)
                }
            }
        }
    }
}

struct TimeframeAveragesView_Previews: PreviewProvider {
    static var previews: some View {
        TimeframeAveragesView(appState: .constant(AppState(kicks: .randomized())))
    }
}
