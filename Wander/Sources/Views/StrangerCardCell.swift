import UIKit

class StrangerCardCell: UICollectionViewCell {

    static let identifier = "StrangerCardCell"

    private let containerView = UIView()
    private let glowView = UIView()
    private let iconContainer = UIView()
    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let archetypeLabel = UILabel()
    private let moodBadge = UIView()
    private let moodLabel = UILabel()
    private let moodIcon = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        containerView.backgroundColor = UIColor(hex: "#1A2D42")?.withAlphaComponent(0.8)
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(hex: "#F5A623")?.withAlphaComponent(0.3).cgColor
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)

        glowView.backgroundColor = UIColor(hex: "#F5A623")?.withAlphaComponent(0.1)
        glowView.layer.cornerRadius = 40
        glowView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(glowView)

        iconContainer.backgroundColor = UIColor(hex: "#0D1B2A")?.withAlphaComponent(0.6)
        iconContainer.layer.cornerRadius = 35
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(iconContainer)

        iconImageView.tintColor = UIColor(hex: "#F5A623")
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.addSubview(iconImageView)

        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(nameLabel)

        archetypeLabel.font = .systemFont(ofSize: 12, weight: .medium)
        archetypeLabel.textColor = UIColor(hex: "#F5A623")?.withAlphaComponent(0.8)
        archetypeLabel.textAlignment = .center
        archetypeLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(archetypeLabel)

        moodBadge.backgroundColor = UIColor(hex: "#8B7FD3")?.withAlphaComponent(0.2)
        moodBadge.layer.cornerRadius = 10
        moodBadge.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(moodBadge)

        moodIcon.tintColor = UIColor(hex: "#8B7FD3")
        moodIcon.contentMode = .scaleAspectFit
        moodIcon.translatesAutoresizingMaskIntoConstraints = false
        moodBadge.addSubview(moodIcon)

        moodLabel.font = .systemFont(ofSize: 11, weight: .medium)
        moodLabel.textColor = UIColor(hex: "#8B7FD3")
        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        moodBadge.addSubview(moodLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            glowView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            glowView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            glowView.widthAnchor.constraint(equalToConstant: 80),
            glowView.heightAnchor.constraint(equalToConstant: 80),

            iconContainer.centerXAnchor.constraint(equalTo: glowView.centerXAnchor),
            iconContainer.centerYAnchor.constraint(equalTo: glowView.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 70),
            iconContainer.heightAnchor.constraint(equalToConstant: 70),

            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 36),
            iconImageView.heightAnchor.constraint(equalToConstant: 36),

            nameLabel.topAnchor.constraint(equalTo: glowView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),

            archetypeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            archetypeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            archetypeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),

            moodBadge.topAnchor.constraint(equalTo: archetypeLabel.bottomAnchor, constant: 12),
            moodBadge.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            moodBadge.heightAnchor.constraint(equalToConstant: 24),

            moodIcon.leadingAnchor.constraint(equalTo: moodBadge.leadingAnchor, constant: 8),
            moodIcon.centerYAnchor.constraint(equalTo: moodBadge.centerYAnchor),
            moodIcon.widthAnchor.constraint(equalToConstant: 14),
            moodIcon.heightAnchor.constraint(equalToConstant: 14),

            moodLabel.leadingAnchor.constraint(equalTo: moodIcon.trailingAnchor, constant: 4),
            moodLabel.trailingAnchor.constraint(equalTo: moodBadge.trailingAnchor, constant: -8),
            moodLabel.centerYAnchor.constraint(equalTo: moodBadge.centerYAnchor)
        ])
    }

    func configure(with character: StrangerCharacter) {
        nameLabel.text = character.name
        archetypeLabel.text = character.archetype.rawValue
        moodLabel.text = character.mood.rawValue

        iconImageView.image = UIImage(systemName: character.avatarSymbol)
        moodIcon.image = UIImage(systemName: character.moodIcon)

        glowView.backgroundColor = UIColor(hex: character.glowColor)?.withAlphaComponent(0.15)
        glowView.layer.borderWidth = 1
        glowView.layer.borderColor = UIColor(hex: character.glowColor)?.withAlphaComponent(0.3).cgColor

        moodBadge.backgroundColor = UIColor(hex: character.moodColor)?.withAlphaComponent(0.15)
        moodBadge.layer.borderWidth = 1
        moodBadge.layer.borderColor = UIColor(hex: character.moodColor)?.withAlphaComponent(0.3).cgColor
        moodIcon.tintColor = UIColor(hex: character.moodColor)
        moodLabel.textColor = UIColor(hex: character.moodColor)
    }
}