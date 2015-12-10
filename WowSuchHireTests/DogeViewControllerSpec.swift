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
            
            dogeVC = main.instantiateViewControllerWithIdentifier("dogeVC") as! DogeViewController
            
            UIApplication.sharedApplication().keyWindow?.rootViewController = dogeVC
        }

        describe("initial view") {
            it("shows a view labeled 'view'") {
                tester.waitForViewWithAccessibilityLabel("view")
            }
            
            it("shows the footer and its subviews") {
                tester.waitForViewWithAccessibilityLabel("footer")
                tester.waitForViewWithAccessibilityLabel("inputField")
                tester.waitForViewWithAccessibilityLabel("saveButton")
            }
            
            it("shows the tableView") {
                tester.waitForViewWithAccessibilityLabel("tableView")
            }
        }
        
        describe("text field") {
            it("is not blocked by the keyboard when selected") {
                tester.tapViewWithAccessibilityLabel("inputField")
                tester.waitForKeyInputReady()
                tester.waitForViewWithAccessibilityLabel("inputField")
            }
        }
        
        describe("tapping 'Save'") {
            it("creates a new cell with the content of the text field") {
                let ricky = "never gonna give you up"
                
                tester.tapViewWithAccessibilityLabel("inputField")
                tester.waitForKeyInputReady()
                tester.enterText(ricky, intoViewWithAccessibilityLabel: "inputField")
                tester.tapViewWithAccessibilityLabel("saveButton")
                
                // it's weird to reach into the data like this, but i'm unsure how to give the new cell a unique identifier for KIF to interact with it. i could probably solve this in a better way given more time
                let lastMessage = dogeVC.messages.last!
                let lastContent = lastMessage["content"] as! String
                
                expect(lastContent).to(match(ricky))
            }
            
            it("does not create a new cell if the text field is empty") {
                tester.clearTextFromViewWithAccessibilityLabel("inputField")
                tester.tapViewWithAccessibilityLabel("saveButton")
                
                let lastMessage = dogeVC.messages.last!
                let lastContent = lastMessage["content"] as! String
                
                expect(lastContent).toNot(beEmpty())
            }
        }
    }
}
