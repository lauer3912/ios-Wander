import UIKit

class HomeViewController: UIViewController {

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let collectionView: UICollectionView
    private let meetButton = UIButton(type: .system)

    private var strangerCharacters: [StrangerCharacter] = []

    override init(nibName nibNameInBundle: String?, bundle nibBundleInBundle: Bundle?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 16
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nibNameInBundle, bundle: nibBundleInBundle)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSampleCharacters()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#0D1B2A")
        navigationController?.navigationBar.isHidden = true

        titleLabel.text = "Wander"
        titleLabel.font = .systemFont(ofSize: 36, weight: .bold)
        titleLabel.textColor = UIColor(hex: "#F5A623")
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        subtitleLabel.text = "Meet a stranger. They're not real."
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.7)
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)

        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StrangerCardCell.self, forCellWithReuseIdentifier: StrangerCardCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)

        meetButton.setTitle("Meet a New Stranger", for: .normal)
        meetButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        meetButton.backgroundColor = UIColor(hex: "#F5A623")
        meetButton.setTitleColor(UIColor(hex: "#0D1B2A"), for: .normal)
        meetButton.layer.cornerRadius = 25
        meetButton.translatesAutoresizingMaskIntoConstraints = false
        meetButton.addTarget(self, action: #selector(meetNewStranger), for: .touchUpInside)
        view.addSubview(meetButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: meetButton.topAnchor, constant: -30),

            meetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            meetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            meetButton.widthAnchor.constraint(equalToConstant: 250),
            meetButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func loadSampleCharacters() {
        strangerCharacters = StrangerCharacter.sampleCharacters
        collectionView.reloadData()
    }

    @objc private func meetNewStranger() {
        let chatVC = ChatViewController()
        chatVC.modalPresentationStyle = .fullScreen
        present(chatVC, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return strangerCharacters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StrangerCardCell.identifier, for: indexPath) as? StrangerCardCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: strangerCharacters[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 16) / 2
        return CGSize(width: width, height: width * 1.4)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = strangerCharacters[indexPath.item]
        let chatVC = ChatViewController(character: character)
        chatVC.modalPresentationStyle = .fullScreen
        present(chatVC, animated: true)
    }
}