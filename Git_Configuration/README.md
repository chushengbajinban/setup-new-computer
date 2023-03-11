# Git 配置
### 设置本地全局个人信息（ubuntu）
```
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```
### 公钥配置
1.生成并找到`SSH Key`
```
ssh-keygen -t rsa -C "xxxxx@xxxxx.com"  
```
按照提示敲击三次`Enter`键
查看获取的`public key`
```
cat ~/.ssh/id_rsa.pub
```
或者直接到C盘中找到`id_rsa.pub`文件