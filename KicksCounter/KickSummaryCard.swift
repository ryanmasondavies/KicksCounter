import SwiftUI

struct KickSummaryCard: View {
    let timeframe: Timeframe
    let date: Date
    @Binding var kicks: [Kick]

    var kicksWithinTimeframe: [Kick] {
        kicks.filter(by: timeframe, on: date, using: .current)
    }

    var body: some View {
        TimeframeCard(timeframe: timeframe, text: "\(kicksWithinTimeframe.count) kicks")
    }
}

struct KickSummaryCard_Previews: PreviewProvider {
    static var previews: some View {
        KickSummaryCard(timeframe: .morning, date: Date(), kicks: .constant([]))
    }
}
