//
//  BalanceDisplayViewTest.swift
//  ocbc_ios_mukeshTests
//
//  Created by verma mukesh on 27/9/21.
//

import XCTest
@testable import ocbc_ios_mukesh

class BalanceDisplayViewTest: XCTestCase {
    var balanceDisplayView: BalanceDisplayView!
    override func setUpWithError() throws {
        balanceDisplayView = BalanceDisplayView()
    }
    override func tearDownWithError() throws {
        balanceDisplayView = nil
    }
    func testViewWhenInitlised() {
        XCTAssertTrue(balanceDisplayView?.lblTopHeader.text?.isEmpty ?? false, "top label text should be empty")
        XCTAssertTrue(balanceDisplayView.lblBalance.text?.isEmpty ?? false, "balance label text should be empty")
        XCTAssertTrue(balanceDisplayView.lblBottomHeader.text?.isEmpty ?? false, "bottom label text should be empty")
    }
    func testWhenBalanceIsSetBalanceLabelIsVisible() {
        balanceDisplayView?.balance = "SGD 10"
        XCTAssertEqual(balanceDisplayView?.lblBalance.text, "SGD 10", "balance label text should be equal to SGD 10")
        XCTAssertFalse(balanceDisplayView?.lblBalance.isHidden ?? true, "balance label should not be hidden")
    }
    func testWhenTopTitleIsSetTopLabelIsVisible() {
        balanceDisplayView?.topText = "top"
        XCTAssertEqual(balanceDisplayView?.lblTopHeader.text, "top", "top label text should be equal to top")
        XCTAssertFalse(balanceDisplayView?.lblTopHeader.isHidden ?? true, "top label should not be hidden")
    }
    func testWhenBottomTextIsSetBottomLabelIsVisible() {
        balanceDisplayView?.bottomText = "bottom"
        XCTAssertEqual(balanceDisplayView?.lblBottomHeader.text, "bottom", "bottom label text should be equal to bottom")
        XCTAssertFalse(balanceDisplayView?.lblBottomHeader.isHidden ?? true, "bottom label should not be hidden")
    }
}
