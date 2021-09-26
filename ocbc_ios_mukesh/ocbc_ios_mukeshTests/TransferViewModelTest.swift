//
//  TransferViewModelTest.swift
//  ocbc_ios_mukeshTests
//
//  Created by verma mukesh on 26/9/21.
//

import XCTest
@testable import ocbc_ios_mukesh

class TransferViewModelTest: XCTestCase {

    var viewModel: TransferViewModel!
    override func setUpWithError() throws {
        viewModel = TransferViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testApiSuccessscenario() throws {
        var isSuccessCalled = false
        self.viewModel.bindControllerForSuccess = {
            isSuccessCalled = true
            XCTAssertNotNil(self.viewModel.transferData, "Transaction data should not be nil")
            XCTAssertEqual(self.viewModel.transferData?.status, "success", "status should be true")
            XCTAssertNotNil(self.viewModel.transferData?.transferResponse, "Transaction response should not be nil")
        }
        let apiRequest = MockAPIRequest.init(resource: TransferDataResource())
        apiRequest.load { data in
            self.viewModel.transferData = data
        } onError: { error in }
        XCTAssertTrue(isSuccessCalled, "isSuccessCalled should be true")
    }
    
    func testApiErrorScenario() throws {
        var isErrorCalled = false
        
        self.viewModel.bindControllerForError = { errorMessage in
            isErrorCalled = true
        }
        self.viewModel.transferData = nil
        XCTAssertTrue(isErrorCalled, "isErrorCalled should be true")
    }

}
