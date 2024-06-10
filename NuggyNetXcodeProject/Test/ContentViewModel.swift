import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var tabs: [TabModel] = [TabModel(urlString: "https://www.apple.com")]
    @Published var selectedTabIndex: Int = 0

    func loadEasterEggURL() {
        tabs[selectedTabIndex].urlString = "https://en.wikipedia.org/wiki/French_language"
        tabs[selectedTabIndex].webViewModel.load(urlString: tabs[selectedTabIndex].urlString)
    }

    func addTab() {
        let newTab = TabModel(urlString: "https://www.apple.com")
        tabs.append(newTab)
        selectedTabIndex = tabs.count - 1
    }

    func closeTab() {
        if tabs.count > 1 {
            tabs.remove(at: selectedTabIndex)
            selectedTabIndex = min(selectedTabIndex, tabs.count - 1)
        }
    }
}
