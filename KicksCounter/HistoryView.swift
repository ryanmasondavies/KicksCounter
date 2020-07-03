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
        calendar.date(from: .init(calendar: calendar, year: $0.year, month: $0.month, day: $0.day))
    }.compactMap { $0 }
}

struct HistoryDayView: View {
    @Binding var appState: AppState
    let date: Date

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            KicksView(appState: self.$appState, date: date, showAdd: false)
        }
    }
}

struct HistoryView: View {
    @Binding var appState: AppState
    @State var showingDay = false

    private var days: [Date] {
        distinctDays(in: appState.kicks.map(\.date)).sorted(by: >)
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center) {
                ForEach(days, id: \.self) { date in
                    NavigationLink(destination: HistoryDayView(appState: self.$appState, date: date)) {
                        DayCard(date: date, kicks: self.$appState.kicks)
                    }
                }
            }
            .padding(.horizontal, 8)
        }
        .navigationBarTitle("History")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(appState: .constant(AppState()))
    }
}
