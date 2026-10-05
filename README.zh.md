# GXDE DTK5
GXDE的DTK5库，请注意本包与Deepin的DTK5冲突。

## 版本
| flake attr | 上游 | pin | out 内容 | dev 内容 |
| --- | --- | --- | --- | --- |
| `dtk5common` | GXDE-OS/dtk5common | tag `6.7.43` | `share/dsg/configs/` | `lib/cmake/{Dtk,Dtk6,DtkBuildHelper}` |
| `dtklog` | GXDE-OS/dtklog | tag `6.7.43` | `libdtklog.so.0*` | `include/dtk5/DLog`、cmake、pc、qmake |
| `dtk5core` | GXDE-OS/dtk5core | tag `6.7.43` | `libdtkcore.so.5*`、`libexec/dtk5/DCore` | `include/dtk5/DCore`、cmake、pc、qmake |
| `dtk5gui` | GXDE-OS/dtk5gui | tag `6.7.43` | `libdtkgui.so.5*`、`libexec/dtk5/DGui` | `include/dtk5/DGui`、cmake、pc、qmake |
| `dtk5widget` | GXDE-OS/dtk5widget | `master` `dabd791`（见下） | `libdtkwidget.so.5*`、`libexec/dtk5/DWidget`、`share/dtk5` | `include/dtk5/DWidget`、cmake、pc、qmake、designer 插件 |
| `all` (`default`) | — | — | 五个模块 out+dev 的汇总 | |

## 使用脚本构建
### 基本使用
```bash
$ chmod a+x ./build-nix
$ ./build-nix
```

### 使用说明
```
用法: build-nix [选项] [目标]

从本地目录构建Nix包。

选项:
  -L, --log       构建时打印日志
      --rebuild   重新构建以检查可复现性
      --cleanup   清理产物
  -h, --help      打印帮助

目标:
  一个.nix文件或者flake installable，例如.#package。
  默认在当前目录查找。
```

## 许可证
(C) 2026 CharOfString.
此仓库仅包含打包；本仓库以[MIT](./LICENSE)协议授权。
