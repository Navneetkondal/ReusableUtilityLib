


import Foundation
import SwiftUI

@available(iOS 13.0, *)
public class HostingController<Content: View> : UIHostingController<Content>{
    
    public override init(rootView: Content){
        super.init(rootView: rootView)
    }
    
    @available(*, unavailable)
    @MainActor required init?(coder: NSCoder) {
        //fatalError("AltaHostingController has not been implemented in no: \(#line) for file : \(#file)")
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
