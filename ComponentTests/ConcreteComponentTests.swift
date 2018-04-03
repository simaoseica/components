//
//  ConcreteComponent.swift
//  ConcreteComponent
//
//  Created by Simão Seiça  on 03/04/2018.
//

import FBSnapshotTestCase
@testable import Component

final class ConcreteComponentSnapshots: FBSnapshotTestCase {

    private let component = ConcreteComponent()

    override func setUp() {
        super.setUp()

//        self.recordMode = true
        self.testName = String(describing: type(of: component))
        self.trimTestFromImageName = true
    }

    func testMale() {

        component.render(with: .male(#imageLiteral(resourceName: "shorts.jpeg"), "Shorts"))

        component.frame = CGRect(x: 0, y: 0, width: 375, height: 667)

        FBSnapshotVerifyView(component)
    }

    func testFemale() {

        component.render(with: .female(#imageLiteral(resourceName: "shorts.jpeg"), "Skirt"))

        component.frame = CGRect(x: 0, y: 0, width: 375, height: 667)

        FBSnapshotVerifyView(component)
    }

    func testScreenSize() {

        component.render(with: .female(#imageLiteral(resourceName: "shorts.jpeg"), "Skirt"))

        component.frame = CGRect(x: 0, y: 0, width: 375, height: 667)

        FBSnapshotVerifyView(component)
    }


    func testYuge() {

        component.render(with: .male(#imageLiteral(resourceName: "shorts.jpeg"), "Shorts"))

        component.frame = CGRect(x: 0, y: 0, width: 1000, height: 2000)

        FBSnapshotVerifyView(component)
    }

    func testTiny() {

        component.render(with: .male(#imageLiteral(resourceName: "shorts.jpeg"), "Shorts"))

        component.frame = CGRect(x: 0, y: 0, width: 200, height: 100)

        FBSnapshotVerifyView(component)
    }
}
