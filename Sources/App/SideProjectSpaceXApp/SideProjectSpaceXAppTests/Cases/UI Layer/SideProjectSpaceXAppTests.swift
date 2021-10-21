//
//  HomeControllerTests.swift
//  SideProjectSpaceXAppTests
//
//  Created by Christian Slanzi on 20.07.21.
//

import XCTest
import SpaceXApiModule
@testable import SideProjectSpaceXApp

class HomeControllerTests: XCTestCase {
    var sut: HomeViewController!
    var service: SpaceXApiService!
    
    override func setUpWithError() throws {
        service = SpaceXApiServiceMock()
        sut = HomeViewController(service: service)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testController_initWithService_createsHomeController() {
        XCTAssertNotNil(sut.service)
    }
}
