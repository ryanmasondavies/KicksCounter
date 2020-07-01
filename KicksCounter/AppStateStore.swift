import Combine
import Foundation

final class AppStateStore: ObservableObject {
    @Published var appState = AppState()
}
