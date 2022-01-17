# tmexclude

A small macOS command-line tool to flag a file/folder to be excluded from Time Machine backups by setting the `com.apple.metadata:com_apple_backup_excludeItem` extended attribute.

```
USAGE: tmexclude --included --excluded [<path> ...]

ARGUMENTS:
  <path>                  Path to a file/folder.

OPTIONS:
  -i, --included/-e, --excluded
                          Flag the item to be included or excluded in backups.
  --version               Show the version.
  -h, --help              Show help information.
```

### Example

```
$ touch foo.txt
$ tmexclude -e foo.txt
$ xattr foo.txt
com.apple.metadata:com_apple_backup_excludeItem
$ tmexclude -i foo.txt
$ xattr foo.txt
<no output>
```
