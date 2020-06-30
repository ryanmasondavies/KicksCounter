import SwiftUI

enum SummaryTimeframe: CaseIterable, CustomStringConvertible {
    case earlyMorningToMorning
    case morningToNoon
    case noonToAfternoon
    case afternoonToEvening
    case eveningToMidnight
    case midnightToEarlyMorning

    var description: String {
        switch self {
        case .earlyMorningToMorning:
            return "4am - 8am"
        case .morningToNoon:
            return "8am - 12pm"
        case .noonToAfternoon:
            return "12pm - 4pm"
        case .afternoonToEvening:
            return "4pm - 8pm"
        case .eveningToMidnight:
            return "8pm - 12am"
        case .midnightToEarlyMorning:
            return "12am - 4am"
        }
    }
}

func imageSystemName(for timeframe: SummaryTimeframe) -> String {
    switch timeframe {
    case .earlyMorningToMorning:
        return "sunrise.fill"
    case .morningToNoon:
        return "sun.min.fill"
    case .noonToAfternoon:
        return "sun.max.fill"
    case .afternoonToEvening:
        return "sun.haze.fill"
    case .eveningToMidnight:
        return "moon.zzz.fill"
    case .midnightToEarlyMorning:
        return "moon.stars.fill"
    }
}

struct KickSummaryCard: View {
    let timeframe: SummaryTimeframe

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(.accentColor)

            HStack(alignment: .center, spacing: 24) {
                Image(systemName: imageSystemName(for: timeframe))
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .frame(idealWidth: 32, alignment: .center)
                    .foregroundColor(.yellow)
                    .layoutPriority(1)

                Text(timeframe.description)
                    .font(.headline)
                    .fontWeight(.bold)
                    .layoutPriority(2)

                Spacer()
                    .layoutPriority(1)

                Text("3 kicks")
                    .font(.headline)
                    .layoutPriority(2)
            }
            .padding(.horizontal, 32)
            .scaledToFit()
        }
        .padding(.horizontal, 8)
        .frame(minHeight: 64, alignment: .center)
    }
}

struct KickSummaryCard_Previews: PreviewProvider {
    static var previews: some View {
        KickSummaryCard(timeframe: .earlyMorningToMorning)
    }
}
