import UIKit

class JournalViewController: UIViewController {

    private let titleLabel = UILabel()
    private let segmentedControl = UISegmentedControl(items: ["Entries", "Mood", "Prompts"])
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#0D1B2A")
        navigationController?.navigationBar.isHidden = true

        titleLabel.text = "Journal"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = UIColor(hex: "#1A2D42")
        segmentedControl.selectedSegmentTintColor = UIColor(hex: "#F5A623")
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(hex: "#0D1B2A") ?? .black], for: .selected)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JournalEntryCell.self, forCellReuseIdentifier: JournalEntryCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            segmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension JournalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: JournalEntryCell.identifier, for: indexPath) as? JournalEntryCell else {
            return UITableViewCell()
        }
        let sampleEntries = [
            ("Talked to Elowen about loneliness...", "May 1, 2026", "Thoughtful", "#8B7FD3"),
            ("Orion made me think about my choices.", "April 30, 2026", "Calm", "#4ECDC4"),
            ("Why do I feel better after chatting?", "April 29, 2026", "Hopeful", "#FFD93D"),
            ("Kael understood something I couldn't say.", "April 28, 2026", "Melancholy", "#6C8EBF"),
            ("First time trying Wander...", "April 27, 2026", "Neutral", "#FFFFFF")
        ]
        let entry = sampleEntries[indexPath.row]
        cell.configure(title: entry.0, date: entry.1, mood: entry.2, moodColorHex: entry.3)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

class JournalEntryCell: UITableViewCell {

    static let identifier = "JournalEntryCell"

    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let moodBadge = UIView()
    private let moodLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none

        containerView.backgroundColor = UIColor(hex: "#1A2D42")?.withAlphaComponent(0.6)
        containerView.layer.cornerRadius = 14
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)

        titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)

        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = UIColor.white.withAlphaComponent(0.5)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(dateLabel)

        moodBadge.layer.cornerRadius = 10
        moodBadge.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(moodBadge)

        moodLabel.font = .systemFont(ofSize: 11, weight: .medium)
        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        moodBadge.addSubview(moodLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: moodBadge.leadingAnchor, constant: -12),

            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),

            moodBadge.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            moodBadge.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            moodBadge.heightAnchor.constraint(equalToConstant: 24),

            moodLabel.leadingAnchor.constraint(equalTo: moodBadge.leadingAnchor, constant: 10),
            moodLabel.trailingAnchor.constraint(equalTo: moodBadge.trailingAnchor, constant: -10),
            moodLabel.centerYAnchor.constraint(equalTo: moodBadge.centerYAnchor)
        ])
    }

    func configure(title: String, date: String, mood: String, moodColorHex: String) {
        titleLabel.text = title
        dateLabel.text = date
        moodLabel.text = mood
        moodBadge.backgroundColor = UIColor(hex: moodColorHex)?.withAlphaComponent(0.2)
        moodBadge.layer.borderWidth = 1
        moodBadge.layer.borderColor = UIColor(hex: moodColorHex)?.withAlphaComponent(0.4).cgColor
        moodLabel.textColor = UIColor(hex: moodColorHex)
    }
}