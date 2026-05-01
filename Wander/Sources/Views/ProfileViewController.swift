import UIKit

class ProfileViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let avatarView = UIView()
    private let avatarIcon = UIImageView()
    private let nicknameLabel = UILabel()
    private let levelBadge = UIView()
    private let levelLabel = UILabel()

    private let statsContainer = UIView()
    private let conversationsStat = StatView()
    private let daysStat = StatView()
    private let streakStat = StatView()

    private let moodChartContainer = UIView()
    private let moodChartTitle = UILabel()
    private let chartView = UIView()

    private let achievementsContainer = UIView()
    private let achievementsTitle = UILabel()
    private let achievementsCollectionView: UICollectionView

    private let settingsButton = UIButton(type: .system)

    override init(nibName nibNameInBundle: String?, bundle nibBundleInBundle: Bundle?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        achievementsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nibNameInBundle, bundle: nibBundleInBundle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#0D1B2A") ?? .clear
        navigationController?.navigationBar.isHidden = true

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        // Avatar section
        avatarView.backgroundColor = (UIColor(hex: "#1A2D42") ?? .clear).withAlphaComponent(0.8)
        avatarView.layer.cornerRadius = 50
        avatarView.layer.borderWidth = 2
        avatarView.layer.borderColor = (UIColor(hex: "#F5A623") ?? .clear).withAlphaComponent(0.5).cgColor
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatarView)

        avatarIcon.image = UIImage(systemName: "person.circle.fill")
        avatarIcon.tintColor 
        avatarIcon.contentMode = .scaleAspectFit
        avatarIcon.translatesAutoresizingMaskIntoConstraints = false
        avatarView.addSubview(avatarIcon)

        nicknameLabel.text = "Anonymous Wanderer"
        nicknameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        nicknameLabel.textColor = .white
        nicknameLabel.textAlignment = .center
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nicknameLabel)

        levelBadge.backgroundColor = (UIColor(hex: "#F5A623") ?? .clear).withAlphaComponent(0.2)
        levelBadge.layer.cornerRadius = 12
        levelBadge.layer.borderWidth = 1
        levelBadge.layer.borderColor = (UIColor(hex: "#F5A623") ?? .clear).withAlphaComponent(0.4).cgColor
        levelBadge.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(levelBadge)

        levelLabel.text = "Level 12 · Explorer"
        levelLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        levelLabel.textColor 
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelBadge.addSubview(levelLabel)

        // Stats
        statsContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(statsContainer)

        [conversationsStat, daysStat, streakStat].forEach { statsContainer.addSubview($0) }

        conversationsStat.configure(value: "47", label: "Conversations", icon: "message.fill")
        daysStat.configure(value: "23", label: "Days Active", icon: "flame.fill")
        streakStat.configure(value: "7", label: "Day Streak", icon: "star.fill")

        // Mood chart
        moodChartContainer.backgroundColor = (UIColor(hex: "#1A2D42") ?? .clear).withAlphaComponent(0.6)
        moodChartContainer.layer.cornerRadius = 16
        moodChartContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(moodChartContainer)

        moodChartTitle.text = "30-Day Mood Trend"
        moodChartTitle.font = .systemFont(ofSize: 16, weight: .bold)
        moodChartTitle.textColor = .white
        moodChartTitle.translatesAutoresizingMaskIntoConstraints = false
        moodChartContainer.addSubview(moodChartTitle)

        chartView.backgroundColor = (UIColor(hex: "#F5A623") ?? .clear).withAlphaComponent(0.2)
        chartView.layer.cornerRadius = 8
        chartView.translatesAutoresizingMaskIntoConstraints = false
        moodChartContainer.addSubview(chartView)

        // Achievements
        achievementsContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(achievementsContainer)

        achievementsTitle.text = "Achievements"
        achievementsTitle.font = .systemFont(ofSize: 18, weight: .bold)
        achievementsTitle.textColor = .white
        achievementsTitle.translatesAutoresizingMaskIntoConstraints = false
        achievementsContainer.addSubview(achievementsTitle)

        achievementsCollectionView.backgroundColor = .clear
        achievementsCollectionView.delegate = self
        achievementsCollectionView.dataSource = self
        achievementsCollectionView.register(AchievementCell.self, forCellWithReuseIdentifier: AchievementCell.identifier)
        achievementsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        achievementsContainer.addSubview(achievementsCollectionView)

        // Settings button
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        settingsButton.tintColor = UIColor.white.withAlphaComponent(0.6)
        settingsButton.titleLabel?.font = .systemFont(ofSize: 15)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(settingsButton)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            avatarView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 100),
            avatarView.heightAnchor.constraint(equalToConstant: 100),

            avatarIcon.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            avatarIcon.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            avatarIcon.widthAnchor.constraint(equalToConstant: 50),
            avatarIcon.heightAnchor.constraint(equalToConstant: 50),

            nicknameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 12),
            nicknameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            levelBadge.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 8),
            levelBadge.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            levelBadge.heightAnchor.constraint(equalToConstant: 28),

            levelLabel.leadingAnchor.constraint(equalTo: levelBadge.leadingAnchor, constant: 14),
            levelLabel.trailingAnchor.constraint(equalTo: levelBadge.trailingAnchor, constant: -14),
            levelLabel.centerYAnchor.constraint(equalTo: levelBadge.centerYAnchor),

            statsContainer.topAnchor.constraint(equalTo: levelBadge.bottomAnchor, constant: 30),
            statsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            statsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            statsContainer.heightAnchor.constraint(equalToConstant: 80),

            conversationsStat.leadingAnchor.constraint(equalTo: statsContainer.leadingAnchor),
            conversationsStat.topAnchor.constraint(equalTo: statsContainer.topAnchor),
            conversationsStat.bottomAnchor.constraint(equalTo: statsContainer.bottomAnchor),
            conversationsStat.widthAnchor.constraint(equalTo: statsContainer.widthAnchor, multiplier: 1/3),

            daysStat.centerXAnchor.constraint(equalTo: statsContainer.centerXAnchor),
            daysStat.topAnchor.constraint(equalTo: statsContainer.topAnchor),
            daysStat.bottomAnchor.constraint(equalTo: statsContainer.bottomAnchor),
            daysStat.widthAnchor.constraint(equalTo: statsContainer.widthAnchor, multiplier: 1/3),

            streakStat.trailingAnchor.constraint(equalTo: statsContainer.trailingAnchor),
            streakStat.topAnchor.constraint(equalTo: statsContainer.topAnchor),
            streakStat.bottomAnchor.constraint(equalTo: statsContainer.bottomAnchor),
            streakStat.widthAnchor.constraint(equalTo: statsContainer.widthAnchor, multiplier: 1/3),

            moodChartContainer.topAnchor.constraint(equalTo: statsContainer.bottomAnchor, constant: 24),
            moodChartContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            moodChartContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            moodChartContainer.heightAnchor.constraint(equalToConstant: 160),

            moodChartTitle.topAnchor.constraint(equalTo: moodChartContainer.topAnchor, constant: 16),
            moodChartTitle.leadingAnchor.constraint(equalTo: moodChartContainer.leadingAnchor, constant: 16),

            chartView.topAnchor.constraint(equalTo: moodChartTitle.bottomAnchor, constant: 16),
            chartView.leadingAnchor.constraint(equalTo: moodChartContainer.leadingAnchor, constant: 16),
            chartView.trailingAnchor.constraint(equalTo: moodChartContainer.trailingAnchor, constant: -16),
            chartView.bottomAnchor.constraint(equalTo: moodChartContainer.bottomAnchor, constant: -16),

            achievementsContainer.topAnchor.constraint(equalTo: moodChartContainer.bottomAnchor, constant: 24),
            achievementsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            achievementsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            achievementsTitle.topAnchor.constraint(equalTo: achievementsContainer.topAnchor),
            achievementsTitle.leadingAnchor.constraint(equalTo: achievementsContainer.leadingAnchor),

            achievementsCollectionView.topAnchor.constraint(equalTo: achievementsTitle.bottomAnchor, constant: 12),
            achievementsCollectionView.leadingAnchor.constraint(equalTo: achievementsContainer.leadingAnchor),
            achievementsCollectionView.trailingAnchor.constraint(equalTo: achievementsContainer.trailingAnchor),
            achievementsCollectionView.heightAnchor.constraint(equalToConstant: 90),
            achievementsCollectionView.bottomAnchor.constraint(equalTo: achievementsContainer.bottomAnchor),

            settingsButton.topAnchor.constraint(equalTo: achievementsContainer.bottomAnchor, constant: 30),
            settingsButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            settingsButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AchievementCell.identifier, for: indexPath) as? AchievementCell else {
            return UICollectionViewCell()
        }
        let achievements = ["First Chat", "7-Day Streak", "Mood Lifter", "Deep Talk", "Explorer", "Night Owl"]
        let icons = ["message.fill", "flame.fill", "heart.fill", "brain.head.profile", "figure.walk", "moon.stars"]
        cell.configure(title: achievements[indexPath.item], icon: icons[indexPath.item], unlocked: indexPath.item < 4)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 90)
    }
}

class StatView: UIView {
    private let valueLabel = UILabel()
    private let titleLabel = UILabel()
    private let iconView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = (UIColor(hex: "#1A2D42") ?? .clear).withAlphaComponent(0.6)
        layer.cornerRadius = 12

        iconView.tintColor 
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)

        valueLabel.font = .systemFont(ofSize: 24, weight: .bold)
        valueLabel.textColor = .white
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(valueLabel)

        titleLabel.font = .systemFont(ofSize: 11)
        titleLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),

            valueLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 6),
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 2),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8)
        ])
    }

    func configure(value: String, label: String, icon: String) {
        valueLabel.text = value
        titleLabel.text = label
        iconView.image = UIImage(systemName: icon)
    }
}

class AchievementCell: UICollectionViewCell {
    static let identifier = "AchievementCell"

    private let container = UIView()
    private let iconView = UIImageView()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        container.backgroundColor = (UIColor(hex: "#1A2D42") ?? .clear).withAlphaComponent(0.6)
        container.layer.cornerRadius = 12
        container.layer.borderWidth = 1
        container.layer.borderColor = (UIColor(hex: "#F5A623") ?? .clear).withAlphaComponent(0.2).cgColor
        container.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(container)

        iconView.tintColor 
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(iconView)

        titleLabel.font = .systemFont(ofSize: 10, weight: .medium)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            iconView.topAnchor.constraint(equalTo: container.topAnchor, constant: 14),
            iconView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 28),
            iconView.heightAnchor.constraint(equalToConstant: 28),

            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor, constant: -8)
        ])
    }

    func configure(title: String, icon: String, unlocked: Bool) {
        titleLabel.text = title
        iconView.image = UIImage(systemName: icon)
        iconView.alpha = unlocked ? 1.0 : 0.3
        container.alpha = unlocked ? 1.0 : 0.5
    }
}