//
//  IconDesignerViewModel.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 08/11/2020.
//

import UIKit

class IconDesignerViewModel: ViewControllerModel {
    
    var navigationTitle = "Icon Designer"
    
    public var symbol: Binding<UIImage?> = .init(nil)
    
    public func take(_ delegate: SymbolsDataSource) {
        delegate.onSymbolSelected = { [unowned self] symbolName in
            symbol.value = UIImage(systemName: symbolName)
        }
    }
    
}
    
