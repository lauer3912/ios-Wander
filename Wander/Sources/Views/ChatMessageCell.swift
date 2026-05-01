import UIKit

class ChatMessageCell: UITableViewCell {

    static let identifier = "ChatMessageCell"

    private let bubbleView = UIView()
    private let messageLabel = UILabel()
    private let timestampLabel = UILabel()

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

        bubbleView.layer.cornerRadius = 18
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bubbleView)

        messageLabel.font = .systemFont(ofSize: 16)
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.addSubview(messageLabel)

        timestampLabel.font = .systemFont(ofSize: 10, weight: .light)
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timestampLabel)
    }

    func configure(with message: ChatMessage) {
        messageLabel.text = message.text

        if message.isFromUser {
            bubbleView.backgroundColor = UIColor(hex: "#2D5A7B")
            bubbleView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner]
            messageLabel.textColor = .white

            bubbleView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.deactivate(bubbleView.constraints.filter { $0.firstAttribute == .leading || $0.firstAttribute == .trailing })
            NSLayoutConstraint.activate([
                bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: 280)
            ])
        } else {
            bubbleView.backgroundColor = UIColor(hex: "#F5A623")?.withAlphaComponent(0.15)
            bubbleView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            messageLabel.textColor = .white

            bubbleView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.deactivate(bubbleView.constraints.filter { $0.firstAttribute == .leading || $0.firstAttribute == .trailing })
            NSLayoutConstraint.activate([
                bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: 280)
            ])
        }

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 12),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -16),
            messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -12),

            timestampLabel.topAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: 4),
            timestampLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])

        if message.isFromUser {
            timestampLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor).isActive = true
        } else {
            timestampLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor).isActive = true
        }

        let formatter = DateFormatter()
        formatter.timeStyle = .short
        timestampLabel.text = formatter.string(from: message.timestamp)
        timestampLabel.textColor = UIColor.white.withAlphaComponent(0.4)
    }
}