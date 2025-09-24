# CommonBroker — TODOs

These TODOs track near-term work to complete Public-backed services and the broker service matrix.

- [ ] Public-backed CommonProfileService
  - [ ] Implement service using PublicLib (user profile, account profile, balances)
  - [ ] Add adapters: Public → CommonUserProfile/CommonAccountProfile/CommonAccountBalance
  - [ ] Unit tests with stubbed clients/fixtures

- [ ] Public-backed CommonPositionsService
  - [ ] Implement service using PublicLib (portfolio/positions)
  - [ ] Add adapters: Public → Common positions/equity models
  - [ ] Unit tests

- [ ] Public-backed CommonActivityService
  - [ ] Implement service using PublicLib (history; gain/loss if available)
  - [ ] Add adapters: Public → CommonActivityEvent/CommonClosedPosition
  - [ ] Unit tests

- [ ] Public-backed CommonOrderService/CommonOrdersService
  - [ ] Implement service using PublicLib (place/fetch/cancel; open orders if supported)
  - [ ] Add adapters: Public → CommonOrderResult/CommonOrder
  - [ ] Unit tests

- [ ] ServiceRegistry / Factory
  - [ ] Select Common\* services by broker + environment (sandbox/production)
  - [ ] Minimal defaults + injection points for apps

- [ ] Docs
  - [ ] Add/maintain CommonBroker DocC with Service Matrix
  - [ ] Document adapter normalization rules (units, timestamps, naming)

- [ ] CI / QA
  - [ ] Fixture-driven tests for Public-backed services
  - [ ] Smoke wiring in example app
