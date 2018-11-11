//
//  SafariExtensionHandler.swift
//  extension
//
//  Created by Artur Sterz on 10.10.18.
//  Copyright © 2018 Artur Sterz. All rights reserved.
//

import SafariServices

var resultsPasswords: [String]?

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        page.getPropertiesWithCompletionHandler { pageProperties in
            if messageName == "fillShortcutPressed" {
                let urlHost = pageProperties!.url?.host
                dispatchPasswordSearch(forURL: urlHost!, fromShortcut: true)
            }
        }
    }
    
    override func popoverWillShow(in window: SFSafariWindow) {
        window.getActiveTab { (activeTab) in
            activeTab!.getActivePage { (activePage) in
                activePage!.getPropertiesWithCompletionHandler { (pageProperties) in
                    let urlHost = pageProperties!.url?.host
                    dispatchPasswordSearch(forURL: urlHost!)
                }
            }
        }
    }
    
    override func popoverDidClose(in window: SFSafariWindow) {
        SafariExtensionViewController.shared.resetPopover()
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        return SafariExtensionViewController.shared
    }

}
