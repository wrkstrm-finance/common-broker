import Foundation

/// A lightweight protocol for periodic polling work.
public protocol OmniPollingHandler: Sendable {
  associatedtype ID: Hashable & Sendable
  /// Unique identifier for this polling task (used to de-duplicate).
  var id: ID { get }
  /// Interval in seconds between ticks.
  var interval: TimeInterval { get }
  /// Called every interval. Throwing is allowed; errors are swallowed by the daemon.
  func tick() async throws
}

/// A shared, generic polling daemon that runs handler ticks on a fixed interval.
///
/// Usage:
///   struct MyHandler: PollingHandler { ... }
///   await PollingDaemon<MyHandler>.shared.start(handler)
///   await PollingDaemon<MyHandler>.shared.stop(id: handler.id)
public actor PollingDaemon<Handler: OmniPollingHandler> {
  private var tasks: [Handler.ID: Task<Void, Never>] = [:]

  public init() {}

  /// Starts a polling loop for the given handler if not already running.
  public func start(_ handler: Handler) {
    guard tasks[handler.id] == nil else { return }
    let id = handler.id
    let interval = max(handler.interval, 0.1)
    let task = Task { [interval] in
      while !Task.isCancelled {
        do {
          try await handler.tick()
        } catch {
          // Swallow errors to avoid breaking the loop.
        }
        // Sleep with coarse cancellation support between ticks.
        let ns = UInt64(interval * 1_000_000_000)
        do { try await Task.sleep(nanoseconds: ns) } catch { /* cancelled */  }
      }
    }
    tasks[id] = task
  }

  /// Stops a polling loop for the given handler id, if running.
  public func stop(id: Handler.ID) {
    tasks[id]?.cancel()
    tasks[id] = nil
  }

  /// Stops all polling loops for this handler type.
  public func stopAll() {
    for (_, task) in tasks {
      task.cancel()
    }
    tasks.removeAll()
  }

  /// Returns whether a loop is currently active for the given id.
  public func isRunning(id: Handler.ID) -> Bool { tasks[id] != nil }
}

/// Non-generic registry that provides a shared PollingDaemon per handler type.
public actor PollingRegistry {
  public static let shared = PollingRegistry()
  private var store: [ObjectIdentifier: Any] = [:]

  public func daemon<H: OmniPollingHandler>(for _: H.Type = H.self) -> PollingDaemon<H> {
    let key = ObjectIdentifier(H.self)
    if let existing = store[key] as? PollingDaemon<H> { return existing }
    let created = PollingDaemon<H>()
    store[key] = created
    return created
  }
}
