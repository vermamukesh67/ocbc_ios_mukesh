//
//  PayeeViewModelTest.swift
//  ocbc_ios_mukeshTests
//
//  Created by verma mukesh on 26/9/21.
//

import XCTest
@testable import ocbc_ios_mukesh
class PayeeViewModelTest: XCTestCase {
    
    var viewModel: PayeeViewModel!
    override func setUpWithError() throws {
        viewModel = PayeeViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testApiSuccessscenario() throws {
        var isSuccessCalled = false
        self.viewModel.bindControllerForSuccess = {
            isSuccessCalled = true
            XCTAssertNotNil(self.viewModel.payeeResponse, "payee data should not be nil")
            XCTAssertEqual(self.viewModel.payeeResponse?.status, "success", "status should be true")
            XCTAssertNotNil(self.viewModel.payeeResponse?.payeeData, "payee should not be nil")
            XCTAssertGreaterThan(self.viewModel.payeeResponse?.payeeData?.count ?? 0, 0, "payee count should be great than 0")
        }
        let apiRequest = MockAPIRequest.init(resource: PayeeDataResource())
        apiRequest.load { data in
            self.viewModel.payeeResponse = data
        } onError: { error in }
        XCTAssertTrue(isSuccessCalled, "isSuccessCalled should be true")
    }
    
    func testApiErrorScenario() throws {
        var isErrorCalled = false
        
        self.viewModel.bindControllerForError = { errorMessage in
            isErrorCalled = true
        }
        self.viewModel.payeeResponse = nil
        XCTAssertTrue(isErrorCalled, "isErrorCalled should be true")
    }
    
}
