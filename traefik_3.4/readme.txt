#
#
1 关闭win防火墙，或放行端口。

2 dashboard监听在：0.0.0.0：8080。支持http://127.0.0.1:8080 或 http://你的内网ip.如.192.168:8080
免费版默认只能看，不能编辑。

3 k4t2网关暂时支持traefik，和apisix。
本测试版用traefik为示例，主要是因为win部署相对简单。
本测试版没用apisix。生产级建议使用linux+apisix。

4 本测试级traefik：
单win节点。使用单节点etcd，有目录监控，有dashboard。
即运行：  “y3有dashboard，有监视目录，有etcd.ps1”

5 典型生产级traefik网关：
应使用3节点etcd，或5节点etcd。
应使用无dashboard，无目录监视，有etcd。
应使用双节点traefik，及更多节点。可以使用win+win，win+linux，linux+linux。
典型网关默认采用2台虚拟机。当然也可以是3，4，5台虚拟机。

6 roadmap：非典型（测试级）网关：（测试版不支持）
非典型网关可采用n台虚拟机。
可以绑定到，n台k4tworker。
可以绑定到，k4t的app级别（寿报）。

7 k4t2 新旧版本软件及集群，可以同时使用。这是k4t2软件自带的特性。
这么做的目的是：抹平&消除，k4t软件更新，带来的集群停机影响。
这意味着：在linux worker节点机中，同时存在新旧2套不同版本的软件及集群，并同时工作，互相无影响。
这有点像：在linux node节点机中，同时存在2套不同版本的k8s集群软件，并同时工作。
这要求：不同的k4t2软件版本，需要使用不同的“etcd key 根键”，作为网关的前缀。

8 关于这两个网关的问题别问我，我不会，我还想问你你呢。
建议向本项目捐赠apisix，traefik教程，常见问题等。
https://gitee.com/chuanjiao10/k4t2/issues
建议向本项目捐赠其他网关教程，是否支持etcd，添加路由，后端方法，常见问题等。

9 traefik 下载地址：
http://github.com/traefik/traefik/releases

10 k4t2不使用etcd而用文件目录作为存储。测试版k4t2的traefik网关默认使用etcd。当然也可以不用etcd，而用文件目录之类。
