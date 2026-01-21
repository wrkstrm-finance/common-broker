import PublicLib
import SchwabLib
import TastyTradeLib
import TradierLib
import WrkstrmFoundation
import CommonLog
import WrkstrmMain

public typealias BrokerageSandboxEnvironment = Tradier.HTTPSSandboxEnvironment

public actor OmniBroker {
  private let quoteService: TradierSandboxQuoteService
  private let accountService: any AccountService
  private let authService: any AuthService

  public init(
    quoteService: TradierSandboxQuoteService = .init(
      environment: BrokerageSandboxEnvironment(),
    ),
    accountService: any AccountService = TastyTradeAccountService(),
    authService: any AuthService = StaticAuthService(),
  ) {
    self.quoteService = quoteService
    self.accountService = accountService
    self.authService = authService
  }

  public func quote(for symbol: String, accountId: String) async throws -> CommonQuoteVariant {
    try await quoteService.quote(for: symbol, accountId: accountId)
  }

  public func accountNumbers() async throws -> [String] {
    try await accountService.accountNumbers()
  }

  public func authenticationStatus() -> AsyncStream<Bool> {
    authService.authenticationStatus()
  }
}
