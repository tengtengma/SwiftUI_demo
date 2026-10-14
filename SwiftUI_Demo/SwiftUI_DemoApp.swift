import SwiftUI

@main
struct SwiftUI_DemoApp: App {
    private let container: AppContainer

    @State private var loginViewModel: LoginViewModel

    init() {
        let configuration = NetworkConfiguration(
            baseURL: URL(string: "http://0.0.0.0:5177")!
        )

        let container = AppContainer(
            configuration: configuration
        )

        self.container = container

        _loginViewModel = State(initialValue: LoginViewModel(authSevice: container.authService))

    }

    var body: some Scene {
        WindowGroup {
            if loginViewModel.isLoginIn {
                NavigationStack {
                    HomeView(viewModel: loginViewModel, newsService: self.container.newsService)
                }
            } else {
                LoginView(viewModel: loginViewModel)
            }
        }
    }
}

