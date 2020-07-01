import Combine
import Foundation

final class AppStateStore: ObservableObject {
    @Published var appState: AppState
    private var persistence: AnyCancellable?

    init() {
        do {
            appState = try AppStateStore.load()
        }
        catch {
            appState = AppState()
        }

        persistence = $appState.sink(receiveValue: { appState in
            do {
                try AppStateStore.save(appState: appState)
            }
            catch {
                print("Failed to save: \(error)")
            }
            self.objectWillChange.send()
        })
    }

    private static func fileURL() throws -> URL {
        let documentsDirectoryURL = try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )
        return documentsDirectoryURL.appendingPathComponent("app_state.json")
    }

    private static func load() throws -> AppState {
        let data = try Data(contentsOf: try fileURL())
        return try JSONDecoder().decode(AppState.self, from: data)
    }

    static func save(appState: AppState) throws {
        let data = try JSONEncoder().encode(appState)
        try data.write(to: try fileURL())
    }
}
