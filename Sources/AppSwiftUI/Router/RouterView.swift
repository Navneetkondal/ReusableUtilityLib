//
//  File.swift
//  SwiftUIReusable
//
//  Created by Navneet on 31/03/26.
//

import Foundation
import SwiftUI

public struct RoutingView<Root: View, Routes: Routable> : View{
    
    @Binding var routes: [Routes]
    
    let root: () -> Root
    
    public init(routes: Binding<[Routes]>, root: @escaping () -> Root)  where Routes : Routable {
        self._routes = routes
        self.root = root
    }
    
    public var body: some View {
        NavigationStack(path: $routes) {
            root()
                .navigationDestination(for: Routes.self) { view in
                    view
                }
        }
    }
}
