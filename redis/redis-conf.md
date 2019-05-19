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

