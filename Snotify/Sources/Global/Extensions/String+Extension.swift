//Copyright © 2019 Snotify. All rights reserved.

import Foundation

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    public func replaceOccurrences(of targets: [String], with replacements: [String]) -> String {
        var text = self
        for (target, replacement) in zip(targets, replacements) {
            text = text.replacingOccurrences(of: target, with: replacement)
        }
        return text
    }
}
