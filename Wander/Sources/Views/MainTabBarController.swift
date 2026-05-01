import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupAppearance()
    }

    private func setupTabs() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)

        let exploreVC = UINavigationController(rootViewController: ExploreViewController())
        exploreVC.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "sparkles"), tag: 1)

        let journalVC = UINavigationController(rootViewController: JournalViewController())
        journalVC.tabBarItem = UITabBarItem(title: "Journal", image: UIImage(systemName: "book.fill"), tag: 2)

        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 3)

        viewControllers = [homeVC, exploreVC, journalVC, profileVC]
    }

    private func setupAppearance() {
        tabBar.backgroundColor = UIColor(hex: "#0D1B2A")
        tabBar.tintColor = UIColor(hex: "#F5A623")
        tabBar.unselectedItemTintColor = UIColor(hex: "#8B7FD3")?.withAlphaComponent(0.6)
    }
}