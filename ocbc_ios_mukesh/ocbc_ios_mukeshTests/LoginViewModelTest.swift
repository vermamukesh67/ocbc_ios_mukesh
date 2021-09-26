//
//  LoginViewModelTest.swift
//  ocbc_ios_mukeshTests
//
//  Created by verma mukesh on 26/9/21.
//

import XCTest
@testable import ocbc_ios_mukesh

class LoginViewModelTest: XCTestCase {

    var viewModel: LoginViewModel!
    override func setUpWithError() throws {
        viewModel = LoginViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testApiSuccessscenario() throws {
        var isSuccessCalled = false
        self.viewModel.bindControllerForSuccess = {
            isSuccessCalled = true
            XCTAssertNotNil(self.viewModel.loginData, "login data should not be nil")
            XCTAssertEqual(self.viewModel.loginData?.status, "success", "status should be true")
        }
        self.viewModel.bindControllerForError = { errorMessage in
        }
        let apiRequest = MockAPIRequest.init(resource: LoginDataResource())//APIRequest(resource: LoginDataResource())
        apiRequest.load { data in
            self.viewModel.loginData = data
        } onError: { error in }
        XCTAssertTrue(isSuccessCalled, "isSuccessCalled should be true")
    }
    
    func testApiErrorScenario() throws {
        var isErrorCalled = false
    
        self.viewModel.bindControllerForError = { errorMessage in
            isErrorCalled = true
        }
        self.viewModel.loginData = nil
        XCTAssertTrue(isErrorCalled, "isErrorCalled should be true")
    }
}

