# Docker & Kubernetes
## Docker
### 什么是 Docker
Docker 基于 Linux 内核的 cgroup，namespace，以及 AUFS 类的 Union FS 等技术，对进程进行封装隔离，属于操作系统层面的虚拟化技术。由于隔离的进程独立于宿主和其它的隔离的进程，因此也称其为容器。最初实现是基于 LXC，从 0.7 以后开始去除 LXC，转而使用自行开发的 libcontainer，从 1.11 开始，则进一步演进为使用 runC 和 containerd。

###  为什么要使用 Docker

#### 更高效的利用系统资源

由于容器不需要进行硬件虚拟以及运行完整操作系统等额外开销，Docker 对系统资源的利用率更高。无论是应用执行速度、内存损耗或者文件存储速度，都要比传统虚拟机技术更高效。因此，相比虚拟机技术，一个相同配置的主机，往往可以运行更多数量的应用。

#### 更快速的启动时间

传统的虚拟机技术启动应用服务往往需要数分钟，而 Docker 容器应用，由于直接运行于宿主内核，无需启动完整的操作系统，因此可以做到秒级、甚至毫秒级的启动时间。大大的节约了开发、测试、部署的时间。

#### 一致的运行环境

开发过程中一个常见的问题是环境一致性问题。由于开发环境、测试环境、生产环境不一致，导致有些 bug 并未在开发过程中被发现。而 Docker 的镜像提供了除内核外完整的运行时环境，确保了应用运行环境一致性，从而不会再出现 *“这段代码在我机器上没问题啊”* 这类问题。

#### 持续交付和部署

对开发和运维人员来说，最希望的就是一次创建或配置，可以在任意地方正常运行。

使用 Docker 可以通过定制应用镜像来实现持续集成、持续交付、部署。开发人员可以通过 [Dockerfile](https://docs.docker.com/engine/reference/builder/) 来进行镜像构建，并结合 [持续集成(Continuous Integration)](https://en.wikipedia.org/wiki/Continuous_integration) 系统进行集成测试，而运维人员则可以直接在生产环境中快速部署该镜像，甚至结合 [持续部署(Continuous Delivery/Deployment)](https://en.wikipedia.org/wiki/Continuous_delivery) 系统进行自动部署。

而且使用 `Dockerfile` 使镜像构建透明化，不仅仅开发团队可以理解应用运行环境，也方便运维团队理解应用运行所需条件，帮助更好的生产环境中部署该镜像。

#### 更轻松的迁移

由于 Docker 确保了执行环境的一致性，使得应用的迁移更加容易。Docker 可以在很多平台上运行，无论是物理机、虚拟机、公有云、私有云，甚至是笔记本，其运行结果是一致的。因此用户可以很轻易的将在一个平台上运行的应用，迁移到另一个平台上，而不用担心运行环境的变化导致应用无法正常运行的情况。

#### 更轻松的维护和扩展

Docker 使用的分层存储以及镜像的技术，使得应用重复部分的复用更为容易，也使得应用的维护更新更加简单，基于基础镜像进一步扩展镜像也变得非常简单。此外，Docker 团队同各个开源项目团队一起维护了一大批高质量的[官方镜像](https://hub.docker.com/explore/)，既可以直接在生产环境使用，又可以作为基础进一步定制，大大的降低了应用服务的镜像制作成本。

#### 对比传统虚拟机总结
|   特性     |   容器    |   虚拟机   |
| --------   | --------  | ---------- |
| 启动       | 秒级      | 分钟级     |
| 硬盘使用   | 一般为 MB | 一般为 GB  |
| 性能       | 接近原生  | 弱于       |
| 系统支持量 | 单机支持上千个容器 | 一般几十个 |

#### Dockerfile
``` Dockerfile
FROM python:2.7.12

RUN pip install tornado  --no-cache-dir
ADD https://raw.githubusercontent.com/ljy2010a/docker-tornado/master/web.py .
CMD ["python","web.py"]
EXPOSE 8888
```

# Kubernetes
### 什么是 Kubernetes
Kubernetes 是 Google 团队发起的开源项目，它的目标是管理跨多个主机的容器，提供基本的部署，维护以及运用伸缩，主要实现语言为Go语言。
Kubernetes是：
* 易学：轻量级，简单，容易理解
* 便携：支持公有云，私有云，混合云，以及多种云平台
* 可拓展：模块化，可插拔，支持钩子，可任意组合
* 自修复：自动重调度，自动重启，自动复制

Kubernetes构建于Google数十年经验，一大半来源于Google生产环境规模的经验。结合了社区最佳的想法和实践。

在分布式系统中，部署，调度，伸缩一直是最为重要的也最为基础的功能。Kubernets就是希望解决这一序列问题而产生的。

###  Kubernetes组件

* 节点（Node）：一个节点是一个运行 Kubernetes 中的主机。
* 容器组（Pod）：一个 Pod 对应于由若干容器组成的一个容器组，同个组内的容器共享一个存储卷(volume)。
* 容器组生命周期（pos-states）：包含所有容器状态集合，包括容器组状态类型，容器组生命周期，事件，重启策略，以及replication controllers。
* Replication Controllers（replication-controllers）：主要负责指定数量的pod在同一时间一起运行。
* 服务（services）：一个Kubernetes服务是容器组逻辑的高级抽象，同时也对外提供访问容器组的策略。
* 卷（volumes）：一个卷就是一个目录，容器对其有访问权限。
* 标签（labels）：标签是用来连接一组对象的，比如容器组。标签可以被用来组织和选择子对象。
* 接口权限（accessing_the_api）：端口，ip地址和代理的防火墙规则。
* web 界面（ux）：用户可以通过 web 界面操作Kubernetes。
* 命令行操作（cli）：`kubecfg`命令。

``` yaml
apiVersion: v1
kind: Service
metadata:
  name: tornado-svc
  labels:
    app: tornado
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: tornado
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: tornado-deploy
spec:
  replicas: 3
  template:
    metadata:
      labels:
        app: tornado
    spec:
      containers:
      - name: tornado
        image: registry.alauda.cn/ljy2010a/docker-tornado:latest
        ports:
        - containerPort: 8888
```