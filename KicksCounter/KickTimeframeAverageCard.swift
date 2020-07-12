import SwiftUI

struct KickTimeframeAverageCard: View {
    let timeframe: Timeframe
    let date: Date
    let numberOfDays: Int
    @Binding var kicks: [Kick]

    private var averageKicksWithinTimeframe: [Kick] {
        []
    }

    var body: some View {
        TimeframeCard(timeframe: timeframe, text: "\(averageKicksWithinTimeframe.count) kicks")
    }
}

struct KickTimeframeAverageCard_Previews: PreviewProvider {
    static var previews: some View {
        KickTimeframeAverageCard(timeframe: .morning, date: Date(), numberOfDays: 0, kicks: .constant(.randomized()))
    }
}

