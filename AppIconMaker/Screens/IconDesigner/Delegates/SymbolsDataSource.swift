//
//  SymbolsDataSource.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 08/11/2020.
//

import UIKit

class SymbolsDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    public var onSymbolSelected: ((String) -> Void)?
    
    private var sfSymbols = SFSymbols.all
    
    private var chosenCellIndex: Int?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sfSymbols.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SymbolCell", for: indexPath) as! SymbolCell
        cell.provide(sfSymbols[indexPath.item])
        cell.isChosen = indexPath.item == chosenCellIndex
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let symbolName = sfSymbols[indexPath.item]
        self.chosenCellIndex = indexPath.item
        let cell = collectionView.cellForItem(at: indexPath) as! SymbolCell
        cell.isChosen = true
        
        for case let otherCell as SymbolCell in collectionView.visibleCells where otherCell !== cell {
            otherCell.isChosen = false
        }
        
        onSymbolSelected?(symbolName)
    }
}
