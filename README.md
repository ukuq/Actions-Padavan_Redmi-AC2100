# Github Actions Padavan RM2100

- Padavan源码是[MeIsReallyBa/padavan-4.4](https://github.com/MeIsReallyBa/padavan-4.4)。
- Github Actions参考自[P3TERX/Actions-OpenWrt](https://github.com/P3TERX/Actions-OpenWrt)&[hanwckf/scut_padavan_build](https://github.com/hanwckf/scut_padavan_build)。
- 编译目标为Redmi-AC2100
- 默认登陆地址[192.168.5.1](http://192.168.5.1),登录名admin/admin

### WPA3-Personal（5 GHz）

构建时会自动应用 [本地补丁](patches/wpa3-personal-5g.patch)，在 5 GHz 无线设置中加入 WPA3-Personal。该模式使用 MT7615 驱动的 SAE、AES 和强制 PMF；2.4 GHz MT7603 的当前驱动配置未启用 WPA3，因此该频段仍只显示原有选项。

补丁依据上游 `MeIsReallyBa/padavan-4.4` 的 `10893720a7a620869c920a8c6bde41eb28df573b` 版本制作。若上游修改了相关文件，构建会在应用补丁时失败，需要先更新补丁。实际无线连接仍需在 RM2100 硬件上验证。

### 自动构建

每周的 Update Checker 检查上游 `main` 分支；发现新提交时，使用仓库自带的 `GITHUB_TOKEN` 触发 Build Padavan，无需额外配置 PAT。也可以从 Actions 页面手动启动构建。

### 防火墙ipv6配置参考
- 关闭ipv6防火墙
```
ip6tables -F
ip6tables -X
ip6tables -P INPUT ACCEPT
ip6tables -P OUTPUT ACCEPT
ip6tables -P FORWARD ACCEPT
```
- 允许ipv6防火墙特定端口转发
```
ip6tables -A FORWARD -p tcp --dport 11899 -j ACCEPT
ip6tables -A FORWARD -p udp --dport 11899 -j ACCEPT
```
- 开放ipv6防火墙特定端口80/443
```
ip6tables -A INPUT -p tcp --dport 80 -j ACCEPT
ip6tables -A OUTPUT -p tcp --sport 80 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 443 -j ACCEPT
ip6tables -A OUTPUT -p tcp --sport 443 -j ACCEPT
```
按需选择，添加在`自定义设置——脚本——在防火墙规则启动后执行`
