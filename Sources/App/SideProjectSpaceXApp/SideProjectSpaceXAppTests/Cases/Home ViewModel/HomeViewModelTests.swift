//
//  HomeModelTests.swift
//  SideProjectSpaceXAppTests
//
//  Created by Will Nixon on 10/21/21.
//

import XCTest
import SpaceXApiModule
@testable import SideProjectSpaceXApp

class HomeViewModelTests: XCTestCase {
    var sut: HomeViewModel!
    var service: SpaceXApiService!
    
    override func setUpWithError() throws {
        service = SpaceXApiServiceMock()
        sut = HomeViewModel(service: service)
    }

    override func tearDownWithError() throws {
        sut = nil
        service = nil
    }
    
    func testHomeViewModel_initWithService_createsHomeViewModel() {
        XCTAssertNotNil(sut.service)
    }
    
    func testHomeViewModel_getNextLaunch_fetchesNextLaunchFromAPI() {
        let nextLaunch = Launch(name: "Crew-3", flightNumber: 75, dateLocal: "2021-10-31T02:21:00-04:00", datePrecision: "hour", smallPatch: "https://i.imgur.com/KhQ11oo.png")
        
        XCTAssertNil(sut.nextLaunch)
        let expectation = expectation(description: "getNextLaunch")
        sut.getNextLaunch { launch in
            self.sut.nextLaunch = launch
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        
        XCTAssertNotNil(sut.nextLaunch)
        XCTAssertEqual(sut.nextLaunch?.name, nextLaunch.name)
    }

}
