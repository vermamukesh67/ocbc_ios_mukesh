//
//  TransactionActivityViewTest.swift
//  ocbc_ios_mukeshTests
//
//  Created by verma mukesh on 27/9/21.
//

import XCTest
@testable import ocbc_ios_mukesh

class TransactionActivityViewTest: XCTestCase {

    var transactionActivityView: TransactionActivityView!
    override func setUpWithError() throws {
        transactionActivityView = TransactionActivityView()
    }
    override func tearDownWithError() throws {
        transactionActivityView = nil
    }
    func testViewWhenInitlised() {
        XCTAssertTrue(transactionActivityView?.lblDate.text?.isEmpty ?? false, "date label text should be empty")
        XCTAssertTrue(transactionActivityView.lblTitle.text?.isEmpty ?? false, "title label text should be empty")
        XCTAssertTrue(transactionActivityView.lblAmount.text?.isEmpty ?? false, "amount label text should be empty")
    }
    func testWhenAmountIsSetAmountLabelIsVisible() {
        transactionActivityView?.setAmount(amount: "10", isCredited: true)
        XCTAssertEqual(transactionActivityView?.lblAmount.text, "10", "amount label text should be equal to 10")
        XCTAssertFalse(transactionActivityView?.lblAmount.isHidden ?? true, "amount label should not be hidden")
    }
    func testWhenTitleIsSetTitleLabelIsVisible() {
        transactionActivityView?.title = "sent"
        XCTAssertEqual(transactionActivityView?.lblTitle.text, "sent", "title text should be equal to top")
        XCTAssertFalse(transactionActivityView?.lblTitle.isHidden ?? true, "title should not be hidden")
    }
    func testWhenBottomTextIsSetBottomLabelIsVisible() {
        transactionActivityView?.date = "date"
        XCTAssertEqual(transactionActivityView?.lblDate.text, "date", "date label text should be equal to date")
        XCTAssertFalse(transactionActivityView?.lblDate.isHidden ?? true, "date label should not be hidden")
    }

}
