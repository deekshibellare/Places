//
//  FeaturedPlacesController.swift
//  Places
//
//  Created by Deekshith Bellare on 27/09/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import UIKit

class FeaturedPlacesController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!

    let infiniteSize = 100_000
    let viewModel = PlacesViewModel()

    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToMid()
    }

    // MARK: Private functions

    private func scrollToMid() {
        let midIndexPath = IndexPath(row: infiniteSize / 2, section: 0)
        scroll(to: midIndexPath, animated: false)
        startTimer()
    }

    private func scroll(to indexPath: IndexPath, animated: Bool = true) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally,
                                    animated: animated)
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
    }

    @objc func scrollToNext(_: Timer) {
        if let topIndexPath = self.topVisibleIndexpath() {
            let nextIndexPath = IndexPath(row: topIndexPath.row + 1, section: topIndexPath.section)
            scroll(to: nextIndexPath)
        }
    }

    private func topVisibleIndexpath() -> IndexPath? {
        let visibleCells = collectionView.visibleCells
        let indexPaths = visibleCells.map { self.collectionView.indexPath(for: $0) }.compactMap { $0 }
        let sortedIndexPaths = indexPaths.sorted { $0.row < $1.row }
        return sortedIndexPaths.first
    }
}

extension FeaturedPlacesController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return infiniteSize
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlaceCell.reuseIdentifier, for: indexPath) as! FeaturedPlaceCell
        let item = viewModel.item(at: map(indexPath))
        if let imageName = item?.imageName {
            cell.placeImageView.image = UIImage(named: imageName)
        }
        return cell
    }

    func map(_ indexPath: IndexPath) -> IndexPath {
        let featureCount = viewModel.featuredPlaces?.count ?? 0
        let mapedRow = indexPath.row % featureCount
        return IndexPath(row: mapedRow, section: 1)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension FeaturedPlacesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 320)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 20
    }
}

// MARK: UIScrollViewDelegate

extension FeaturedPlacesController: UIScrollViewDelegate {
    func scrollViewDidScroll(_: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }

    func scrollViewDidEndDecelerating(_: UIScrollView) {
        startTimer()
    }

    func scrollViewDidEndDragging(_: UIScrollView, willDecelerate _: Bool) {
        startTimer()
    }
}
