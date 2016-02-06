import UIKit

extension UIColor {
    convenience init(rgbaValue: UInt32) {
        let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
        let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
        let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
        let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIColor {
    enum Name {
        /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#007aff"></span>
        /// Alpha: 100% <br/> (0x007affff)
        case Blue
        /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#5fdf00"></span>
        /// Alpha: 100% <br/> (0x5fdf00ff)
        case Green
        /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff2851"></span>
        /// Alpha: 100% <br/> (0xff2851ff)
        case Orange

        var rgbaValue: UInt32! {
            switch self {
            case .Blue: return 0x007affff
            case .Green: return 0x5fdf00ff
            case .Orange: return 0xff2851ff
            }
        }
    }

    convenience init(named name: Name) {
        self.init(rgbaValue: name.rgbaValue)
    }
}
