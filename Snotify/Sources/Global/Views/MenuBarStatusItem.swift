//  Copyright © 2019 Snotify. All rights reserved.

import Cocoa

class MenuBarStatusItem {
    static var shared = MenuBarStatusItem()
    var statusItem: NSStatusItem?

    private init() {}

    func instantiateStatusItem(target: AnyObject?, action: Selector?) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.image = NSImage(named: NSImage.Name.menuBarIcon)?.resized(to: NSSize(width: 25, height: 25))
        statusItem?.button?.target = target
        statusItem?.button?.action = action
    }
}
