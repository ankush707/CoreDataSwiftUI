//
//  ViewModifiers.swift
//  coreDataDemo
//
//  Created by Ankush on 17/03/23.
//

import Foundation
import SwiftUI

struct TitleViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .fontWeight(.semibold)
    }
}

struct TextFieldViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding(.all)
            .frame(height: 36.0)
            .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.83))
            .cornerRadius(6.0)
    }
}

struct ToolBarTextViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .font(.headline)
            .fontWeight(.semibold)
    }
}
    

struct ToolBarButtonViewModifier: ViewModifier {
    
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(6.0)
            .padding(.vertical, 10.0)
            .padding(.horizontal, 2.0)
            .background(color)
            .opacity(0.5)
            .cornerRadius(6.0)
    }
}

struct SaveViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.all)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .font(.title2)
            .fontWeight(.bold)
            .background(.cyan)
            .cornerRadius(8.0)
    }
    
}

struct HomeVstackModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.all)
            .background(.cyan)
            .cornerRadius(6.0)
            .padding(.horizontal, 10.0)
    }
}

struct HomeNameModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.black)
    }
}

struct HomeSubNamesModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .fontWeight(.regular)
            .foregroundColor(.white)
            .padding(.top, 4.0)
    }
}
