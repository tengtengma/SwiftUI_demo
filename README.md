# SwiftUI Demo

一个基于 SwiftUI 的 iOS 示例应用，演示用户注册与登录、新闻列表加载，以及在应用内查看新闻详情。

## 功能

- 注册账号并登录，登录状态通过 `UserDefaults` 保存。
- 登录后从服务端获取新闻，支持下拉刷新和失败重试。
- 新闻列表展示标题、摘要、来源、作者、分类和图片；点击新闻后在内置网页视图中打开原文。
- 提供退出登录入口。

## 环境要求

- Xcode（项目当前设置的 iOS 最低部署版本为 iOS 17.6）
- Swift 5
- 可访问项目配置的新闻服务端

项目通过 Swift Package Manager 管理依赖，打开 Xcode 项目时会解析依赖。主要网络依赖为 Alamofire；项目还引用了 SnapKit 和 Swift Algorithms。

## 运行

1. 使用 Xcode 打开 `SwiftUI_Demo.xcodeproj`。
2. 选择 `SwiftUI_Demo` Scheme 和 iOS 模拟器或已连接的设备。
3. 等待 Swift Package Manager 完成依赖解析，然后运行应用。
4. 在登录页输入账号和密码；新账号可先点 **Register** 注册，再登录。

## 服务端配置

API 地址集中定义在 `SwiftUI_Demo/Source/Network/HttpUrls.swift`：

```swift
let baseURL = "http://3.27.88.149:8080"
let loginURL = "/api/Auth/login"
let registerURL = "/api/Auth/register"
let getProfileURL = "/api/user/profile"
let getNewsURL = "/api/News"
```

如果使用自己的后端，请修改 `baseURL` 和对应接口路径，并确保服务端返回格式与 `SwiftUI_Demo/Source/Network` 中的请求模型一致。当前地址使用 HTTP；部署到真实环境时建议配置 HTTPS，并确认 iOS 的网络传输安全设置符合服务端配置。

## 项目结构

```text
SwiftUI_Demo/
├── Models/                 # 用户和新闻数据模型
├── ViewModels/             # 登录、新闻数据与业务状态
├── Views/                  # 登录页、新闻列表和详情页
├── Source/Network/         # API 地址、请求模型和 Alamofire 网络层
└── Utils/                  # 通用配置和辅助工具
```

应用入口为 `SwiftUI_Demo/SwiftUI_DemoApp.swift`。登录成功后进入新闻首页；首页加载和刷新逻辑位于 `HomeViewModel`。

## 开发说明

- 登录信息和 token 当前保存在 `UserDefaults`，这是示例实现；正式应用应避免明文持久化密码，并使用更安全的凭据存储方式。
- 网络请求和响应摘要会输出到 Xcode 控制台，调试时请避免使用真实用户凭据。
- 登录和新闻接口依赖可用的后端服务，离线运行时相关功能无法正常工作。
