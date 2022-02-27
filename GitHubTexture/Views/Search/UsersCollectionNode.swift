//
//  UsersCollectionNode.swift
//  GitHubTexture
//
//  Created by Agus Tiyansyah Syam on 27/02/22.
//

import UIKit
import AsyncDisplayKit

public final class UserCollectionNode: ASCollectionNode {

    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumLineSpacing = 8
        collectionViewFlowLayout.scrollDirection  = .vertical
        return collectionViewFlowLayout
    }()

    private let sectionInsets = UIEdgeInsets(
      top: 0.0,
      left: 20.0,
      bottom: 20.0,
      right: 20.0)
    private let itemsPerRow: CGFloat = 3

    private let users: [User]

    init(users: [User]) {
        self.users = users
        print(users.count)
        super.init(
            frame: .zero,
            collectionViewLayout: collectionViewFlowLayout,
            layoutFacilitator: nil
        )
        self.automaticallyManagesSubnodes = true
        self.delegate = self
        self.dataSource = self
        self.style.width = .init(unit: .fraction, value: 1)
        self.style.height = .init(unit: .fraction, value: 1)
    }
}

extension UserCollectionNode: ASCollectionDataSource, ASCollectionDelegate {
    public func collectionNode(
        _ collectionNode: ASCollectionNode,
        numberOfItemsInSection section: Int
    ) -> Int {
        users.count
    }

    public func collectionNode(
        _ collectionNode: ASCollectionNode,
        nodeBlockForItemAt indexPath: IndexPath
    ) -> ASCellNodeBlock {
        let userData = self.users[indexPath.row]
        return { UserCellNode(user: userData) }
    }

    public func collectionNode(
        _ collectionNode: ASCollectionNode,
        didSelectItemAt indexPath: IndexPath
    ) {
        print(self.users[indexPath.row])
    }
}

extension UserCollectionNode: UICollectionViewDelegateFlowLayout {
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
