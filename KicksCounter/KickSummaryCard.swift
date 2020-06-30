import SwiftUI

enum Timeframe: CaseIterable, CustomStringConvertible {
    case morning
    case midMorning
    case afternoon
    case earlyEvening
    case evening
    case lateEvening

    var description: String {
        switch self {
        case .morning:
            return "4am - 8am"
        case .midMorning:
            return "8am - 12pm"
        case .afternoon:
            return "12pm - 4pm"
        case .earlyEvening:
            return "4pm - 8pm"
        case .evening:
            return "8pm - 12am"
        case .lateEvening:
            return "12am - 4am"
        }
    }
}

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
        KickSummaryCard(timeframe: .morning)
    }
}
