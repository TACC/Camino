# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

[unreleased]: https://github.com/TACC/Camino/compare/v1.2.0...HEAD
[1.2.0]: https://github.com/TACC/Camino/releases/tag/v1.2.0
[1.1.0]: https://github.com/TACC/Camino/releases/tag/v1.1.0
[1.0.0]: https://github.com/TACC/Camino/releases/tag/v1.0.0
