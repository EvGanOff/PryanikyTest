//
//  DetailViewController.swift
//  PryanikyTest
//
//  Created by Евгений Ганусенко on 8/26/22.
//

import UIKit
import Kingfisher
import SnapKit

class DetailViewController: UIViewController {

    // MARK: - Properties -
    
    private var text: String = ""
    private let label = UILabel()
    private let logoImageView = UIImageView()
    var viewModel: DetailViewModel?

    // MARK: - Initializer -

    init(title: String, text: String, imageURL: String?) {
        self.text = text
        label.text = text
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - LifeCycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTextField()
        setupLogoImageView(with: viewModel?.data?.data.url ?? "")
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
        guard let modelTitle = viewModel?.data?.name else { return }
        title = modelTitle
    }

    // MARK: - Metods -

    private func setupTextField() {
        view.addSubview(label)
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textAlignment = .center

        guard let viewModel = viewModel?.data?.data.text else { return }
        label.text = viewModel
    }

    private func setupLogoImageView(with url: String) {
        view.addSubview(logoImageView)
        logoImageView.kf.setImage(with: URL(string: url))
    }

    private func setupLayout() {
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(200)
        }

        label.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(200)
        }
    }
}
