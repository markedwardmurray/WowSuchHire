//
//  DogeViewControllerSpec.swift
//  WowSuchHire
//
//  Created by Mark Murray on 12/10/15.
//  Copyright © 2015 markedwardmurray. All rights reserved.
//

import Quick
import Nimble
import KIF
@testable import WowSuchHire

class DogeViewControllerSpec: QuickSpec {
    override func spec() {
        let tester = self.tester()
        
        var dogeVC = DogeViewController()
        
        beforeEach {
            let main = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = main.instantiateViewControllerWithIdentifier("dogeVC")
            
            
            dogeVC = vc as! DogeViewController
            
            UIApplication.sharedApplication().keyWindow?.rootViewController = dogeVC
        }

        
        describe("DogeVC") {
            describe("") {
                it("") {
                    tester.waitForViewWithAccessibilityLabel("view")
                }
            }
        }
    }
}
