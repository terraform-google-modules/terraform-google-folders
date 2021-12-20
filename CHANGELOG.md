# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.1.0](https://www.github.com/terraform-google-modules/terraform-google-folders/compare/v3.0.0...v3.1.0) (2021-12-20)


### Features

* update TPG version constraints to allow 4.0 ([#36](https://www.github.com/terraform-google-modules/terraform-google-folders/issues/36)) ([38c6281](https://www.github.com/terraform-google-modules/terraform-google-folders/commit/38c6281513746a81721c7cc3acaa91fa7c842155))

## [3.0.0](https://www.github.com/terraform-google-modules/terraform-google-folders/compare/v2.0.2...v3.0.0) (2021-01-20)


### ⚠ BREAKING CHANGES

* This is a breaking change as the Terraform state location for folders has moved. See the [upgrade guide](https://github.com/terraform-google-modules/terraform-google-folders/blob/master/docs/upgrading_to_folders_v3.0.md) for details.

### Features

* Add upgrade guide and module attribution ([#32](https://www.github.com/terraform-google-modules/terraform-google-folders/issues/32)) ([183bfa1](https://www.github.com/terraform-google-modules/terraform-google-folders/commit/183bfa10b2ceb30ea9a2bea5d5ed8e011c3f02ad))
* Use for_each instead of count to create folders ([#21](https://www.github.com/terraform-google-modules/terraform-google-folders/issues/21)) ([81da73f](https://www.github.com/terraform-google-modules/terraform-google-folders/commit/81da73fc1438612187631b471074fb015e8dbeeb))


### Bug Fixes

* relax version constraints to enable terraform 0.13.x compatibility ([#27](https://www.github.com/terraform-google-modules/terraform-google-folders/issues/27)) ([ac91308](https://www.github.com/terraform-google-modules/terraform-google-folders/commit/ac913087cb44d049c7d62466aa399af60bd9851b))

## [Unreleased]

## [2.0.2] - 2020-01-10

### Fixed

- Change `var.parent` to a first class expression. [#8b79ea0]
- Fixed error with outputs after removing folders. [#16]

## [2.0.1] - 2019-11-05

### Changed

- update description of the `set_roles` variable [#19]

## [2.0.0] - 2019-08-19

### Changed
- Deprecate the `parent_id` and `parent_type` variables in favor of a single `parent` variable [#8]
- Change outputs to follow the same conventions used in the `cloud-storage` and `service-accounts` modules ([migration instructions](docs/upgrading_to_folders_v2.0.md)) [#9]
  - Rename map outputs dropping the `names_and_` prefix
  - Add resource outputs
  - Add single use outputs
  - Add list-style outputs

## [1.0.0] - 2019-07-26

### Changed

- Upgraded for usage with terraform-0.12.x [#3]

## [0.1.0] - 2019-05-28

### Added

- Initial release

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-folders/compare/v2.0.2...HEAD
[2.0.2]: https://github.com/terraform-google-modules/terraform-google-folders/compare/v2.0.1...v2.0.2
[2.0.1]: https://github.com/terraform-google-modules/terraform-google-folders/compare/v2.0.0...v2.0.1
[2.0.0]: https://github.com/terraform-google-modules/terraform-google-folders/compare/v1.0.0...v2.0.0
[1.0.0]: https://github.com/terraform-google-modules/terraform-google-folders/compare/v0.1.0...v1.0.0
[0.1.0]: https://github.com/terraform-google-modules/terraform-google-folders/releases/tag/v0.1.0
[#8b79ea0]: https://github.com/terraform-google-modules/terraform-google-folders/commit/8b79ea0fbd1ae4152c06e263522db75e7cdbd6e6
[#16]: https://github.com/terraform-google-modules/terraform-google-folders/issues/16
[#19]: https://github.com/terraform-google-modules/terraform-google-folders/pull/19
[#9]: https://github.com/terraform-google-modules/terraform-google-folders/pull/9
[#8]: https://github.com/terraform-google-modules/terraform-google-folders/pull/8
[#3]: https://github.com/terraform-google-modules/terraform-google-folders/pull/3
