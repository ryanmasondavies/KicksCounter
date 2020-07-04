import SwiftUI

struct KicksView: View {
    @Binding var appState: AppState
    let date: Date
    let showAdd: Bool

    private var kicks: [Kick] {
        appState.kicks.filter(byDay: Calendar.current.component(.day, from: date), using: .current)
    }

    private var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }

    private var title: String {
        if isToday {
            return "Kicks Today"
        } else {
            return dayOfMonthFormatter.string(from: date)
        }
    }

    private var shouldShowTimeframes: Bool {
        let anyKicksIncludeTime = !kicks.filter({ $0.includesTime }).isEmpty
        return anyKicksIncludeTime || isToday
    }

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)

            if shouldShowTimeframes {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(Timeframe.allCases, id: \.self) {
                        KickSummaryCard(timeframe: $0, date: self.date, kicks: self.$appState.kicks)
                    }
                }
            }

            VStack(alignment: .center, spacing: 32) {
                ZStack {
                    Circle()
                        .foregroundColor(Color("KicksCounter"))
                    Text("\(kicks.count)")
                        .font(.largeTitle)
                        .padding(40)
                }

                if showAdd {
                    ZStack {
                        Button(action: {
                            self.appState.kicks.append(Kick())
                        }) {
                            Image(systemName: "plus.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 50, alignment: .center)
                                .foregroundColor(Color("AddKick"))
                                .font(.largeTitle)
                        }
                    }
                }
            }
        }
    }
}

struct KicksView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            KicksView(appState: .constant(AppState(kicks: [])), date: Date(), showAdd: true)
            KicksView(appState: .constant(AppState(kicks: [])), date: Date(), showAdd: false)
        }
    }
}
