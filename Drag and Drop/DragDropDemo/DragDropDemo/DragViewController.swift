//
//  ViewController.swift
//  DragDropDemo
//
//  Created by Eric Miller on 6/6/17.
//  Copyright © 2017 Handsome. All rights reserved.
//

import UIKit

class DragViewController: UIViewController {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    fileprivate var colors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple, .cyan, .magenta, .brown, .black]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
    }
}

extension DragViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CollectionViewCell
        cell.contentView.backgroundColor = colors[indexPath.item]
        return cell
    }
}

extension DragViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let color = colors[indexPath.item]
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: color))
        dragItem.localObject = color
        
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        let color = colors[indexPath.item]
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: color))
        dragItem.localObject = color
        
        return [dragItem]
    }
    
    func collectionView(_ collectionView: UICollectionView, dragSessionDidEnd session: UIDragSession) {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let preview = UIDragPreviewParameters()
        if let cell = collectionView.cellForItem(at: indexPath) {
            let cellCenterPoint = cell.contentView.center
            let path = UIBezierPath(
                arcCenter: cellCenterPoint,
                radius: 50.0,
                startAngle: 0.0,
                endAngle: 360.0,
                clockwise: true
            )
            preview.visiblePath = path
        }
        return preview
    }
}
