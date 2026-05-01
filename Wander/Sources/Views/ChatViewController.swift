import UIKit

class ChatViewController: UIViewController {

    private let character: StrangerCharacter?
    private let headerView = UIView()
    private let avatarIcon = UIImageView()
    private let nameLabel = UILabel()
    private let moodLabel = UILabel()
    private let tableView = UITableView()
    private let inputContainer = UIView()
    private let textField = UITextField()
    private let sendButton = UIButton(type: .system)
    private var messages: [ChatMessage] = []

    init(character: StrangerCharacter? = nil) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSampleMessages()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#0D1B2A")

        headerView.backgroundColor = UIColor(hex: "#1A2D42")?.withAlphaComponent(0.9)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)

        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeChat), for: .touchUpInside)
        headerView.addSubview(closeButton)

        avatarIcon.image = UIImage(systemName: character?.avatarSymbol ?? "questionmark")
        avatarIcon.tintColor = UIColor(hex: "#F5A623")
        avatarIcon.contentMode = .scaleAspectFit
        avatarIcon.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(avatarIcon)

        nameLabel.text = character?.name ?? "Unknown Stranger"
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(nameLabel)

        moodLabel.text = (character?.mood.rawValue ?? "Unknown") + " · " + (character?.archetype.rawValue ?? "")
        moodLabel.font = .systemFont(ofSize: 12, weight: .medium)
        moodLabel.textColor = UIColor(hex: "#F5A623")?.withAlphaComponent(0.8)
        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(moodLabel)

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: ChatMessageCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        inputContainer.backgroundColor = UIColor(hex: "#1A2D42")
        inputContainer.layer.cornerRadius = 25
        inputContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputContainer)

        textField.placeholder = "Say something..."
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Say something...", attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.4)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.addSubview(textField)

        sendButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        sendButton.tintColor = UIColor(hex: "#F5A623")
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        inputContainer.addSubview(sendButton)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80),

            closeButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            closeButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 30),

            avatarIcon.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 16),
            avatarIcon.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            avatarIcon.widthAnchor.constraint(equalToConstant: 44),
            avatarIcon.heightAnchor.constraint(equalToConstant: 44),

            nameLabel.leadingAnchor.constraint(equalTo: avatarIcon.trailingAnchor, constant: 12),
            nameLabel.topAnchor.constraint(equalTo: avatarIcon.topAnchor, constant: 2),
            nameLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),

            moodLabel.leadingAnchor.constraint(equalTo: avatarIcon.trailingAnchor, constant: 12),
            moodLabel.bottomAnchor.constraint(equalTo: avatarIcon.bottomAnchor, constant: -2),
            moodLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),

            inputContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            inputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inputContainer.heightAnchor.constraint(equalToConstant: 50),

            textField.leadingAnchor.constraint(equalTo: inputContainer.leadingAnchor, constant: 20),
            textField.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -12),

            sendButton.trailingAnchor.constraint(equalTo: inputContainer.trailingAnchor, constant: -16),
            sendButton.centerYAnchor.constraint(equalTo: inputContainer.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 32),
            sendButton.heightAnchor.constraint(equalToConstant: 32),

            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: inputContainer.topAnchor, constant: -10)
        ])
    }

    private func loadSampleMessages() {
        let sampleTexts = [
            "Hey there... it's been a while since someone actually wanted to talk.",
            "I was just thinking about how strange it is that we can feel so alone in a world full of people.",
            "What's on your mind? I can wait... I'm not going anywhere.",
            "You know what I've learned? That most people are just pretending to have it all figured out.",
            "Sometimes the quiet moments are the ones that matter most."
        ]

        messages = sampleTexts.enumerated().map { index, text in
            ChatMessage(id: "\(index)", text: text, isFromUser: index % 3 == 0, timestamp: Date())
        }

        if let char = character {
            messages.insert(ChatMessage(id: "-1", text: "So... you're here to meet \(char.name)?\n\n\(char.backstory)", isFromUser: false, timestamp: Date()), at: 0)
        }

        tableView.reloadData()
    }

    @objc private func closeChat() {
        dismiss(animated: true)
    }

    @objc private func sendMessage() {
        guard let text = textField.text, !text.isEmpty else { return }
        let message = ChatMessage(id: "\(messages.count)", text: text, isFromUser: true, timestamp: Date())
        messages.append(message)
        tableView.reloadData()
        textField.text = ""

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            let replies = ["That's interesting... tell me more.", "I feel that.", "I understand what you mean.", "We all have those moments.", "Keep going, I'm listening."]
            let reply = ChatMessage(id: "\(self?.messages.count ?? 0)", text: replies.randomElement() ?? "", isFromUser: false, timestamp: Date())
            self?.messages.append(reply)
            self?.tableView.reloadData()
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatMessageCell.identifier, for: indexPath) as? ChatMessageCell else {
            return UITableViewCell()
        }
        cell.configure(with: messages[indexPath.row])
        return cell
    }
}

struct ChatMessage {
    let id: String
    let text: String
    let isFromUser: Bool
    let timestamp: Date
}