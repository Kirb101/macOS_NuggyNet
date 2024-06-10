import SwiftUI
import WebKit

struct ContentView: View {
    @EnvironmentObject var viewModel: ContentViewModel

    var body: some View {
        VStack {
            TabView(selection: $viewModel.selectedTabIndex) {
                ForEach(viewModel.tabs.indices, id: \.self) { index in
                    WebView(webView: viewModel.tabs[index].webViewModel.webView)
                        .tabItem {
                            Text(viewModel.tabs[index].urlString)
                        }
                        .tag(index)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            HStack {
                Button(action: {
                    viewModel.tabs[viewModel.selectedTabIndex].webViewModel.goBack()
                }) {
                    Image(systemName: "arrow.left")
                }
                .disabled(!viewModel.tabs[viewModel.selectedTabIndex].webViewModel.canGoBack)

                Button(action: {
                    viewModel.tabs[viewModel.selectedTabIndex].webViewModel.load(urlString: viewModel.tabs[viewModel.selectedTabIndex].urlString)
                }) {
                    Image(systemName: "arrow.clockwise")
                }

                TextField("Enter URL", text: $viewModel.tabs[viewModel.selectedTabIndex].urlString, onCommit: {
                    viewModel.tabs[viewModel.selectedTabIndex].webViewModel.load(urlString: viewModel.tabs[viewModel.selectedTabIndex].urlString)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                Button(action: {
                    viewModel.tabs[viewModel.selectedTabIndex].webViewModel.goForward()
                }) {
                    Image(systemName: "arrow.right")
                }
                .disabled(!viewModel.tabs[viewModel.selectedTabIndex].webViewModel.canGoForward)

                Button(action: viewModel.addTab) {
                    Image(systemName: "plus")
                }

                Button(action: viewModel.closeTab) {
                    Image(systemName: "minus")
                }
                .disabled(viewModel.tabs.count <= 1)
            }
            .padding()
        }
    }
}
