import Testing

@testable import CommonBroker

@Test
func capabilityMatrix() async throws {
  let expected: [Broker: Set<BrokerageService>] = [
    .schwab: [.auth, .account, .secret, .quote, .optionQuote, .watchlist],
    .tradier: [
      .auth,
      .account,
      .secret,
      .quote,
      .quoteVariants,
      .options,
      .optionQuote,
      .optionGreeks,
      .market,
      .profile,
      .positions,
      .activity,
      .order,
      .orders,
      .reference,
      .watchlist,
      .optionStreaming,
      .positionStreaming,
    ],
    .public: [.auth, .account, .secret, .quote, .optionQuote],
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
