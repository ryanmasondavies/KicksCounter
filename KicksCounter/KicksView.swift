import SwiftUI

struct KicksView: View {
    @Binding var appState: AppState

    var body: some View {
        NavigationView {
            VStack {
                Text("Kicks Today")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .layoutPriority(0)

                VStack {
                    ZStack {
                        Circle()
                            .foregroundColor(.accentColor)
                        Text("\(appState.kicks.count)")
                            .font(.largeTitle)
                    }
                    .padding(.all, 32)
                    .layoutPriority(2)

                    ZStack {
                        Button(action: {
                            self.appState.kicks.append(Kick())
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.accentColor)
                                .font(.largeTitle)
                        }
                    }
                }
                .layoutPriority(0)

                Spacer()
                    .layoutPriority(0)
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(SummaryTimeframe.allCases, id: \.self) {
                        KickSummaryCard(timeframe: $0)
                    }
                }
            }
        }
    }
}

struct KicksView_Previews: PreviewProvider {
    static var previews: some View {
        KicksView(appState: .constant(AppState(selectedTab: 0, kicks: []))).accentColor(Color("Accent"))
    }
}
