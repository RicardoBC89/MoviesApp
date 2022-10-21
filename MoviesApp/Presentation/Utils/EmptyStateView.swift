//
//  EmptyView.swift
//  MoviesApp
//
//  Created by User on 21/10/22.
//

import UIKit

final class EmptyStateView: UIView {
    @IBOutlet weak var problemLabel: UILabel!
    @IBAction func onTryAgainButtonTap(_ sender: Any) {
    }
    
    init() {
        super.init(frame: .zero)
        loadNibContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
}
