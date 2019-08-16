# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2019-08-16

### Changed

- Change outputs to follow the same conventions used in the `cloud-storage` and `service-accounts` modules []
  - Add resource, single-use and list outputs
  - Rename map outputs dropping the `names_and_` prefix
  - Rename `display_names` output to `names`

## [1.0.0] - 2019-07-26

### Changed

- Upgraded for usage with terraform-0.12.x [#3]

## [0.1.0] - 2019-05-28

### Added

- Initial release

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-folders/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/terraform-google-modules/terraform-google-folders/compare/v0.1.0...v1.0.0
[0.1.0]: https://github.com/terraform-google-modules/terraform-google-folders/releases/tag/v0.1.0
[#3]: https://github.com/terraform-google-modules/terraform-google-folders/pull/3
