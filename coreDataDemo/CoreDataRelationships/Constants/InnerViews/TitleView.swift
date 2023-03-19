//
//  TitleView.swift
//  coreDataDemo
//
//  Created by Ankush on 18/03/23.
//

import Foundation
import SwiftUI

struct TitleView: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .padding(.top)
            .modifier(TitleViewModifier())
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView(title: "Business Name:")
    }
}
