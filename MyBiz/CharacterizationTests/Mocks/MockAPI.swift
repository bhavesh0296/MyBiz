//
//  MockAPI.swift
//  CharacterizationTests
//
//  Created by bhavesh on 10/03/22.
//  Copyright © 2022 Razeware. All rights reserved.
//

@testable import MyBiz
import UIKit

class MockAPI: API {
  var mockEvents: [Event] = []

  var mockEmployees: [Employee] = []

  override func getEvents() {

    DispatchQueue.main.async {
      self.delegate?.eventsLoaded(events: self.mockEvents)
    }
  }

  override func getOrgChart() {
    DispatchQueue.main.async {
      self.delegate?.orgLoaded(org: self.mockEmployees)
    }
  }

}

func mockEvents() -> [Event] {
  let events = [
    Event(name: "Event 1",
          date: Date(),
          type: .Appointment,
          duration: .hours(1)),
    Event(name: "Event 2",
          date: Date(timeIntervalSinceNow: .days(20)),
          type: .Meeting,
          duration: .minutes(30)),
    Event(name: "Event 3",
          date: Date(timeIntervalSinceNow: -.days(1)),
          type: .DomesticHoliday,
          duration: .days(1))
  ]
  return events
}



func mockEmployees() ->  [Employee] {
  let employees = [
    Employee(id: "Cap",
             givenName: "Steve",
             familyName: "Rogers",
             location: "Brooklyn",
             manager: nil,
             directReports: [],
             birthday: "07-04-1920"),
    Employee(id: "Surfer",
             givenName: "Norrin",
             familyName: "Radd",
             location: "Zenn-La",
             manager: nil,
             directReports: [],
             birthday: "03-01-1966"),
    Employee(id: "Wasp",
             givenName: "Hope",
             familyName: "van Dyne",
             location: "San Francisco",
             manager: nil,
             directReports: [],
             birthday: "03-01-1966"),
  ]
  return employees
}

func mockBirthdayEvents() -> [Event] {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = Employee.birthdayFormat
  return [
    Event(name: "Steve Rogers Birthday",
          date: dateFormatter.date(from: "07-04-1920")!.next()!,
          type: .Birthday, duration: 0),
    Event(name: "Norrin Radd Birthday", date:
            dateFormatter.date(from: "03-01-1966")!.next()!,
          type: .Birthday, duration: 0),
    Event(name: "Hope van Dyne Birthday", date:
            dateFormatter.date(from: "01-02-1979")!.next()!,
          type: .Birthday, duration: 0)
  ]
}
