//
//  BackgroundView.swift
//  SwiftUIReusable
//
//  Created by Navneet on 31/03/26.
//

import SwiftUI

public struct BackgroudContainerView<Content: View>: View {
    
    let backgroundColor: Color
    let content: () -> Content // Property is a closure returning the generic Content

    
    public init(backgroundColor: Color,  @ViewBuilder content: @escaping () -> Content) {
        self.backgroundColor = backgroundColor
        self.content = content
    }
    
    public var body: some View {
        ZStack(alignment: .topLeading){
            backgroundColor.ignoresSafeArea()
            content()
        }
        
    }
}

