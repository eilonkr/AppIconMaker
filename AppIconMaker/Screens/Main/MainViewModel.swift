//
//  MainViewModel.swift
//  AppIconMaker
//
//  Created by Eilon Krauthammer on 03/11/2020.
//

import UIKit

// MARK: - Pattern 1: Delegation

/*
protocol MainViewModelDelegate: AnyObject {
    func didReceiveIcon(_ icon: UIImage)
}
*/

class MainViewModel: ViewControllerModel {

    var navigationTitle: String = "Icon Maker"
    
    /* weak var delegate: MainViewModelDelegate? */
    
    /// Pattern 2: Binding
    
    public var icon: Binding<UIImage?> = Binding(nil)
    
    public func cornerRadius(for sideDimension: CGFloat) -> CGFloat {
        return sideDimension / 4.5
    }
    
}
