//
//  TransactionViewModelTest.swift
//  ocbc_ios_mukeshTests
//
//  Created by verma mukesh on 26/9/21.
//

import XCTest
@testable import ocbc_ios_mukesh
class TransactionViewModelTest: XCTestCase {

    var viewModel: TransactionViewModel!
    override func setUpWithError() throws {
        viewModel = TransactionViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testApiSuccessscenario() throws {
        var isSuccessCalled = false
        self.viewModel.bindControllerForSuccess = {
            isSuccessCalled = true
            XCTAssertNotNil(self.viewModel.transactionData, "Transaction data should not be nil")
            XCTAssertEqual(self.viewModel.transactionData?.status, "success", "status should be true")
            XCTAssertNotNil(self.viewModel.transactionData?.transactionData, "Transaction should not be nil")
            XCTAssertGreaterThan(self.viewModel.allTransactionData.count, 0, "Transaction count should be great than 0")
        }
        let apiRequest = MockAPIRequest.init(resource: TransactionResource())
        apiRequest.load { data in
            self.viewModel.transactionData = data
        } onError: { error in }
        XCTAssertTrue(isSuccessCalled, "isSuccessCalled should be true")
    }
    
    func testApiErrorScenario() throws {
        var isErrorCalled = false
        
        self.viewModel.bindControllerForError = { errorMessage in
            isErrorCalled = true
        }
        self.viewModel.transactionData = nil
        XCTAssertTrue(isErrorCalled, "isErrorCalled should be true")
    }

}
