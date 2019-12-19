//  Copyright © 2019 Snotify. All rights reserved.

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    let popover = NSPopover()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        MenuBarStatusItem.shared.instantiateStatusItem(target: self, action: #selector(displayMenu(_:)))
        instantiateFirstViewCtrl()
    }
    
    @objc
    private func displayMenu(_ sender: Any?) {
        popover.isShown ? closePopoverView(sender: sender): showPopoverView(sender: sender)
    }
    
    private func showPopoverView(sender: Any?) {
        if let button = MenuBarStatusItem.shared.statusItem?.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    private func closePopoverView(sender: Any?) {
        popover.performClose(sender)
    }

    private func instantiateFirstViewCtrl() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let viewCtrlIdentifier = "\(OrdersListViewController.self)"
        if let viewcontroller = storyboard.instantiateController(withIdentifier: viewCtrlIdentifier) as? OrdersListViewController {
            popover.contentViewController = viewcontroller
            popover.behavior = NSPopover.Behavior.transient;
        }
    }
}

