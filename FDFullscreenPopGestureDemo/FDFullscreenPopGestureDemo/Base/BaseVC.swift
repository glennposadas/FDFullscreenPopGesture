//
//  BaseVC.swift
//  FDFullscreenPopGestureDemo
//
//  Created by Glenn Posadas on 3/7/21.
//  Copyright © 2021 forkingdog. All rights reserved.
//

import UIKit

typealias ViewControllerWillAppearInjectBlock = ((_ viewController: BaseVC, _ animated: Bool) -> Void)

/**
 The base controller that implements `FBFullscreenPopGesture` features.
 */
class BaseVC: UIViewController {
    
    // MARK: - Properties
        
    /// Whether the interactive pop gesture is disabled when contained in a navigation
    /// stack.
    var interactivePopDisabled: Bool = false

    /// Indicate this view controller prefers its navigation bar hidden or not,
    /// checked when view controller based navigation bar's appearance is enabled.
    /// Default to NO, bars are more likely to show.
    var prefersNavigationBarHidden = false

    /// Max allowed initial distance to left edge when you begin the interactive pop
    /// gesture. 0 by default, which means it will ignore this limit.
    var interactivePopMaxAllowedInitialDistanceToLeftEdge: CGFloat!
    
    var willAppearInjectBlock: ViewControllerWillAppearInjectBlock?
        
    // MARK: - Overrides
    // MARK: Functions

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let willAppearInjectBlock = self.willAppearInjectBlock {
            willAppearInjectBlock(self, animated)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        DispatchQueue.main.async {
            if let topVC = self.navigationController?.viewControllers.last as? BaseVC {
                if !topVC.prefersNavigationBarHidden {
                    self.navigationController?.setNavigationBarHidden(false, animated: false)
                }
            }
        }
    }
}
