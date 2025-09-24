import CommonBroker
import Foundation
import PublicLib
import Testing
import WrkstrmNetworking

private struct DummyAuthenticator: RequestAuthenticator {
  func accessToken() async throws -> String { "test-token" }
}

private struct MockHTTPClient: HTTPClientSending {
  func send<T>(_ request: T) async throws -> T.ResponseType where T: HTTP.CodableURLRequest {
    switch true {
    case request.path.contains("quotes"):
      // Build response JSON: { "quotes": [ { Quote } ] }
      let quote: [String: Any] = [
        "instrument": ["symbol": "AAPL250117C00180000", "type": "EQUITY"],
        "outcome": "SUCCESS",
        "last": "5.55",
        "bid": "5.50",
        "bidSize": 10,
        "ask": "5.60",
        "askSize": 10,
        "volume": 1234,
        "openInterest": 100,
      ]
      let payload: [String: Any] = ["quotes": [quote]]
      let data = try JSONSerialization.data(withJSONObject: payload)
      let decoded = try JSONDecoder().decode(T.ResponseType.self, from: data)
      return decoded

    case request.path.contains("greeks"):
      let payload: [String: Any] = [
        "delta": "0.55",
        "gamma": "0.10",
        "theta": "-0.03",
        "vega": "0.12",
        "rho": "0.01",
        "impliedVolatility": "0.22",
      ]
      let data = try JSONSerialization.data(withJSONObject: payload)
      let decoded = try JSONDecoder().decode(T.ResponseType.self, from: data)
      return decoded

    default:
      fatalError("Unexpected request: \(type(of: request))")
    }
  }
}

@Test
func public_option_quote_composes_greeks() async throws {
  let http = MockHTTPClient()
  // Inject mock client via PublicClient initializer
  let client = PublicClient(authenticator: DummyAuthenticator(), baseClient: http)

  let svc = PublicOptionQuoteCommonService(client: client)
  let q = try await svc.optionQuote(for: "AAPL250117C00180000", accountId: "acct")

  #expect(q.symbol == "AAPL250117C00180000")
  #expect(q.last == 5.55)
  #expect(q.greeks?.delta == 0.55)
  #expect(q.greeks?.gamma == 0.10)
  #expect(q.greeks?.theta == -0.03)
  #expect(q.greeks?.vega == 0.12)
  #expect(q.greeks?.rho == 0.01)
  #expect(q.greeks?.iv == 0.22)
}
