//
//  NavigationRouterDataSource.swift
//  SwiftUIReusable
//
//  Created by Navneet on 31/03/26.
//

import Foundation

protocol NavigationRouterDataSource: AnyObject{
    
    associatedtype Destination: Routable
    
    var routerStack: [Destination] { get set }
    
    func push(to path: Destination)
    
    @discardableResult
    func pop() -> Destination?
    
    func popTo(path: Destination)
    
    func popToRoot()
    
    func replace(with path: [Destination])
    
    func root(for path: Destination)
}

extension NavigationRouterDataSource{
    func push(to path: Destination){
        routerStack.append(path)
    }
    
    @discardableResult
    func pop() -> Destination?{
        routerStack.removeLast()
    }
    
    func popTo(path: Destination){
        guard let pathIndex = routerStack.lastIndex(of: path) else {
            return
        }
        routerStack.remove(at: pathIndex)
    }
    
    func popToRoot(){
        routerStack = []
    }
    
    func replace(with paths: [Destination]){
        routerStack = []
    }
    
    func root(for path: Destination) {
        routerStack = [path]
    }
}
