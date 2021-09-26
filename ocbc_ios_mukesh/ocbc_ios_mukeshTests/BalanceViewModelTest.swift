//
//  BalanceViewModelTest.swift
//  ocbc_ios_mukeshTests
//
//  Created by verma mukesh on 26/9/21.
//

import XCTest
@testable import ocbc_ios_mukesh

class BalanceViewModelTest: XCTestCase {

    var viewModel: BalanceViewModel!
    override func setUpWithError() throws {
        viewModel = BalanceViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testApiSuccessscenario() throws {
        var isSuccessCalled = false
        self.viewModel.bindControllerForSuccess = {
            isSuccessCalled = true
            XCTAssertNotNil(self.viewModel.balanceData, "balance data should not be nil")
            XCTAssertEqual(self.viewModel.balanceData?.status, "success", "status should be true")
            XCTAssertNotNil(self.viewModel.balanceData?.balance, "balance should not be nil")
        }
        let apiRequest = MockAPIRequest.init(resource: BalanceDataResource())
        apiRequest.load { data in
            self.viewModel.balanceData = data
        } onError: { error in }
        XCTAssertTrue(isSuccessCalled, "isSuccessCalled should be true")
    }
    
    func testApiErrorScenario() throws {
        var isErrorCalled = false
    
        self.viewModel.bindControllerForError = { errorMessage in
            isErrorCalled = true
        }
        self.viewModel.balanceData = nil
        XCTAssertTrue(isErrorCalled, "isErrorCalled should be true")
    }

}
