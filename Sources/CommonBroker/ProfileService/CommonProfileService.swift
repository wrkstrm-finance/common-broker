import Foundation

public protocol CommonProfileService: CommonService {
  func userProfile() async throws -> CommonUserProfile
  func accountProfile(for accountId: String) async throws -> CommonAccountProfile
  func accountBalances(for accountId: String) async throws -> CommonAccountBalance
}
