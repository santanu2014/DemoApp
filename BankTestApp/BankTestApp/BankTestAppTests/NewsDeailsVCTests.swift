//
//  NewsDeailsVCTests.swift
//  BankTestAppTests
//
//  Created by Santanu Koley on 24/07/18.
//  Copyright © 2018 Kode. All rights reserved.
//

import XCTest
@testable import BankTestApp

class NewsDeailsVCTests: XCTestCase {
    var detailsVC: NewsDetailsVC!
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.detailsVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailsVC") as! NewsDetailsVC
    }
    
    override func tearDown() {
        super.tearDown()
    }

    
    func testOutletConnection() {
        XCTAssertNotNil(detailsVC.textViewDetailsNews)
        XCTAssertNotNil(detailsVC.labelImageDesc)
        XCTAssertNotNil(detailsVC.newsBigImageView)

    }
    
}
