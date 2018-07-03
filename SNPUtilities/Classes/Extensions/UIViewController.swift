//
//  UIViewController.swift
//  Snapp
//
//  Created by Behdad Keynejad on 3/30/1397 AP.
//  Copyright © 1397 AP Snapp. All rights reserved.
//
import UIKit

extension UIViewController {
    public func embed(childViewController: UIViewController, in containerView: UIView) {
        self.addChildViewController(childViewController)
        childViewController.didMove(toParentViewController: self)
        containerView.addSubview(childViewController.view)
        
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: childViewController.view.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: childViewController.view.leadingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: childViewController.view.bottomAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: childViewController.view.trailingAnchor).isActive = true
    }
}
