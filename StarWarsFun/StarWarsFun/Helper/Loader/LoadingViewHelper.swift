//
//  LoadingViewHelper.swift
//  AutoGuardian
//
//  Created by James on 8/17/17.
//  Copyright © 2017 James. All rights reserved.
//

import Foundation
import UIKit

public class LoadingViewHelper
{
    fileprivate var loadingIndicator: UIActivityIndicatorView?
    fileprivate var indicatorContainer: UIView?
    
    public init() {
        self.loadingIndicator = UIActivityIndicatorView.init()
        self.indicatorContainer = UIView.init()
    }
    
    /** Big loading view **/
    public func startLoaderWith(view: UIView?, loadViewColor: UIColor, style: UIActivityIndicatorViewStyle)
    {
        guard let inputView = view else {
            print("ERROR: The view can't be nil")
            return
        }
        
        var rect: CGRect
        switch (style) {
        case .gray, .white:
            rect = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
            break
        case .whiteLarge:
            rect = CGRect(x: 0.0, y: 0.0, width: 70.0, height: 70.0)
            break
        }
        
        self.indicatorContainer = UIView()
        self.indicatorContainer?.frame = rect
        self.indicatorContainer?.layer.cornerRadius = 12
        self.indicatorContainer?.backgroundColor = loadViewColor
        self.indicatorContainer?.center = inputView.center
        
        self.loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: style)
        self.loadingIndicator?.center = inputView.center
        self.loadingIndicator?.startAnimating()
        
        inputView.addSubview(self.indicatorContainer!)
        inputView.addSubview(self.loadingIndicator!)
    }
    
    public func stopLoader()
    {
        self.loadingIndicator?.stopAnimating()
        self.loadingIndicator?.removeFromSuperview()
        self.indicatorContainer?.removeFromSuperview()
    }
}


