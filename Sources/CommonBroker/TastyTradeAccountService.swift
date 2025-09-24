import TastyTradeLib

public struct TastyTradeAccountService: AccountService {
  private let client: TastyTradeClient

  public init(client: TastyTradeClient = .init()) {
    self.client = client
  }

  public func accountNumbers() async throws -> [String] {
    try await client.fetchAccounts()
  }
}
