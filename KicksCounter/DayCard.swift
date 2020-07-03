import SwiftUI

struct DayCard: View {
    let date: Date
    @Binding var kicks: [Kick]

    private var relativeDay: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        formatter.doesRelativeDateFormatting = true
        return formatter.string(from: date)
    }

    private var relativeKicks: [Kick] {
        kicks.filter(byDay: Calendar.current.component(.day, from: date), using: .current)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .foregroundColor(.accentColor)

            HStack(alignment: .center, spacing: 24) {
                Text("Day: \(relativeDay)")
                    .foregroundColor(.white)
                    .font(.headline)
                    .layoutPriority(1)

                Text("\(relativeKicks.count) kicks")
                    .foregroundColor(.white)
                    .font(.headline)
                    .layoutPriority(1)
            }
            .padding(.horizontal, 32)
            .scaledToFit()
        }
    }
}

struct DayCard_Previews: PreviewProvider {
    static var previews: some View {
        DayCard(date: Date(timeIntervalSince1970: 0), kicks: .constant([])).accentColor(Color("Accent"))
    }
}
