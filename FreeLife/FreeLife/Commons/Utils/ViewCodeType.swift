//
//  ViewCodeType.swift
//  LearningCoordinator
//
//  Created by ihan carlos on 07/06/23.
//

import Foundation

protocol ViewCodeType {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension ViewCodeType {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    func setupAdditionalConfiguration() {}
}
