import UIKit

class ExploreViewController: UIViewController {

    private let titleLabel = UILabel()
    private let searchBar = UISearchBar()
    private let collectionView: UICollectionView
    private var archetypes: [StrangerCharacter.Archetype] = StrangerCharacter.Archetype.allCases

    override init(nibName nibNameInBundle: String?, bundle nibBundleInBundle: Bundle?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nibNameInBundle, bundle nibBundleInBundle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#0D1B2A")
        navigationController?.navigationBar.isHidden = true

        titleLabel.text = "Explore"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        searchBar.placeholder = "Search archetypes..."
        searchBar.barStyle = .black
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)

        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ArchetypeCell.self, forCellWithReuseIdentifier: ArchetypeCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),

            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return archetypes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArchetypeCell.identifier, for: indexPath) as? ArchetypeCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: archetypes[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 120)
    }
}

class ArchetypeCell: UICollectionViewCell {

    static let identifier = "ArchetypeCell"

    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let lockIcon = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        containerView.backgroundColor = UIColor(hex: "#1A2D42")?.withAlphaComponent(0.6)
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(hex: "#F5A623")?.withAlphaComponent(0.2).cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)

        iconImageView.tintColor = UIColor(hex: "#F5A623")
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(iconImageView)

        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)

        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = UIColor.white.withAlphaComponent(0.6)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(descriptionLabel)

        lockIcon.image = UIImage(systemName: "lock.fill")
        lockIcon.tintColor = UIColor.white.withAlphaComponent(0.3)
        lockIcon.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(lockIcon)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 44),
            iconImageView.heightAnchor.constraint(equalToConstant: 44),

            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: lockIcon.leadingAnchor, constant: -12),

            descriptionLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),

            lockIcon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            lockIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            lockIcon.widthAnchor.constraint(equalToConstant: 20),
            lockIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func configure(with archetype: StrangerCharacter.Archetype) {
        titleLabel.text = archetype.rawValue
        iconImageView.image = UIImage(systemName: "sparkles")

        let descriptions: [StrangerCharacter.Archetype: String] = [
            .wanderer: "Always moving, never settled. Looking for answers in every corner of the world.",
            .lostPoet: "Writes words that hang in the air. Secrets hidden in metaphors.",
            .nightOwl: "Thinks in the dark. Loves the silence when everyone else is asleep.",
            .gentleGiant: "Speaks softly but sees deeply. Protects without making noise.",
            .starGazer: "Dreams in constellations. Finds beauty in things too far to touch.",
            .wanderingSoul: "Collects stories from strangers. Trades in laughter and secrets.",
            .midnightPhilosopher: "Asks questions that have no answers. Lives for the gray areas.",
            .silentDreamer: "Thinks before speaking. Notices things others walk past."
        ]
        descriptionLabel.text = descriptions[archetype]

        let locked = [Archetype.gentleGiant, .midnightPhilosopher, .silentDreamer].contains(archetype)
        lockIcon.isHidden = !locked
    }
}