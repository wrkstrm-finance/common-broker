# AGENDA — CommonBroker iOS Engineer

## Near-Term

\- Implement Public-backed Common services and adapters:

- PublicProfileService → CommonProfileService + adapters (user/account/balances)
- PublicPositionsService → CommonPositionsService + adapters (positions/equity)
- PublicActivityService → CommonActivityService + adapters (history, gain/loss)
- PublicOrderService → CommonOrderService/CommonOrdersService + adapters (order result/status)
  \- Add simple factory/registry to select Common\*Service by broker + environment.

## Mid-Term

\- Error handling/retries and lightweight metrics around service calls.

## Long-Term

\- Multi-broker support at feature parity; DocC page describing CommonBroker service matrix.
