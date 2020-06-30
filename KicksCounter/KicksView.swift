import SwiftUI

struct KicksView: View {
    @Binding var appState: AppState

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .center, spacing: 32) {
                    Text("Kicks Today")
                        .font(.largeTitle)
                        .fontWeight(.bold)

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
                                    .foregroundColor(.accentColor)
                                    .font(.largeTitle)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(Timeframe.allCases, id: \.self) {
                            KickSummaryCard(timeframe: $0)
                        }
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
