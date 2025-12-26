import Foundation
import PublicLib
import WrkstrmMain
import WrkstrmNetworking

public struct PublicOptionQuoteCommonService: CommonOptionQuoteService, Sendable
{
  public nonisolated let serviceName: String = "Public"
  public nonisolated let serviceType: ServiceType = .production

  private let client: PublicClient

  public init(client: PublicClient) { self.client = client }

  public func optionQuote(for symbol: String, accountId: String) async throws
    -> CommonOptionQuote
  {
    let instruments: [Instrument] = [Instrument(symbol: symbol, type: .equity)]

    async let quotesTask: [PublicLib.Quote] = client.fetchQuotes(
      for: accountId,
      instruments: instruments,
    )

    async let greeksTask: PublicClient.OptionGreeks = client.fetchOptionGreeks(
      for: accountId,
      symbol: symbol,
    )

    let quotes = try await quotesTask
    guard let first = quotes.first else {
      throw StringError("No option quote for \(symbol)")
    }
    let base = CommonOptionQuote(first)

    let g = try await greeksTask
    func toDouble(_ s: String?) -> Double? { s.flatMap(Double.init) }
    let mappedGreeks = CommonOptionQuote.Greeks(
      delta: toDouble(g.delta),
      gamma: toDouble(g.gamma),
      theta: toDouble(g.theta),
      vega: toDouble(g.vega),
      rho: toDouble(g.rho),
      iv: toDouble(g.impliedVolatility),
      bidIv: nil,
      midIv: nil,
      askIv: nil,
      updatedAt: nil,
    )
    return base.withGreeks(mappedGreeks)
  }
}
