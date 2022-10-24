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
        onTryAgainAction()
    }
    @IBOutlet weak var tryAgainButton: UIButton!
    var onTryAgainAction: () -> Void = {
        
    }
    
    init() {
        super.init(frame: .zero)
        loadNibContent()
        setUpViews()
    }
    
    private func setUpViews() {
        problemLabel.text = "empty_state_problem_description".localized
        tryAgainButton.setTitle("try_again".localized, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        setUpViews()
    }
}
