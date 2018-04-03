//
//  ComponentTests.swift
//  ComponentTests
//
//  Created by Simão Seiça  on 03/04/2018.
//

import FBSnapshotTestCase
@testable import Component

final class ComponentSnapshots: FBSnapshotTestCase {

    private let component = ConcreteComponent()

    override func setUp() {
        super.setUp()

        //self.recordMode = true
        self.testName = String(describing: type(of: component))
        self.trimTestFromImageName = true
    }

    func testComponent() {

        component.render(with: .state1)

        let calculatedSize = component.systemLayoutSizeFitting(UIScreen.main.bounds.size,
                                                               withHorizontalFittingPriority: .fittingSizeLevel,
                                                               verticalFittingPriority: .fittingSizeLevel)
        component.bounds = CGRect(origin: CGPoint.zero, size: calculatedSize)
        component.layoutIfNeeded()

        FBSnapshotVerifyView(component)
    }
}
