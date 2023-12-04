## 嘉为蓝鲸rabbitmq插件使用说明

## 使用说明

### 插件功能

从rabbitmq服务的管理插件模块页获取服务的运行状态信息。

### 版本支持

操作系统支持: linux, windows

是否支持arm: 支持

**组件支持版本：**

rabbitmq版本: 3.7.x, 3.8.x

**是否支持远程采集:**

是

### 参数说明


| **参数名**           | **含义**                                                                    | **是否必填** | **使用举例**                               |
|-------------------|---------------------------------------------------------------------------|----------|----------------------------------------|
| RABBIT_URL        | RabbitMQ管理插件的URL                                                          | 是        | http://127.0.0.1:15672                 |
| RABBIT_USER       | RabbitMQ管理插件的用户名，该用户需要具备监控标签                                              | 是        | guest                                  |
| RABBIT_PASSWORD   | RabbitMQ管理插件的密码                                                           | 是        | guest                                  |
| RABBIT_CONNECTION | 连接类型，"direct"或"loadbalancer". 使用"loadbalancer"时会删除自身标签                    | 是        | direct                                 |
| RABBIT_EXPORTERS  | 激活的模块列表。可能的模块包括: connections,shovel,federation,exchange,node,queue,memory | 是        | connections,exchange,node,queue,memory |
| RABBIT_TIMEOUT    | 从管理插件检索数据的超时时间，以秒为单位                                                      | 是        | 30                                     |
| LOG_LEVEL         | 日志级别，可能的值包括:"debug", "info", "warning", "error", "fatal"或"panic"          | 是        | info                                   |
| SKIP_VHOST        | 正则表达式，与之匹配的vhost名字不会被导出。该操作在INCLUDE_VHOST之后进行，适用于队列和交换机                   | 是        | ^$                                     |
| INCLUDE_VHOST     | 正则表达式用于过滤vhost. 只有匹配的vhosts会被导出。适用于队列和交换机                                 | 是        | .*                                     |
| INCLUDE_QUEUES    | 正则表达式用于过滤队列. 只有匹配的名字会被导出                                                  | 是        |                                        |
| SKIP_QUEUES       | 正则表达式，与之匹配的队列名不会被导出（适用于处理短暂的rpc队列）                                        | 是        |                                        |
| INCLUDE_EXCHANGES | 	正则表达式用于过滤交换机. （只有在匹配的vhosts中的交换机会被导出）                                    | 是        |                                        |
| SKIP_EXCHANGES    | 正则表达式，与之匹配的交换机名不会被导出                                                      | 是        |                                        |
| MAX_QUEUES        | 删除度量之前，队列的最大数量（如果将其设置为0，则禁用）                                              | 是        | 0                                      |


### 使用指引
1. 需要获取rabbitmq管理插件页面的账户和密码才可使用。
2. rabbitmq_up指标与常见的up指标不同，若其他模块的rabbitmq_module_up指标采集异常也会导致rabbitmq_up指标为0，只有全部采集模块正常时rabbitmq_up才会为1，若不清楚哪些模块有问题，可以编辑RABBIT_EXPORTERS参数，减少采集的模块。

### 指标简介
| **指标ID**                                       | **指标中文名**               | **维度ID**                                     | **维度含义**                       | **单位** |
|------------------------------------------------|-------------------------|----------------------------------------------|--------------------------------|--------|
| rabbitmq_up                                    | RabbitMQ监控探针运行状态        | cluster, node                                | 集群名, 节点名                       | -      |
| rabbitmq_module_up                             | RabbitMQ监控探针模块运行状态      | cluster, module                              | 集群名, 模块名                       | -      |
| rabbitmq_uptime                                | RabbitMQ服务已运行时长         | cluster, node, slef                          | 集群名, 节点名, 自身标识                 | ms     |
| rabbitmq_version_info                          | RabbitMQ服务版本信息          | cluster, erlang, node, rabbitmq              | 集群名, erlang版本, 节点名, RabbitMQ版本 | -      |
| rabbitmq_running                               | RabbitMQ运行的节点数量         | cluster, node, self                          | 集群名, 节点名, 自身标识                 | -      |
| rabbitmq_channels                              | RabbitMQ使用的通道数量         | cluster                                      | 集群名                            | -      |
| rabbitmq_connections                           | RabbitMQ连接数量            | cluster                                      | 集群名                            | -      |
| rabbitmq_consumers                             | RabbitMQ消息消费者的数量        | cluster                                      | 集群名                            | -      |
| rabbitmq_exchanges                             | RabbitMQ使用的交换机数量        | cluster                                      | 集群名                            | -      |
| rabbitmq_queues                                | RabbitMQ使用的队列数量         | cluster                                      | 集群名                            | -      |
| rabbitmq_queue_messages_ready_global           | RabbitMQ就绪消息总数          | cluster                                      | 集群名                            | -      |
| rabbitmq_queue_messages_global                 | RabbitMQ消息总数            | cluster                                      | 集群名                            | -      |
| rabbitmq_queue_messages_unacknowledged_global  | RabbitMQ未确认消息总数         | cluster                                      | 集群名                            | -      |
| rabbitmq_queue_messages_published_total        | RabbitMQ队列消息发布总数        | cluster                                      | 集群名                            | -      |
| rabbitmq_messages_deliver_no_ack_rate          | RabbitMQ无需确认消息的交付速率     | cluster                                      | 集群名                            | -      |
| rabbitmq_messages_deliver_rate                 | RabbitMQ需要确认消息的交付速率     | cluster                                      | 集群名                            | -      |
| rabbitmq_messages_publish_rate                 | RabbitMQ消息发布速率          | cluster                                      | 集群名                            | -      |
| rabbitmq_fd_available                          | RabbitMQ可用的文件描述符        | cluster, node, self                          | 集群名, 节点名, 自身标识                 | -      |
| rabbitmq_fd_used                               | RabbitMQ使用的文件描述符        | cluster, node, self                          | 集群名, 节点名, 自身标识                 | -      |
| rabbitmq_memory_allocated_unused_bytes         | RabbitMQ预分配但未使用的内存      | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_atom_bytes                     | RabbitMQ原子类型使用的内存       | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_binary_bytes                   | RabbitMQ二进制数据使用的内存      | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_code_bytes                     | RabbitMQ代码使用的内存         | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_connection_channels_bytes      | RabbitMQ连接通道使用的内存       | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_connection_other_bytes         | RabbitMQ其他连接使用的内存       | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_connection_writers_bytes       | RabbitMQ连接写入者使用的内存      | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_metrics_bytes                  | RabbitMQ节点本地指标数据使用的内存   | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_mgmt_db_bytes                  | RabbitMQ管理数据库使用的内存      | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_mnesia_bytes                   | RabbitMQ Mnesia数据库使用的内存 | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_msg_index_bytes                | RabbitMQ消息索引使用的内存       | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_other_ets_bytes                | RabbitMQ其他ETS表使用的内存     | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_other_proc_bytes               | RabbitMQ其他过程使用的内存       | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_other_system_bytes             | RabbitMQ其他系统使用的内存       | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_plugins_bytes                  | RabbitMQ插件使用的内存         | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_queue_procs_bytes              | RabbitMQ队列进程使用的内存       | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_queue_slave_procs_bytes        | RabbitMQ队列从进程使用的内存      | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_reserved_unallocated_bytes     | RabbitMQ保留但未分配的内存       | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_total_allocated_bytes          | RabbitMQ分配的总内存          | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_total_erlang_bytes             | RabbitMQ Erlang使用的总内存   | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_total_rss_bytes                | RabbitMQ RSS使用的总内存      | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_memory_reserved_unallocated_bytes     | RabbitMQ保留的但未分配的内存      | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_node_mem_used                         | RabbitMQ节点使用的内存         | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_node_mem_limit                        | RabbitMQ节点内存限制          | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_node_mem_alarm                        | RabbitMQ节点内存警告          | cluster, node, self                          | 集群名, 节点名, 自身标识                 | -      |
| rabbitmq_partitions                            | RabbitMQ网络分区数量          | cluster, node, self                          | 集群名, 节点名, 自身标识                 | -      |
| rabbitmq_sockets_available                     | RabbitMQ可用的套接字数量        | cluster, node, self                          | 集群名, 节点名, 自身标识                 | -      |
| rabbitmq_sockets_used                          | RabbitMQ使用的套接字数量        | cluster, node, self                          | 集群名, 节点名, 自身标识                 | -      |
| rabbitmq_exchange_messages_published_in_total  | RabbitMQ入站消息总数          | cluster, exchange, vhost                     | 集群名, 交换器, 虚拟主机                 | -      |
| rabbitmq_exchange_messages_published_out_total | RabbitMQ出站消息总数          | cluster, exchange, vhost                     | 集群名, 交换器, 虚拟主机                 | -      |
| rabbitmq_node_disk_free                        | RabbitMQ节点磁盘剩余量         | cluster, node, self                          | 集群名, 节点名, 自身标识                 | bytes  |
| rabbitmq_node_disk_free_alarm                  | RabbitMQ节点磁盘剩余警报        | cluster, node, self                          | 集群名, 节点名, 自身标识                 | -      |
| rabbitmq_node_disk_free_limit                  | RabbitMQ节点磁盘剩余限制        | cluster, node, self                          | 集群名, 节点名, 自身标识                 | -      |
| rabbitmq_connection_received_bytes             | RabbitMQ已接收字节           | cluster, node, peer_host, self, user, vhost  | 集群名, 节点名, 对端主机, 自身标识, 用户, 虚拟主机 | bytes  |
| rabbitmq_connection_received_packets           | RabbitMQ已接收数据包          | cluster, node, peer_host, self, user, vhost  | 集群名, 节点名, 对端主机, 自身标识, 用户, 虚拟主机 | -      |
| rabbitmq_connection_send_bytes                 | RabbitMQ已发送字节           | cluster, node, peer_host, self, user, vhost  | 集群名, 节点名, 对端主机, 自身标识, 用户, 虚拟主机 | bytes  |
| rabbitmq_connection_send_packets               | RabbitMQ已发送数据包          | cluster, node, peer_host, self, user, vhost  | 集群名, 节点名, 对端主机, 自身标识, 用户, 虚拟主机 | -      |
| rabbitmq_connection_send_pending               | RabbitMQ待发送数据           | cluster, node, peer_host, self, user, vhost  | 集群名, 节点名, 对端主机, 自身标识, 用户, 虚拟主机 | -      |
| rabbitmq_connection_status                     | RabbitMQ连接状态            | cluster, node, peer_host, self, user, vhost  | 集群名, 节点名, 对端主机, 自身标识, 用户, 虚拟主机 | -      |
| rabbitmq_connection_channels                   | RabbitMQ连接通道数量          | cluster, node, peer_host, self, user, vhost  | 集群名, 节点名, 对端主机, 自身标识, 用户, 虚拟主机 | -      |
| rabbitmq_queue_reductions_total                | RabbitMQ队列完成的进程调度次数     | cluster, durable, policy, queue, self, vhost | 集群名, 是否持久化, 策略, 队列, 自身标识, 虚拟主机 | -      |
| rabbitmq_queue_messages_returned_total         | RabbitMQ返回至生产者的不可路由消息数量 | cluster, durable, policy, queue, self, vhost | 集群名, 是否持久化, 策略, 队列, 自身标识, 虚拟主机 | -      |
| rabbitmq_queue_state                           | RabbitMQ队列状态            | cluster, durable, policy, queue, self, vhost | 集群名, 是否持久化, 策略, 队列, 自身标识, 虚拟主机 | -      |
| rabbitmq_queue_messages_ack_total              | RabbitMQ队列消息确认的总数       | cluster, durable, policy, queue, self, vhost | 集群名, 是否持久化, 策略, 队列, 自身标识, 虚拟主机 | -      |
| rabbitmq_queue_messages_confirmed_total        | RabbitMQ队列消息已确认的总数      | cluster, durable, policy, queue, self, vhost | 集群名, 是否持久化, 策略, 队列, 自身标识, 虚拟主机 | -      |
| rabbitmq_queue_messages_delivered_noack_total  | RabbitMQ队列已发送但未确认的消息总数  | cluster, durable, policy, queue, self, vhost | 集群名, 是否持久化, 策略, 队列, 自身标识, 虚拟主机 | -      |
| rabbitmq_queue_disk_writes_total               | RabbitMQ队列磁盘写入的总次数      | cluster, durable, policy, queue, self, vhost | 集群名, 是否持久化, 策略, 队列, 自身标识, 虚拟主机 | -      |
| rabbitmq_queue_messages_get_total              | RabbitMQ队列获取消息的总次数      | cluster, durable, policy, queue, self, vhost | 集群名, 是否持久化, 策略, 队列, 自身标识, 虚拟主机 | -      |
| rabbitmq_queue_messages_redelivered_total      | RabbitMQ队列重发的消息总数       | cluster, durable, policy, queue, self, vhost | 集群名, 是否持久化, 策略, 队列, 自身标识, 虚拟主机 | -      |
| rabbitmq_module_scrape_duration_seconds        | RabbitMQ模块抓取持续的时间       | cluster, module,node                         | 集群名, 模块名, 节点名                  | s      |


### 版本日志

#### weops_rabbitmq_exporter 2.1.9

- weops调整

添加“小嘉”微信即可获取rabbitmq监控指标最佳实践礼包，其他更多问题欢迎咨询

<img src="https://wedoc.canway.net/imgs/img/小嘉.jpg" width="50%" height="50%">
