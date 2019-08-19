# Upgrading to Folders v2.0 (from v1.X)

The v2.0 release of the Folders module is a backwards incompatible release, with two important sets of changes:

- the `parent_id` and `parent_type` variables have now been combined into a single `parent` variable
- module outputs have changed to bring them in line with other modules

## Migration Instructions

### Single parent variable

The folder parent is now specificied using a single `parent` variable, that uses the full resource id path.

To create folders at the organization level, prefix the organization id with `organizations/`:

`parent = "organizations/0123456789"`

To create folders under an existing folder, prefix the existing folder id with `folders/`:

`parent = "folders/0123456789"`

### Rename map-style outputs

The `names_and_display_names` and `names_and_ids` outputs have been deprecated, and new ones are available in their place that expose the same data:

- `names_and_display_names` is now `names`
- `names_and_ids` is now `ids`

### Leverage new output types

New output types have also been added that leverage new Terraform 0.12 features or facilitate specific use cases. They are describe below.

#### Folder resources

Terraform 0.12 makes it possible to expose complete resources alongside their attributes, so two new outputs have been added:

- `folder` is the first folder resource for single folder creation use cases
- `folders` are all the folder resources as a list

#### Single folder use

When managing a single folder per module invocation, new outputs are available that directly expose its attributes:

- `folder` is the complete folder resource described above
- `name` is a string output containing the display name of the folder, eg `"Test"`
- `id` is a string output containing the numeric id of the folder, eg `"folders/12345"`

#### Lists

New list outputs have been added to expose folder attributes and preserve the ordering of the `names` variable, as maps reorder keys lexically and might introduce subtle bugs when used as lists through `values`:

- `names_list` is the list of folder display names as strings
- `ids_list` is the list of folder ids as strings
