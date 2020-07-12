import SwiftUI

struct KickTimeframeAverageCard: View {
    let timeframe: Timeframe
    let date: Date
    let numberOfDays: Int
    @Binding var kicks: [Kick]

    private var averageKicksWithinTimeframe: Int {
        let calendar: Calendar = .current
        let dates = calendar.dates(forPreviousDays: numberOfDays, from: date)
        let kicksForDates = kicks.filter(by: dates, using: calendar)
        let kicksForDatesAndTimeframe = kicksForDates.filter(by: timeframe, using: calendar)
        return Int(Double(kicksForDatesAndTimeframe.count) / Double(numberOfDays))
    }

    var body: some View {
        TimeframeCard(timeframe: timeframe, text: "\(averageKicksWithinTimeframe) kicks")
    }
}

struct KickTimeframeAverageCard_Previews: PreviewProvider {
    static var previews: some View {
        KickTimeframeAverageCard(timeframe: .morning, date: Date(), numberOfDays: 0, kicks: .constant(.randomized()))
    }
}

