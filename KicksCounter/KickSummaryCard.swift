import SwiftUI

func imageSystemName(for timeframe: Timeframe) -> String {
    switch timeframe {
    case .morning:
        return "sunrise.fill"
    case .midMorning:
        return "sun.min.fill"
    case .afternoon:
        return "sun.max.fill"
    case .earlyEvening:
        return "sun.haze.fill"
    case .evening:
        return "moon.zzz.fill"
    case .lateEvening:
        return "moon.stars.fill"
    }
}

func colorName(for timeframe: Timeframe) -> String {
    switch timeframe {
    case .morning:
        return "Morning"
    case .midMorning:
        return "MidMorning"
    case .afternoon:
        return "Afternoon"
    case .earlyEvening:
        return "EarlyEvening"
    case .evening:
        return "Evening"
    case .lateEvening:
        return "LateEvening"
    }
}

struct KickSummaryCard: View {
    let timeframe: Timeframe
    let date: Date
    @Binding var kicks: [Kick]

    var kicksWithinTimeframe: [Kick] {
        kicks.filter(by: timeframe, on: date, using: .current)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(Color(colorName(for: timeframe)))

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

                Text("\(kicksWithinTimeframe.count) kicks")
                    .font(.headline)
                    .layoutPriority(2)
            }
            .padding(.horizontal, 32)
        }
        .padding(.horizontal, 8)
        .frame(minHeight: 64, alignment: .center)
    }
}

struct KickSummaryCard_Previews: PreviewProvider {
    static var previews: some View {
        KickSummaryCard(timeframe: .morning, date: Date(), kicks: .constant([]))
    }
}
