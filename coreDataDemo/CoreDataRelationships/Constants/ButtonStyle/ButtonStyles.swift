//
//  ButtonStyles.swift
//  coreDataDemo
//
//  Created by Ankush on 17/03/23.
//

import Foundation
import SwiftUI

class CustomButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.2 : 1)
            .opacity(configuration.isPressed ? 0.5 : 1)
            .brightness(configuration.isPressed ? 0.05 : 0)
    }
}
