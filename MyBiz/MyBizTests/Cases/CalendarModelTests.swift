//
//  CalendarModelTests.swift
//  MyBizTests
//
//  Created by bhavesh on 10/03/22.
//  Copyright © 2022 Razeware. All rights reserved.
//

import XCTest
@testable import MyBiz
@testable import CharacterizationTests

class CalendarModelTests: XCTestCase {

  var sut: CalendarModel!
  var mockAPI: MockAPI!

  override func setUp() {
    super.setUp()
    mockAPI = MockAPI()
    sut = CalendarModel(api: mockAPI)
  }

  override func tearDown() {
    sut = nil
    mockAPI = nil
    super.tearDown()
  }




  func testModel_whenGivenEmployeeList_generatedBirthdayEvents() {
    // given
    let employees = mockEmployees()
    mockAPI.mockEmployees = employees

    // when
    let events = sut.convertBirthdays(employees)

    // then
    let expectedEvents = mockBirthdayEvents()
    XCTAssertEqual(events, expectedEvents)
  }

  func testModel_whenBirthdaysLoaded_getBirthdayEvents() {
    // given
    let exp = expectation(description: "birthday loaded")

    // when
    var loadedEvents: [Event]?
    sut.getBirthdays { res in
      loadedEvents = try? res.get()
      exp.fulfill()
    }

    // then
    wait(for: [exp], timeout: 2.0)
    let expectedEvents = mockBirthdayEvents()
    XCTAssertEqual(loadedEvents, expectedEvents)
  }

  func testModel_whenEventsLoaded_getsEvents() {
    // given
    let expectedEvents = mockEvents()
    mockAPI.mockEvents = expectedEvents
    let exp = expectation(description: "events loaded")

    // when
    var loadedEvents: [Event]?
    sut.getEvents { res in
      loadedEvents = try? res.get()
      exp.fulfill()
    }

    // then
    wait(for: [exp], timeout: 1.0)
    XCTAssertEqual(loadedEvents, expectedEvents)
  }

}
