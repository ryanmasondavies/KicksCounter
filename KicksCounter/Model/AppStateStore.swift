import Combine
import Foundation
import WatchConnectivity

final class AppStateStore: ObservableObject {
    @Published var appState: AppState
    private var persistence: AnyCancellable?
    private var transfer: AnyCancellable?

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

        transfer = $appState.sink { appState in
            WCSession.default.transferUserInfo([
                "kicksCount": appState.kicks.count,
            ])
        }

        importPreviousKicksIfNeeded()
    }

    private func importPreviousKicksIfNeeded() {
        let daysAndMonths: [(month: Int, day: Int, kicks: Int)] = [
        ]
        guard !daysAndMonths.isEmpty else {
            return
        }
        let calendar: Calendar = .current
        let kicks = daysAndMonths.map { month, day, kicks -> [Kick]? in
            guard let date = calendar.date(from: DateComponents(calendar: calendar, year: 2020, month: month, day: day, hour: 0, minute: 0, second: 0)) else {
                return nil
            }
            return Array(repeating: Kick(date: date, includesTime: false), count: kicks)
        }.compactMap { $0 }.flatMap { $0 }
        appState.kicks.insert(contentsOf: kicks, at: 0)
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
