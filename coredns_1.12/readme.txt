#
#
1 关闭win防火墙，或放行端口。

2 支持udp://127.0.0.1:53 或 udp://你的内网ip.如.192.168:53
tcp://127.0.0.1:53 或 tcp://你的内网ip.如.192.168:53

3 k4t2 dns暂时支持coredns，win server dns-server（win server 2016及以上，需要更新到最新补丁），Technitium DNS Server （12.2及以上）

4 本测试级coredns：
单win节点。使用单节点etcd，无https，无认证。
即运行：  “y有etcd，虚拟机1.ps1”

5 生产级coredns：
应使用3节点etcd，或5节点etcd。
不应该使用自动生成证书。
支持win，linux节点混用。
应使用双节点coredns，及更多节点。

6 roadmap：
非典型（测试级）dns：（测试版不支持）
非典型dns可采用n台虚拟机。
可以绑定到，n台k4tworker。
可以绑定到，k4t的app级别（寿报）。

7 k4t2 新旧版本软件及集群，可以同时使用。这是k4t2软件自带的特性。
这么做的目的是：抹平&消除，k4t软件更新，带来的集群停机影响。
这意味着：在linux worker节点机中，同时存在新旧2套不同版本的软件及集群，并同时工作，互相无影响。
这有点像：在linux node节点机中，同时存在2套不同版本的k8s集群软件，并同时工作。
这要求：不同的k4t2软件版本，需要使用不同的“etcd key 根键”，作为dns的前缀。

8 建议向本项目捐赠coredns，win server dns-server，Technitium DNS Server教程，常见问题等。
https://gitee.com/chuanjiao10/k4t2/issues

9 coredns 下载地址：
https://github.com/coredns/coredns/releases

10 k4t2不使用etcd而用文件目录作为存储。测试版k4t2的coredns默认使用etcd。当然也可以不用etcd，而用文件目录之类。