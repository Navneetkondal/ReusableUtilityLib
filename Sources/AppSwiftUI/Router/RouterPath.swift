//
//  File.swift
//  SwiftUIReusable
//
//  Created by Navneet on 31/03/26.
//

import Foundation
import SwiftUI

public class RouterPath<Routes: Routable>: NavigationRouterDataSource {
    
    typealias Destination = Routes
    
    @Published var routerStack: [Routes] = []
    
    public init(_ stack: [Routes]) where Routes : Routable{
        self.routerStack = stack
    }
}
