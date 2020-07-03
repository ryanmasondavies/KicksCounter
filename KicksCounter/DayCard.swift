import SwiftUI

let dayOfMonthFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_GB")
    formatter.setLocalizedDateFormatFromTemplate("MMMMd")
    return formatter
}()

struct DayCard: View {
    let date: Date
    @Binding var kicks: [Kick]

    private var relativeKicks: [Kick] {
        kicks.filter(byDay: Calendar.current.component(.day, from: date), using: .current)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(.accentColor)

            HStack(alignment: .center) {
                Text("\(dayOfMonthFormatter.string(from: date))")
                    .foregroundColor(.white)
                    .font(.headline)
                    .layoutPriority(1)
                Spacer()
                Text("\(relativeKicks.count) kicks")
                    .foregroundColor(.white)
                    .font(.headline)
                    .layoutPriority(1)
            }
            .padding()
        }
    }
}

struct DayCard_Previews: PreviewProvider {
    static var previews: some View {
        DayCard(date: Date(timeIntervalSince1970: 0), kicks: .constant([])).accentColor(Color("Accent"))
    }
}
