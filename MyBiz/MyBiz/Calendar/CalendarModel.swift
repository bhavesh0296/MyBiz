//
//  CalendarModel.swift
//  MyBiz
//
//  Created by bhavesh on 10/03/22.
//  Copyright © 2022 Razeware. All rights reserved.
//

import Foundation

class CalendarModel {

  let api: API
  var birthdayCallback: ((Result<[Event], Error>) -> Void)?
  var eventsCallback: ((Result<[Event], Error>) -> Void)?

  init(api: API) {
    self.api = api
  }

  func convertBirthdays(_ employees: [Employee]) -> [Event] {
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = Employee.birthdayFormat
    return employees.compactMap {
      if let dayString = $0.birthday,
         let day = dateFormater.date(from: dayString),
         let nextBirthday = day.next() {

        let title = $0.displayName + " Birthday"
        return Event(name: title,
                     date: nextBirthday,
                     type: .Birthday,
                     duration: 0)
      }
      return nil
    }
  }

  func getBirthdays(completion: @escaping (Result<[Event], Error>) -> Void) {
    birthdayCallback = completion
    api.delegate = self
    api.getOrgChart()
  }

  func getEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
    eventsCallback = completion
    api.delegate = self
    api.getEvents()
  }
}



extension CalendarModel: APIDelegate {
  func loginFailed(error: Error) {

  }

  func loginSucceeded(userId: String) {

  }

  func announcementsFailed(error: Error) {

  }

  func announcementsLoaded(announcements: [Announcement]) {

  }

  func eventsLoaded(events: [Event]) {
    eventsCallback?(.success(events))
    eventsCallback = nil
  }

  func eventsFailed(error: Error) {

  }

  func productsLoaded(products: [Product]) {

  }

  func productsFailed(error: Error) {

  }

  func purchasesLoaded(purchases: [PurchaseOrder]) {

  }

  func purchasesFailed(error: Error) {

  }

  func userLoaded(user: UserInfo) {

  }

  func userFailed(error: Error) {

  }


  func orgLoaded(org: [Employee]) {
    let birthdays = convertBirthdays(org)
    birthdayCallback?(.success(birthdays))
    birthdayCallback = nil
  }

  func orgFailed(error: Error) {

  }
}
