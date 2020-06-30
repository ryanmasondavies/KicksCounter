import SwiftUI

struct KicksView: View {
    @Binding var appState: AppState

    var body: some View {
        NavigationView {
            VStack {
                Text("Kicks Today")
                    .font(.title)
                ZStack {
                    Circle()
                        .foregroundColor(.accentColor)
                    Text("\(appState.kicks.count)")
                        .font(.largeTitle)
                }
                .padding(.all, 32)
            }
            .navigationBarTitle("Today")
        }
    }
}

struct KicksView_Previews: PreviewProvider {
    static var previews: some View {
        KicksView(appState: .constant(AppState(selectedTab: 0, kicks: []))).accentColor(Color("Accent"))
    }
}
