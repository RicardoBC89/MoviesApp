//
//  EmptyStateDisplayable.swift
//  MoviesApp
//
//  Created by User on 21/10/22.
//

import Foundation
import UIKit

class EmptyStateDisplayable:  UIViewController {
    
    var viewQueEuQueroQueColoqueOEmptyView: UIView { UIView()
    }
    var emptyStateView: EmptyStateView = EmptyStateView()

    
    func showEmptyState() {
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        viewQueEuQueroQueColoqueOEmptyView.addSubview(emptyStateView)
        emptyStateView.topAnchor.constraint(equalTo: viewQueEuQueroQueColoqueOEmptyView.topAnchor).isActive = true
        emptyStateView.bottomAnchor.constraint(equalTo: viewQueEuQueroQueColoqueOEmptyView.bottomAnchor).isActive = true
        emptyStateView.leadingAnchor.constraint(equalTo: viewQueEuQueroQueColoqueOEmptyView.leadingAnchor).isActive = true
        emptyStateView.trailingAnchor.constraint(equalTo: viewQueEuQueroQueColoqueOEmptyView.trailingAnchor).isActive = true
    }
    
    func hideEmptyState() {
        emptyStateView.removeFromSuperview()
    }
}
