# 前言

`redis.conf` 是 	`redis` 服务的配置文件，如果在启动时不进行指定 `redis.conf` 文件则会使用默认的配置
进行启动。下面是不指定 `redis.conf` 的启动示例：

```
$ redis-server 

91894:C 19 May 20:55:18.682 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
91894:C 19 May 20:55:18.682 # Redis version=4.0.2, bits=64, commit=00000000, modified=0, pid=91894, just started
91894:C 19 May 20:55:18.682 # Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
91894:M 19 May 20:55:18.683 * Increased maximum number of open files to 10032 (it was originally set to 1024).
                _._                                                  
           _.-``__ ''-._                                             
      _.-``    `.  `_.  ''-._           Redis 4.0.2 (00000000/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._                                   
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 91894
  `-._    `-._  `-./  _.-'    _.-'                                   
 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
 |    `-._`-._        _.-'_.-'    |           http://redis.io        
  `-._    `-._`-.__.-'_.-'    _.-'                                   
 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
 |    `-._`-._        _.-'_.-'    |                                  
  `-._    `-._`-.__.-'_.-'    _.-'                                   
      `-._    `-.__.-'    _.-'                                       
          `-._        _.-'                                           
              `-.__.-'                                               


```

上面的日志中有一条是 `Warning` 级别的日志：

```
Warning: no config file specified, using the default config. In order to specify a config file use redis-server /path/to/redis.conf
```

从日志中可以看到，`redis-server` 推荐在启动进行指定 `redis.conf` 配置文件。

示例，`redis.conf` 文件存储在 `/opt/redis/redis.conf` 文件目录下。在启动时可以使用如下命令进行指定配置文件：

```
redis-server /opt/redis/redis.conf
```

启动日志如下：

```
92597:C 19 May 21:00:56.559 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
92597:C 19 May 21:00:56.559 # Redis version=4.0.2, bits=64, commit=00000000, modified=0, pid=92597, just started
92597:C 19 May 21:00:56.559 # Configuration loaded
92597:M 19 May 21:00:56.560 * Increased maximum number of open files to 10032 (it was originally set to 1024).
                _._                                                  
           _.-``__ ''-._                                             
      _.-``    `.  `_.  ''-._           Redis 4.0.2 (00000000/0) 64 bit
  .-`` .-```.  ```\/    _.,_ ''-._                                   
 (    '      ,       .-`  | `,    )     Running in standalone mode
 |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
 |    `-._   `._    /     _.-'    |     PID: 92597
  `-._    `-._  `-./  _.-'    _.-'                                   
 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
 |    `-._`-._        _.-'_.-'    |           http://redis.io        
  `-._    `-._`-.__.-'_.-'    _.-'                                   
 |`-._`-._    `-.__.-'    _.-'_.-'|                                  
 |    `-._`-._        _.-'_.-'    |                                  
  `-._    `-._`-.__.-'_.-'    _.-'                                   
      `-._    `-.__.-'    _.-'                                       
          `-._        _.-'                                           
              `-.__.-'                                               

```

上述日志中有一个提示是：`Configuration loaded`。表示已经加载了 `redis.conf` 配置文件。

另外，启动时指定了 `redis.conf` 配置文件，你也可以使用 `redis-cli` 客户端进行动态修改相关配置。如，在启动时指定了采用 `AOF` 进行数据持久化，在使用过程中又想在不关闭服务的情况下动态关闭 `AOF`，则可以使用如下命令：

```
$ redis-cli 

# 查看当前是否启用 AOF
127.0.0.1:6379> config get appendonly
1) "appendonly"
2) "yes"

# 关闭 AOF
127.0.0.1:6379> config set appendonly no
OK
```

需要注意的是，通过这种形式修改的在重启服务后依然会启动 `AOF`。所以，如果你想要在之后一直生效则可以继续输入如下命令，将动态修改的
配置进行持久化到 `redis.conf` 文件中：

```
127.0.0.1:6379> CONFIG REWRITE
OK
```

通过 `config rewrite` 命令就能将动态修改的配置写入在启动 `redis` 服务时指定的配置文件中。这样，在下次重启服务并指定启动配置
文件时依然能延续之前的配置。

这里只是一个示例，在 `redis.conf` 中的所有配置都可以使用 `redis-cli` 客户端进行动态修改。下面是一些命令示例：

```
config get <setting>
```

该命令是查看配置，`<setting>` 是配置名称。如要查看配置端口，则使用 `config get port`。

```
config set <setting> <val>
```

该命令是修改配置，`<setting>` 是配置名称，`<val>` 是要修改的值。如要修改配置端口，则使用 `config set port 6380`。

```
config rewrite
```

该命令是将动态修改的配置持久化到 `redis.conf` 配置文件中。方便在下次启动时能继续应用之前的配置。


上述命令仅仅是一个示例，在之后讲解的配置都可以使用上述命令进行查看、修改以及持久化。下面就开始说明具体的 `redis.conf` 中的配
置。

**注意：该配置说明是基于 redis `v4.0.2`**

# 配置

## bind

`bind` 配置是用于指定绑定到机器的具体网卡的 IP。如果不进行指定，则会暴露给所有的网卡接口。

不太好理解，来用一个栗子说明一下。在 `Linux` 中可以输入 `ifconfig` 指令进行查看 IP 信息，下面使一个示例：

```
docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:7d:a8:fd:76  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.1.10  netmask 255.255.255.0  broadcast 192.168.1.255
        inet6 fe80::3529:13f4:38ca:5506  prefixlen 64  scopeid 0x20<link>
        ether 00:15:5d:f6:c1:01  txqueuelen 1000  (Ethernet)
        RX packets 111625  bytes 11247615 (10.7 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 95825  bytes 10664836 (10.1 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 1156085  bytes 905087201 (863.1 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1156085  bytes 905087201 (863.1 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

从上面的日志中可以看到，该主机有三个网卡，每一个网卡都包括一个 IPV4 和 IPV6。`bind` 的意思就是进行指定绑定到的具体 IP。如绑定到的 IP 是
`127.0.0.1`，那么在与 `redis` 通信时只能通过该 IP 进行通信。反过来，如果不进行绑定 IP，那么上面的六个 IP 都能跟 `redis` 进行通信。可
以进行测试一下，如果绑定一个不存在的 IP 则会启动失败。

如，这里修改 `bind` 配置如下：

```
bind 10.0.0.1
```

`10.0.0.1` 是本机不存在的一个 IP，现在进行启动 `redis` 时会输出如下日志信息：

```
103918:C 19 May 22:31:38.964 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
103918:C 19 May 22:31:38.964 # Redis version=4.0.2, bits=64, commit=00000000, modified=0, pid=103918, just started
103918:C 19 May 22:31:38.964 # Configuration loaded
103918:M 19 May 22:31:38.965 * Increased maximum number of open files to 10032 (it was originally set to 1024).
103918:M 19 May 22:31:38.965 # Creating Server TCP listening socket 10.0.0.1:6379: bind: Cannot assign requested address
```

其中最后一行日志说的很清楚，因此在使用 `bind` 之前要理解绑定的含义。

另外，`bind` 可以绑定到多个 IP，如下示例：

```
bind 127.0.0.1
bind 192.168.1.10
```

<u>下面是原文：<u>

```
By default, if no "bind" configuration directive is specified, Redis listens
for connections from all the network interfaces available on the server.
It is possible to listen to just one or multiple selected interfaces using
the "bind" configuration directive, followed by one or more IP addresses.

Examples:

bind 192.168.1.100 10.0.0.1
bind 127.0.0.1 ::1

~~~ WARNING ~~~ If the computer running Redis is directly exposed to the
internet, binding to all the interfaces is dangerous and will expose the
instance to everybody on the internet. So by default we uncomment the
following bind directive, that will force Redis to listen only into
the IPv4 lookback interface address (this means Redis will be able to
accept connections only from clients running into the same computer it
is running).

IF YOU ARE SURE YOU WANT YOUR INSTANCE TO LISTEN TO ALL THE INTERFACES
JUST COMMENT THE FOLLOWING LINE.
```

## protected-mode

该配置是一个安全防护层，如果该配置被打开（值为 `yes`）并且

1. redis 服务没有使用 `bind` 明确指定一个 IP 地址
2. 没有做密码配置

那么 redis 服务只会接受来自 IPv4 的地址 `127.0.0.1`、IPv6 的地址 `::1` 以及 Unix 的钳子套。

默认情况下该配置是被打开的，如果你想要在没有配置密码认证或没有明确的指定 `bind` 的情况下则可以关闭该配置。

使用示例：

```
# 开发防护层
protected-mode yes

# 关闭防护层
protected-mode no
```

## port

该配置用于指定端口，默认端口是 `6379`。你可以通过该配置进行修改，如修改为 `6380`:

```
port 6380
```

则使用 `redis-cli` 连接时则指定的端口为 `6380`。

另外，如果指定的端口为 0 那么 redis 将不会监听 TCP 端口。

## include

一般，我们在启动 redis 服务的时候可以指定一个 `redis.conf` 配置文件。不过，如果你想要在一个机器中启动多个 `redis` 实例
并且有大部分的配置是相同的该如何做呢？

拿一个示例来说，有两个 redis 示例 A he B。启动有很大一部分两个示例的配置是相同的，我们就将这个公共的部分提取到一个配置文件中命名为：`redis-common.conf`。
另外，A 实例有自己单独的一部分配置我们将这部分配置放在 `redis-a.conf` 配置文件中。同样的我们将 B 实例特有的配置放在 `redis-b.conf` 配置文件中。（注意：假
设这三个配置文件都在 `/opt/redis` 目录下）

现在我想要启动 A 实例该怎么做？

只需要在 `redis-a.conf` 配置文件中引入 `redis-common.conf` 即可。下面是 `redis-a.conf` 文件内容：

```
...
include /opt/redis/redis-common.conf
...
```

启动 A 实例：

```
redis-server /opt/redis/redis-a.conf
```

通过这种方式我们就能简化很大一部分配置。另外，`include` 可以指定多个引用配置。有一点需要注意，如果多个配置文件中包括相同的配置，那么只有最后一行配置生效。
如：

```
include /path/redis-1.conf
include /path/redis-2.conf
```

这两个配置文件中保存相同的配置，则 `redis-2` 中的配置生效。

需要有一点说明就是 `include` 引用的配置文件不会被 `config rewrite` 命令重写。因此，如果你希望某个配置不会被重写那么建议你讲该配置放入 `include` 中。

