//
//  DateExtensionTest.swift
//  ocbc_ios_mukeshTests
//
//  Created by verma mukesh on 27/9/21.
//

import XCTest
@testable import ocbc_ios_mukesh

class DateExtensionTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDateExtension() {
        let format = "dd MMM yyyy"
        let currentDate = Date()
        let strDate = currentDate.format(dateFormat: format)
        XCTAssertNotNil(strDate, "strDate should not be nil")
        let date = strDate.format(dateFormat: format)
        let strDate2 = date?.format(dateFormat: format)
        XCTAssertNotNil(date, "date should not be nil")
        XCTAssertEqual(strDate, strDate2, "both date should be equal")
    }

}
