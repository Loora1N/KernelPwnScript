# KernelPwnScript

用于存放一些自己编写和收集的KernelPwn相关的脚本和模板

## C
目前包含exp模板，以及[arttnba3✌](https://arttnba3.cn/2021/03/03/PWN-0X00-LINUX-KERNEL-PWN-PART-I/#%E7%AC%94%E8%80%85%E8%87%AA%E7%94%A8%E6%A8%A1%E6%9D%BF)写的`kernelpwn.h`

## Python

主要存放两个remote exp上传脚本

## Shell

包含文件系统解包、打包，gdb调试以及extract-vmlinux

新增`Ktmux.sh`,可以使用该脚本在tmux中调试kernel，即运行`qemu-system`和`gdb`

### Ktmux.sh

使用前请先再Ktmux.sh内更改调试文件路径、偏移等参数

![image](https://github.com/Loora1N/KernelPwnScript/assets/102774816/d63928ab-f05e-417e-b906-bc38b2a3b066)

- cmd_qemu: 启动qemu的`start.sh`路径
- cmd_gdb: 启动`gdb_kernel.sh`路径
- vmlinux: kernel vmlinux 路径
- symbol: 导入驱动符号表的路径
- offset: 驱动载入偏移
- session_name: tmux session名称，一般默认即可

**注意：**
- **如不清楚sh脚本相对路径设置方式，可以直接使用绝对路径；**
- **若需要`-enable-kvm`参数，请直接root权限运行脚本，例`sudo ./Ktmux.sh`**

#### 演示视频

https://user-images.githubusercontent.com/102774816/284119790-1c3d6ff7-bfd5-42f8-ac58-06901766c022.mp4

### get_gadget.sh

直接将bzImage文件转换为有符号表的vmliunx，并利用`ropper`和`ROPgadget`保存gadget至`gadget.txt`

> 使用两个提取gadget的原因是，两个都无法完全提权全部可用gadget，只能相互补充了

使用前需保证已安装如下工具:

- vmlinux-to-elf
- ROPgadget
- ropper

#### usage

```sh
./get_gadget <bzImage> <output-vmlinux>
```
