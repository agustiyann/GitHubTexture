//
//  SearchViewController.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 27/02/22.
//

import AsyncDisplayKit
import UIKit

class SearchViewController: ASDKViewController<ASDisplayNode> {

    // Collection flow layout
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumLineSpacing = 8
        collectionViewFlowLayout.scrollDirection  = .vertical
        return collectionViewFlowLayout
    }()

    // Search controller
    let searchController = UISearchController(searchResultsController: SearchResultViewController())
    var indicator = UIActivityIndicatorView()
    var emptyLabel = UILabel()

    // Collection node
    private let collectionNode: ASCollectionNode
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(
      top: 8.0,
      left: 20.0,
      bottom: 8.0,
      right: 20.0)

    var username: String = ""
    private var viewModel: SearchViewModel

    override init() {
        self.viewModel = SearchViewModel(useCase: UsersUseCase())
        self.collectionNode = ASCollectionNode(
            frame: .zero,
            collectionViewLayout: self.collectionViewFlowLayout
        )
        super.init(node: ASDisplayNode())
        title = "Search User"
        self.node.backgroundColor = .systemBackground
        self.collectionNode.delegate = self
        self.collectionNode.dataSource = self
        self.collectionNode.style.width = .init(unit: .fraction, value: 1)
        self.collectionNode.style.height = .init(unit: .fraction, value: 1)
        self.node.automaticallyManagesSubnodes = true
        self.node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return .init() }
            return ASInsetLayoutSpec(insets: .zero, child: self.collectionNode)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        viewModel.didLoadUsers(query: username)
    }

    private func setupView() {
        configureActivityIndicator()
        configureSearchController()
        emptyLabel.isHidden = true
    }

    private func bindViewModel() {
        startIndicator()
        viewModel.didReceiveUsers = { [weak self] in
            self?.collectionNode.reloadData()
            self?.stopIndicator()
            self?.emptyLabel.isHidden = true
            if (self?.viewModel.users.isEmpty)! {
                let message = "Oops, user not found. Try another keywords!"
                self?.configureEmptyLabel(with: message)
                self?.emptyLabel.isHidden = false
            }
        }

        viewModel.didReceiveError = { error in
            print(error)
            self.collectionNode.reloadData()
            self.stopIndicator()
            self.configureEmptyLabel(with: error.rawValue)
            self.emptyLabel.isHidden = false
        }
    }

    private func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.searchBar.keyboardType = .asciiCapable
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    private func configureActivityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = .large
        indicator.color = .systemGreen
        indicator.center = self.view.center
        self.view.addSubview(indicator)
    }

    private func startIndicator() {
        indicator.startAnimating()
        indicator.backgroundColor = .clear
    }

    private func stopIndicator() {
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }

    private func configureEmptyLabel(with message: String) {
        let screenSize = UIScreen.main.bounds
        emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screenSize.width - 20, height: 300))
        emptyLabel.center = self.view.center
        emptyLabel.textAlignment = .center
        emptyLabel.text = message
        emptyLabel.textColor = .secondaryLabel
        emptyLabel.font = UIFont.boldSystemFont(ofSize: 20)
        emptyLabel.numberOfLines = 0
        self.view.addSubview(emptyLabel)
    }

}

// MARK: - ASCollection data source & delegate

extension SearchViewController: ASCollectionDataSource, ASCollectionDelegate {
    public func collectionNode(
        _ collectionNode: ASCollectionNode,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.users.count
    }

    public func collectionNode(
        _ collectionNode: ASCollectionNode,
        nodeBlockForItemAt indexPath: IndexPath
    ) -> ASCellNodeBlock {
        let userData = viewModel.users[indexPath.row]
        return { UserCellNode(user: userData) }
    }

    public func collectionNode(
        _ collectionNode: ASCollectionNode,
        didSelectItemAt indexPath: IndexPath
    ) {
        print(viewModel.users[indexPath.row])
    }
}

// MARK: - Collection view delegate flow layout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem + 20)
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
}

// MARK: - UISearch Delegate

extension SearchViewController:  UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchController.searchBar.text {
            print(text)
            startIndicator()
            self.emptyLabel.isHidden = true
            searchController.showsSearchResultsController = false
            viewModel.didLoadUsers(query: text)
        }
    }

    func searchBar(
        _ searchBar: UISearchBar,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {
        if text == " " {
            return false
        }
        return true
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("begikn")
        searchController.showsSearchResultsController = true
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel")
    }
}
