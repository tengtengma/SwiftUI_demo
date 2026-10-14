
import SwiftUI

@main
struct SwiftUI_DemoApp: App {

    @State private var loginViewModel: LoginViewModel
    @State private var homeViewModel: HomeViewModel

    init() {
        let configuration = NetworkConfiguration(
            baseURL: URL(string: "http://127.0.0.1:5177")!
        )

        let container = AppContainer(
            configuration: configuration
        )

        _loginViewModel = State(
            initialValue: container.loginViewModel
        )

        _homeViewModel = State(
            initialValue: container.homeViewModel
        )
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if loginViewModel.isLoginIn {
                    NavigationStack {
                        HomeView(
                            loginViewModel: loginViewModel,
                            homeViewModel: homeViewModel
                        )
                    }
                } else {
                    LoginView(
                        viewModel: loginViewModel
                    )
                }
            }
            .onChange(of: loginViewModel.isLoginIn) {
                print(
                    "Login state changed: \(loginViewModel.isLoginIn)"
                )
            }
        }
    }
}

