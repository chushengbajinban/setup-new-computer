# Ubuntu 上 Go 的安装
## 方法1：使用 Ubuntu apt 仓库安装 Go
有时，Ubuntu 官方 apt 存储库包含旧版本的 Golang 包。
在撰写本文时，Ubuntu 20.04 的存储库包含 Golang 1.13.8 版本，这是一个较旧的 Go 语言版本。
因此，不建议从 Ubuntu apt 存储库安装 Go。但是，用户可以使用 apt 包管理器轻松安装 Golang 包。
因此，通过按“Ctrl+Alt+t”，访问终端窗口。更新软件包列表并键入以下命令以在 Ubuntu 20.04 系统上安装 Go：

```
sudo apt update
sudo apt install golang
```

## 方法2：下载源码安装Go 
大多数软件应用程序都需要最新版本的 Go 编程语言。在这种情况下，您需要在 Ubuntu 系统上安装最新的 Go 版本。
在撰写本文时，Go 1.17.1 是可供安装的最新稳定版本。
因此，在下载二进制存档之前，请在Go官方[https://go.dev/dl/] 下载页面查看最新版本。执行以下步骤以使用源代码方法安装 Go：

### 第1步： 下载Go二进制文件
通过运行以下 wget 命令，在 Ubuntu 20.04 系统上查找并下载最新的稳定版 Go：
```
wget https://golang.org/dl/go1.20.3.linux-amd64.tar.gz
```
注： 需要选对系统与软件架构

或者去官网手动下载

### 第2步：解压缩二进制
```
sudo tar -xzf go1.20.3.linux-amd64.tar.gz -C /usr/local/
```

### 第3步：为 Go 调整路径变量
现在，我们将 Go 目录路径添加到环境变量中，以便系统可以轻松了解在哪里搜索 Go 可执行二进制文件。
Go 目录的路径，您可以在 ‘/etc/profile 文件中添加我们将在此处遵循的系统范围安装，
或者为当前用户安装专门定义的 $Home/.profile 文件。使用源代码编辑器，打开文件“/etc/profile”，
如下所示：
```
sudo gedit /etc/profile
```
在文件末尾添加以下路径
```
export PATH=$PATH:/usr/local/go/bin
```
保存并退出

### 第4步： 激活环境变量并检查
```
source /etc/profile
go version
```