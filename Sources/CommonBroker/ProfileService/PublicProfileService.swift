import Foundation
import PublicLib

public struct PublicProfileService: CommonProfileService, Sendable {
  public nonisolated let serviceName: String = "Public"
  public nonisolated let serviceType: ServiceType = .production
  private let client: PublicClient

  public init(client: PublicClient) { self.client = client }

  public func userProfile() async throws -> CommonUserProfile {
    // PublicClient currently exposes accounts; no explicit user profile in this client.
    .init(id: nil, name: nil, email: nil)
  }

  public func accountProfile(for accountId: String) async throws -> CommonAccountProfile {
    // Derive from accounts list when possible
    let accounts: [PublicLib.Account] = try await client.fetchAccounts()
    if let a = accounts.first(where: { $0.accountId == accountId }) {
      let levelStr = a.optionsLevel.rawValue
      let optionLevel: Int? = Int(levelStr.split(separator: "_").last ?? "")
      return .init(
        accountId: a.accountId,
        status: nil,
        classification: nil,
        displayName: "Public \(a.accountId)",
        accountType: a.accountType.rawValue,
        optionLevel: optionLevel,
        dayTrader: nil,
        lastUpdated: nil,
        email: nil,
        phone: nil,
        address: nil,
      )
    }
    return .init(
      accountId: accountId,
      status: nil,
      classification: nil,
      displayName: "Public \(accountId)",
      accountType: nil,
      optionLevel: nil,
      dayTrader: nil,
      lastUpdated: nil,
      email: nil,
      phone: nil,
      address: nil,
    )
  }

  public func accountBalances(for accountId: String) async throws -> CommonAccountBalance {
    // Use Portfolio snapshot to derive balances and buying power (string → Double)
    let p: PublicLib.Portfolio = try await client.fetchPortfolio(for: accountId)
    func d(_ s: String?) -> Double? { s.flatMap(Double.init) }
    let totalEquity: Double? = p.equity.compactMap { Double($0.value) }.reduce(0, +)
    let stockMV: Double? = p.equity
      .first(where: { $0.type == .stock })
      .flatMap { Double($0.value) }
    let optionsLongMV: Double? = p.equity
      .first(where: { $0.type == .optionsLong })
      .flatMap { Double($0.value) }
    let optionsShortMV: Double? = p.equity
      .first(where: { $0.type == .optionsShort })
      .flatMap { Double($0.value) }
    let cashValue: Double? = p.equity
      .first(where: { $0.type == .cash })
      .flatMap { Double($0.value) }
    return .init(
      accountNumber: p.accountId,
      accountType: p.accountType.rawValue,
      totalCash: cashValue,
      totalEquity: totalEquity,
      longMarketValue: (stockMV ?? 0) + (optionsLongMV ?? 0),
      shortMarketValue: optionsShortMV,
      closePl: nil,
      openPl: nil,
      pendingOrdersCount: nil,
      fedCall: nil,
      maintenanceCall: nil,
      stockBuyingPower: d(p.buyingPower.buyingPower),
      optionBuyingPower: d(p.buyingPower.optionsBuyingPower),
      cashAvailable: d(p.buyingPower.cashOnlyBuyingPower),
      unsettledFunds: nil,
      sweep: nil,
    )
  }
}
