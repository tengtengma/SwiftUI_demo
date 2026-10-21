# SwiftUI Demo — SwiftUI & MVVM 实战项目

[![Swift](https://img.shields.io/badge/Swift-5-orange.svg?logo=swift)](https://swift.org) [![iOS](https://img.shields.io/badge/iOS-17.6%2B-blue.svg?logo=apple)](https://developer.apple.com/ios/) [![SwiftUI](https://img.shields.io/badge/UI-SwiftUI-007AFF.svg?logo=swift)](https://developer.apple.com/xcode/swiftui/) [![Architecture](https://img.shields.io/badge/Architecture-MVVM-purple.svg)](#-架构设计)

一个基于 **SwiftUI**、**MVVM** 和 **Alamofire** 的 iOS 示例应用，串联账号注册与登录、新闻列表浏览及详情阅读。项目使用模块化网络层和手动依赖注入，展示从 API 定义到界面状态更新的一条完整路径。

---

## 🌟 特性亮点

- 🔐 **认证与登录状态**
  - 支持账号注册、登录和退出登录。
  - 登录状态保存在 `UserDefaults`，并驱动登录页与新闻首页之间的界面切换。
- 📰 **新闻内容流**
  - 从服务端加载新闻，支持下拉刷新和失败重试。
  - 新闻卡片展示标题、摘要、来源、作者、分类及配图。
- 📖 **详情阅读**
  - 点击新闻后，在应用内打开原文网页。
- 🌐 **模块化网络层**
  - 当前应用使用 `Source/Network_new`，基于 Alamofire 和 Swift Concurrency 发起异步请求。
  - 分离请求定义、数据模型、业务服务、网络核心和错误类型。
- 🧩 **手动依赖注入**
  - 使用 `AppContainer` 组装网络服务与 ViewModel，便于替换服务实现及管理依赖关系。

## 🛠 技术栈

| 模块 | 技术 | 用途 |
| --- | --- | --- |
| 开发语言 | Swift 5 | 应用实现 |
| UI 框架 | SwiftUI | 声明式界面与状态驱动更新 |
| 架构 | MVVM | 分离界面、状态和业务交互 |
| 网络请求 | Alamofire | HTTP 请求与响应校验 |
| 并发处理 | Swift Concurrency | 使用 `async` / `await` 执行请求 |
| 依赖管理 | Swift Package Manager | 管理项目依赖 |
| 本地状态 | UserDefaults | 保存示例登录状态与凭据 |

项目还引用了 SnapKit 和 Swift Algorithms。

## 📐 架构设计

界面通过 ViewModel 触发业务操作；服务层封装认证与新闻请求；网络核心负责构造 URLRequest、执行请求、解码响应并归类错误。

```text
┌─────────────────────────────────────────────┐
│                  SwiftUI Views              │
│          LoginView       HomeView           │
│                         NewsDetailView       │
└───────────────────────┬─────────────────────┘
                        │ 状态与用户操作
┌───────────────────────▼─────────────────────┐
│                   ViewModels                 │
│       LoginViewModel       HomeViewModel      │
└───────────────────────┬─────────────────────┘
                        │ 调用服务
┌───────────────────────▼─────────────────────┐
│              Feature Services / APIs         │
│       AuthService             NewsService     │
│        AuthAPI                 NewsAPI        │
└───────────────────────┬─────────────────────┘
                        │ NetworkServiceProtocol
┌───────────────────────▼─────────────────────┐
│       NetworkManager + Alamofire Session     │
└───────────────────────┬─────────────────────┘
                        │ HTTP
                 Backend REST APIs

          AppContainer 负责组装服务与 ViewModel
```

`SwiftUI_DemoApp` 创建 `NetworkConfiguration` 并交给 `AppContainer`。容器创建共享的网络服务，再注入 `AuthService`、`NewsService` 及对应 ViewModel。`NetworkServiceProtocol` 为服务层提供统一请求接口。

## 📂 项目目录结构

```text
SwiftUI_Demo/
├── SwiftUI_DemoApp.swift          # 应用入口与依赖容器初始化
├── Models/                        # 用户与新闻模型
├── Views/                         # 登录、新闻列表与详情界面
├── ViewModels/                    # 登录和首页状态管理
├── Source/
│   ├── Network_new/               # 当前应用使用的网络实现
│   │   ├── Core/                  # NetworkManager、请求协议与错误类型
│   │   ├── DI/                    # AppContainer 依赖组装
│   │   └── Features/
│   │       ├── API/               # Auth、News 请求定义
│   │       ├── Models/            # API 请求与响应模型
│   │       └── Services/          # 认证与新闻服务
│   └── Network/                   # 旧网络实现，当前应用未使用
└── Utils/                         # 通用配置与辅助工具
```

## 🚀 快速开始

### 1. 环境准备

- **Xcode**：支持当前项目配置的 iOS 17.6 部署目标
- **Swift**：5
- **后端服务**：提供项目使用的认证和新闻 API

### 2. 打开项目

使用 Xcode 打开 `SwiftUI_Demo.xcodeproj`，选择 `SwiftUI_Demo` Scheme 和 iOS 模拟器或已连接设备。等待 Swift Package Manager 完成依赖解析后运行。

### 3. 配置后端地址

在 `SwiftUI_Demo/SwiftUI_DemoApp.swift` 中修改网络配置：

```swift
let configuration = NetworkConfiguration(
    baseURL: URL(string: "http://127.0.0.1:5177")!
)
```

`127.0.0.1` 指向当前运行应用的设备本身。若后端运行在开发电脑上，iOS 模拟器通常需要配置为电脑的局域网 IP；真机也需要使用设备可访问的服务地址。

### 4. API 接口

当前 API 路径定义在 `Source/Network_new/Features/API`：

| 功能 | 方法 | 路径 |
| --- | --- | --- |
| 登录 | POST | `/api/Auth/login` |
| 注册 | POST | `/api/Auth/register` |
| 获取新闻 | GET | `/api/News` |

服务端返回结构需与 `Source/Network_new/Features/Models` 中的 Codable 模型相匹配。当前示例地址使用 HTTP；部署环境建议使用 HTTPS。

## 📝 开发说明

- 登录状态及凭据目前通过 `UserDefaults` 保存，属于演示实现；生产应用应使用 Keychain 等安全凭据存储。
- 网络调试信息可能输出到 Xcode 控制台，请避免使用真实用户凭据进行调试。
- 登录与新闻页面需要后端服务可用。
