import Testing

@testable import CommonBroker

@Test
func capabilityMatrix() async throws {
  let expected: [Broker: Set<BrokerageService>] = [
    .schwab: [.auth, .account, .quote, .watchlist],
    .tradier: [.auth, .account, .quote, .greeks, .watchlist, .positionStreaming],
    .public: [.auth, .account, .quote],
    .tastytrade: [.auth, .account],
  ]
  for (broker, services) in expected {
    let caps = BrokerRegistry.capabilities[broker]!
    for service in services {
      #expect(caps.supports(service))
    }
  }
}

@Test
func serviceDelegatesToProvider() async throws {
  struct EchoProvider: ServiceProvider {
    func handle(_ requirement: String) async throws -> String { requirement }
  }
  let service: Service<String, String> = .init(EchoProvider())
  let result = try await service.request("ping")
  #expect(result == "ping")
}
