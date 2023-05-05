//
//  Fonts.swift
//  Restaurant
//
//  Created by Samson Lopez on 05/05/2023.
//

import Foundation
import SwiftUI

struct Fonts {
    static var displayFont: Font {
        return Font.custom("MarkaziText-Regular", size: 42).weight(.medium)
    }
    
    static func subTitleFont() -> Font {
        return Font.custom("MarkaziText-Regular", size: 32).weight(.medium)
    }
    
    static func leadText() -> Font {
        return Font.custom("Karla-Regular", size: 16).weight(.medium)
    }
    
    static func regularText() -> Font {
        return Font.custom("MarkaziText-Regular", size: 18)
    }
    
    static func sectionTitle() -> Font {
        return Font.custom("Karla-Regular", size: 18).weight(.black)
    }
    
    static func sectionCategories() -> Font {
        return Font.custom("Karla-Regular", size: 16).weight(.heavy)
    }
    
    static func paragraphText() -> Font {
        return Font.custom("Karla-Regular", size: 14)
    }
    
    static func highlightText() -> Font {
        return Font.custom("Karla-Regular", size: 14).weight(.medium)
    }
}
