//
//  CalendarViewControllerTests.swift
//  MyBizTests
//
//  Created by bhavesh on 10/03/22.
//  Copyright © 2022 Razeware. All rights reserved.
//

import XCTest
import UIKit
@testable import MyBiz
@testable import CharacterizationTests

class CalendarViewControllerTests: XCTestCase {

  var sut: CalendarViewController!
  var mockAPI: MockAPI!


  override func setUp() {
    super.setUp()
    sut = UIStoryboard("Main", bundle: nil).instantiateViewController(withIdentifier: "Calendar") as? CalendarViewController

    mockAPI = MockAPI()
    sut.api = mockAPI
    sut.loadViewIfNeeded()
  }

  override func tearDown() {
    mockAPI = nil
    sut = nil
    super.tearDown()
  }

  func testLoadEvents_getBirthdays() {
    // given
    mockAPI.mockEmployees = mockEmployees()
    let expectedEvents = mockBirthdayEvents()

    // when
    let exp = expectation(for: NSPredicate(block: { vc, _  -> Bool in
      return !(vc as CalendarViewController).events.isEmpty
    }), evaluatedWith: sut, handler: nil)
    sut.loadEvents()

    // then
    wait(for: [exp], timeout: 1.0)
    XCTAssertEqual(sut.events, expectedEvents)
  }


}
