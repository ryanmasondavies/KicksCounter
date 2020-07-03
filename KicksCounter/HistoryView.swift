import SwiftUI

func distinctDays(in dates: [Date], calendar: Calendar = .current) -> [Date] {
    struct JustDate: Hashable {
        let year: Int
        let month: Int
        let day: Int
    }
    let days: Set<JustDate> = Set(dates.map {
        JustDate(year: calendar.component(.year, from: $0), month: calendar.component(.month, from: $0), day: calendar.component(.day, from: $0))
    })
    return days.map {
        calendar.date(from: .init(year: $0.year, month: $0.month, day: $0.day))
    }.compactMap { $0 }
}

struct HistoryView: View {
    @Binding var kicks: [Kick]

    private var days: [Date] {
        distinctDays(in: kicks.map(\.date)).sorted(by: >)
    }

    var body: some View {
        VStack(alignment: .center) {
            ForEach(days, id: \.self) { date in
                DayCard(date: date, kicks: self.$kicks)
            }
        }
        .navigationBarTitle("History")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(kicks: .constant([]))
    }
}
