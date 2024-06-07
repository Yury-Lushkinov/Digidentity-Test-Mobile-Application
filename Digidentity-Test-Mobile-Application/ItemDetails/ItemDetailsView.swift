//
//  ItemDetailsView.swift
//  Digidentity-Test-Mobile-Application
//
//  Created by Yury Lushkinou on 06.06.2024.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol ItemDetailsViewProtocol: AnyObject {
    func setImage(_ image: UIImage)
    func setTitle(_ text: String)
    func setDetails(_ text: String)
}

final class ItemDetailsViewController: UIViewController {
    private let presenter: ItemDetailsViewPresenterProtocol
    private var portraitConstraints = [NSLayoutConstraint]()
    private var landscapeConstraints = [NSLayoutConstraint]()

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(presenter: ItemDetailsViewPresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)

        presenter.inject(view: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.backAction = UIAction(handler: { [weak presenter] _ in
            presenter?.close()
        })

        view.addSubview(imageView)
        view.addSubview(detailsLabel)
        view.addSubview(titleLabel)
        view.backgroundColor = .systemBackground

        configureConstraints()

        presenter.loadView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if UIDevice.current.orientation.isLandscape {
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
        } else {
            NSLayoutConstraint.activate(portraitConstraints)
            NSLayoutConstraint.deactivate(landscapeConstraints)
        }
    }

    private func configureConstraints() {
        landscapeConstraints = [
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 8),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalToConstant: 256),
            imageView.heightAnchor.constraint(equalToConstant: 256),

            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),

            detailsLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor ,constant: 16),
            detailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            detailsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            detailsLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
        ]

        portraitConstraints = [
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalToConstant: 256),
            imageView.heightAnchor.constraint(equalToConstant: 256),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),

            detailsLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            detailsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor ,constant: 8),
            detailsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            detailsLabel.heightAnchor.constraint(equalToConstant: 128),
        ]
    }
}

extension ItemDetailsViewController: ItemDetailsViewProtocol {
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
    
    func setDetails(_ text: String) {
        detailsLabel.text = text
    }
}
