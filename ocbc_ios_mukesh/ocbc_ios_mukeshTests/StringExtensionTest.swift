//
//  StringExtensionTest.swift
//  ocbc_ios_mukeshTests
//
//  Created by verma mukesh on 27/9/21.
//

import XCTest
@testable import ocbc_ios_mukesh

class StringExtensionTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCurrencyExtensionFunction() {
        let label = UILabel()
        label.text = "100000".formatIntoCurrency(prefix: "SGD", locale: Locale.init(identifier: "en_SG"))
        XCTAssertEqual(label.text, "SGD 100,000.00")
        label.text = "100000.50".formatIntoCurrency(prefix: "SGD", locale: Locale.init(identifier: "en_SG"))
        XCTAssertEqual(label.text, "SGD 100,000.50")
        label.text = "100000".formatIntoCurrency(prefix: "THB", locale: Locale.init(identifier: "en_TH"))
        XCTAssertEqual(label.text, "THB 100,000.00")
        label.text = "100000".formatIntoCurrency(prefix: "Rp", locale: Locale.init(identifier: "en_ID"))
        XCTAssertEqual(label.text, "Rp 100.000,00")
        label.text = "".formatIntoCurrency(prefix: "USD", locale: Locale.init(identifier: "en_US"))
        XCTAssertEqual(label.text, "")
        label.text = "Hello".formatIntoCurrency(prefix: "USD", locale: Locale.init(identifier: "en_US"))
        XCTAssertEqual(label.text, "Hello")
    }

}
