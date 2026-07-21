//
//  BackgroundView.swift
//  SwiftUIReusable
//
//  Created by Navneet on 31/03/26.
//

import SwiftUI
import CommonUtility

public struct BackgroudContainerView<Content: View>: View {
    
    let alignment: Alignment
    let backgroundColor: Color
    let content: () -> Content // Property is a closure returning the generic Content

    
    public init(alignment: Alignment = .topLeading, backgroundColor: Color,  @ViewBuilder content: @escaping () -> Content) {
        self.alignment = alignment
        self.backgroundColor = backgroundColor
        self.content = content
    }
    
    public var body: some View {
        ZStack(alignment: alignment){
            backgroundColor.ignoresSafeArea()
            content()
        }
        
    }
}

