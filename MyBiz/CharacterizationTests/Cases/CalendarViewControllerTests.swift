//
//  CalenderViewControllerTests.swift
//  CharacterizationTests
//
//  Created by bhavesh on 09/03/22.
//  Copyright © 2022 Razeware. All rights reserved.
//

@testable import MyBiz
import XCTest

class CalendarViewControllerTests: XCTestCase {

  var sut: CalendarViewController!
  var mockAPI : MockAPI!

  override func setUp() {
    super.setUp()
    sut = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "Calendar") as? CalendarViewController
    mockAPI = MockAPI()
    sut.api = mockAPI
    sut.loadViewIfNeeded()
  }

  override func tearDown() {
    sut = nil
    mockAPI = nil
    super.tearDown()
  }

  func testLoadEvents_getsData() {

    /*
     // when
     sut.loadEvents()

     let exp = expectation(for: NSPredicate(block: { (vc, _) -> Bool in
     return !(vc as! CalendarViewController).events.isEmpty
     }), evaluatedWith: sut, handler: nil)

     // then
     wait(for: [exp], timeout: 2)
     print(sut.events)

     let eventJson = """
     [{"name": "Alien invasion", "date":
     "2019-04-10T12:00:00+0000",
     "type": "Appointment", "duration": 3600.0},
     {"name": "Interview with Hydra", "date":
     "2019-04-10T17:30:00+0000",
     "type": "Appointment", "duration": 1800.0},
     {"name": "Panic attack", "date": "2019-04-17T14:00:00+0000",
     "type": "Meeting", "duration": 3600.0}]
     """

     let data = Data(eventJson.utf8)
     let decoder = JSONDecoder()
     let exptectedEvetns = try? decoder.decode([Event].self, from: data)
     XCTAssertEqual(sut.events, exptectedEvetns)

     */

    // given
    let eventJson = """
    [{"name": "Alien invasion", "date":
    "2019-04-10T12:00:00+0000",
    "type": "Appointment", "duration": 3600.0},
    {"name": "Interview with Hydra", "date":
    "2019-04-10T17:30:00+0000",
    "type": "Appointment", "duration": 1800.0},
    {"name": "Panic attack", "date": "2019-04-17T14:00:00+0000",
    "type": "Meeting", "duration": 3600.0}]
    """

    let data = Data(eventJson.utf8)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    let expectedEvents = try! decoder.decode([Event].self, from: data)
    mockAPI.mockEvents = expectedEvents

    // when
    let exp = expectation(for: NSPredicate(block: { vc, _ -> Bool in
      return !(vc as! CalendarViewController).events.isEmpty
    }), evaluatedWith: sut, handler: nil)

    sut.loadEvents()

    // then
    wait(for: [exp], timeout: 2.0)
    XCTAssertEqual(sut.events, expectedEvents)
  }
}
