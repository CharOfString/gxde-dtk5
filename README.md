# GXDE DTK5
GXDE's DTK5 libraries. Please note that this package conflicts with Deepin's DTK5.

## Version
| flake attr | 上游 | pin | out 内容 | dev 内容 |
| --- | --- | --- | --- | --- |
| `dtk5common` | GXDE-OS/dtk5common | tag `6.7.43` | `share/dsg/configs/` | `lib/cmake/{Dtk,Dtk6,DtkBuildHelper}` |
| `dtklog` | GXDE-OS/dtklog | tag `6.7.43` | `libdtklog.so.0*` | `include/dtk5/DLog`、cmake、pc、qmake |
| `dtk5core` | GXDE-OS/dtk5core | tag `6.7.43` | `libdtkcore.so.5*`、`libexec/dtk5/DCore` | `include/dtk5/DCore`、cmake、pc、qmake |
| `dtk5gui` | GXDE-OS/dtk5gui | tag `6.7.43` | `libdtkgui.so.5*`、`libexec/dtk5/DGui` | `include/dtk5/DGui`、cmake、pc、qmake |
| `dtk5widget` | GXDE-OS/dtk5widget | `master` `dabd791`（见下） | `libdtkwidget.so.5*`、`libexec/dtk5/DWidget`、`share/dtk5` | `include/dtk5/DWidget`、cmake、pc、qmake、designer 插件 |
| `all` (`default`) | — | — | 五个模块 out+dev 的汇总 | |

## Building via Script
### Basic Instructions
```bash
$ chmod a+x ./build-nix
$ ./build-nix
```

### Usage
```
Usage: build-nix [options] [target]

Build a Nix package from the current directory.

Options:
  -L, --log       Show full build logs.
      --rebuild   Rebuild to check reproducibility.
      --cleanup   Cleanup results.
  -h, --help      Print help page.

Target:
  A .nix file or a flake installable, such as .#package.
  Defaults to the target where this script is in.
```

## Licensing
(C) 2026 CharOfString.
This repository only contains packaging. The repository is licensed under [MIT](./LICENSE).
