//
//  HomeControllerTests.swift
//  SideProjectSpaceXAppTests
//
//  Created by Christian Slanzi on 20.07.21.
//

import XCTest
@testable import SideProjectSpaceXApp

class HomeControllerTests: XCTestCase {
    var sut: HomeViewController!
    var viewModel: HomeViewModel!

    override func setUpWithError() throws {
        let service = SpaceXApiServiceMock()
        viewModel = HomeViewModel(service: service)
        sut = HomeViewController(viewModel: viewModel)
        _ = sut.view // ensure viewDidLoad is called
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testController_initWithViewModel_createsHomeController() {
        XCTAssertNotNil(sut.viewModel)
    }

}
