


import Foundation
import SwiftUI

@available(iOS 13.0, *)
public class HostingViewController<Content: View> : BaseViewController where Content : View{
    let hostingController: UIHostingController<Content>
    
    public init(rootView: Content){
        hostingController = UIHostingController(rootView: rootView)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    @MainActor required init?(coder: NSCoder) {
        fatalError("AltaHostingController has not been implemented in no: \(#line) for file : \(#file)")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSwiftUIView(hostingController)
    }
}

@available(iOS 13.0, *)
extension UINavigationController {
    
    public func push<T:View>(_ viewController : HostingController<T>, animated : Bool){
        self.pushViewController(viewController, animated: animated)
    }
    
    @available(iOS 13.0, *)
    public func push<T:View>(_ viewController : HostingViewController<T>, animated : Bool){
        self.pushViewController(viewController, animated: animated)
    }
}

extension UIViewController{
    func addSwiftUIView(_ controller: UIViewController){
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
