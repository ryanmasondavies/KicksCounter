import SwiftUI

let shortDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    formatter.locale = Locale(identifier: "en_GB")
    return formatter
}()

struct KicksView: View {
    @Binding var appState: AppState

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center, spacing: 32) {
                Spacer()

                VStack(alignment: .center, spacing: 8) {
                    Text("Kicks Today")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("\(shortDateFormatter.string(from: Date()))")
                        .font(.body)
                }

                VStack(alignment: .center, spacing: 32) {
                    ZStack {
                        Circle()
                            .foregroundColor(Color("KicksCounter"))
                        Text("\(appState.kicks.count)")
                            .font(.largeTitle)
                            .padding(40)
                    }

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

                VStack(alignment: .leading, spacing: 4) {
                    ForEach(Timeframe.allCases, id: \.self) {
                        KickSummaryCard(timeframe: $0, kicks: self.$appState.kicks)
                    }
                }
            }
        }
    }
}

struct KicksView_Previews: PreviewProvider {
    static var previews: some View {
        KicksView(appState: .constant(AppState(kicks: [])))
    }
}
