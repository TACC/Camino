# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.7.1] - 2023-03-02: Fix CMS uWSGI buffer size

### Fixed

- Bump uWSGI buffer size on CMS pages (#29)


## [2.7.0] - 2022-12-15: Parameterized nginx server_name

### Changed

- FP-1947: Parameterized nginx server_name (#24)

## [2.6.0] - 2022-08-25: Update nginx ssl and uwsgi configurations

### Changed

- FP-1797: update ciphers; bump send timeout(#22)

## [2.5.0] - 2022-08-18: Increase max file upload size

### Changed

- Increase `client_max_body_size` to 2GB

## [2.4.0] - 2022-02-23: `deploy-core` restarts core services; Refresh static assets on deploy

### Changed

- Update Makefile to enforce fresh collectstatic action (#11)
- FP-442: Pull and restart workers and websockets when deploy-core (#21)

## [2.3.0] - 2021-11-01: Enable standalone services

### Added

- FP-1120 & FP-1136: Allow standalone services (e.g. CMS/Docs/Portal) (#19)

### Changed

- Add gzip configuration for static assets. (#17)

## [2.2.1] - 2021-07-15: Allow custom upstreams

### Changed

- Accept custom http entries in upstream nginx directives (#15)

## [2.2.0] - 2021-06-15: Mount Custom Settings

### Added

- Mount `custom_settings.py` into the `settings` folder (#14)

### Changed

- Update Readme

## [2.1.0] - 2020-02-03: Update docker-compose, Add nginx locations

### Added
- Added a `make` action for `deploy-docs`

### Changed
- Update `nginx.conf` with new locations from core
- Update docker-compose to 3.8 to support build stages, etc.
- Simplify location of `.env` file needed for Makefile actions

## [2.0.0] - 2020-11-23: Portal-Agnostic Camino

### Added
- Added more `make` utility commands for dynamic service deployments and dbdumps

### Changed
- All references to "frontera" were changed to "portal"
- Subscribing portals must now provide a minimal `.env` configuration file to use camino
- `nginx.conf` dynamically loads provided `*.server.conf` and `*.location.conf` files
- The `docker-compose` composition can be extended by providing a `docker-compose.overrides.yml`

## [1.2.0] - 2020-08-11: ASGI Websockets
### Changed
- FP-391: Replace uwsgi in websocket containers with daphne asgi

### Fixed
- Pin CMS release to working version in dev

### Removed
- Remove local elasticsearch configuration

## [1.1.0] - 2020-05-27
### Changed
- Enabled uwsgi on Django containers.

### Fixed
- Added a migrate step to Django deploy pipeline.

## [1.0.0] - 2020-05-06
v1.0.0 Production release as of May 6, 2020.

[unreleased]: https://github.com/TACC/Camino/compare/v2.7.1...HEAD
[2.7.1]: https://github.com/TACC/Camino/releases/tag/v2.7.1
[2.7.0]: https://github.com/TACC/Camino/releases/tag/v2.7.0
[2.6.0]: https://github.com/TACC/Camino/releases/tag/v2.6.0
[2.5.0]: https://github.com/TACC/Camino/releases/tag/v2.5.0
[2.4.0]: https://github.com/TACC/Camino/releases/tag/v2.4.0
[2.3.0]: https://github.com/TACC/Camino/releases/tag/v2.3.0
[2.2.1]: https://github.com/TACC/Camino/releases/tag/v2.2.1
[2.2.0]: https://github.com/TACC/Camino/releases/tag/v2.2.0
[2.1.0]: https://github.com/TACC/Camino/releases/tag/v2.1.0
[2.0.0]: https://github.com/TACC/Camino/releases/tag/v2.0.0
[1.2.0]: https://github.com/TACC/Camino/releases/tag/v1.2.0
[1.1.0]: https://github.com/TACC/Camino/releases/tag/v1.1.0
[1.0.0]: https://github.com/TACC/Camino/releases/tag/v1.0.0
