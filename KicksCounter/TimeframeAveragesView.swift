import SwiftUI

struct TimeframeAveragesView: View {
    @Binding var appState: AppState
    let numberOfDays: Int

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 4) {
                ForEach(Timeframe.allCases, id: \.self) {
                    KickSummaryCard(timeframe: $0, date: Date(), kicks: self.$appState.kicks)
                }
            }
        }
        .navigationBarTitle("\(numberOfDays) Day Average")
    }
}

struct TimeframeAveragesView_Previews: PreviewProvider {
    static var previews: some View {
        TimeframeAveragesView(appState: .constant(AppState(kicks: .randomized())), numberOfDays: 2)
    }
}
