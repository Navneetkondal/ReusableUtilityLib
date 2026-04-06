//
//  AppLifeCycle.swift
//  UIKITBasic
//
//  Created by Navneet on 22/01/26.
//

import UIKit
///#LIFE CYCLE Methods
//Step 1 -> AppDelegate      ->  didFinishLaunchingWithOptions
//Step 2 -> SceneDelegate    ->  willConnectTo
//Step 3 -> SceneDelegate    ->  sceneWillEnterForeground
//Step 4 -> SceneDelegate    ->  sceneDidBecomeActive
//Step 5 -> SceneDelegate    ->  sceneWillResignActive
//Step 6 -> SceneDelegate    ->  sceneDidEnterBackground
//Step 7 -> SceneDelegate    ->  sceneDidDisconnect
//Step 8 -> AppDelegate      ->  didDiscardSceneSessions
//Step 9 -> AppDelegate      ->  applicationWillTerminate

///#APPLICATION STATES
//NOTACTIVE
//ACTIVE
//RUNNING
//FORGROUND
//BACKROUND
//NOTRUNNING

///#ViewController Life Cycle Methods
//init()
//loadViewIfNeeded()
//loadView()
//viewDidLoad()
//viewWillAppear(_ animated: Bool)
//viewIsAppearing(_ animated: Bool)
//viewDidAppear(_ animated: Bool)
//didReceiveMemoryWarning() // method is called when the system determines that the amount of available memory is low.
//viewWillLayoutSubviews()
//viewDidLayoutSubviews() -> call when view bounds change
//viewDidAppear()
//viewWillTransition()
//viewWillDisappear(_ animated: Bool)
//viewDidDisappear(_ animated: Bool)
//deinit()

///#View Life Cycle Methods
//init(frame:) || init?(coder:)
//willMove(toSuperview newSuperview: UIView?)
//draw(_ rect: CGRect)
//didMoveToSuperview()
//didMoveToWindow()
//removeFromSuperview()

///# SwiftUI Life Cycle Methods
// init()
// onAppear
// .task
// onDisappear

///# SwiftUI Life Cycle In Detail
//Init
//State Update
//Body Computation
//Rendering & Layout
//View Activation
//Deinitialization

///# UIViewRepresentable (Protocol) Methods (integrating UIKit views within a SwiftUI)
//makeCoordinator()
//makeUIView(context: Context)  -> UILabel
//updateUIView(_ view: UILabel, context: Context)
//dismantleUIView(_:coordinator:)

///# UIViewControllerRepresentable (Protocol) Methods (integrating UIKit Controller within a SwiftUI)
//makeCoordinator()
//makeUIViewController(context: Context)  -> UILabel
//updateUIViewController(_ view: UILabel, context: Context)
//dismantleUIViewController(_:coordinator:)

///#Responder Chain Heirarchy
//UIResponder is a fundamental class in iOS that defines an interface for objects that respond to user events and system events
//NSObject >> UIResponder >> UIView >> (UIControl/UILabel.....)
//NSObject >> UIResponder >>  UIViewController >> UIWindow >> UIApplication >> UIApplicationDelegate

///#Key event handling methods
//touchesBegan(_:with:), touchesMoved(_:with:), and touchesEnded(_:with:)
///These methods handle touch events and allow you to respond to taps, drags, and other touch gestures.
//motionBegan(_:with:), motionEnded(_:with:), and motionCancelled(_:with:)
///These methods deal with motion events, such as shaking the device or responding to accelerometer data.
//gestureRecognizers property
///Allows you to attach gesture recognizers to views, enabling you to respond to complex gestures like pinches and swipes.
//canBecomeFirstResponder and becomeFirstResponder()
///Used to control the first responder status of a view.

///#View Rendering PipeLine


///#Point to pixel conversion
//pixels = points × UIScreen.main.scale

///#*   >>> Property Wrappers  >>>

///# @UIApplicationDelegateAdaptor
//To get access to AppDelegate functionality in SwiftUI, you should create a class that inherits from NSObject and UIApplicationDelegate
//class AppDelegate: NSObject, UIApplicationDelegate {
// add app delegate methods here
//}
//@UIApplicationDelegateAdaptor private var appDelegate: MyAppDelegate

///#@State
//Wrapping a reference type property as a @State keeps the object alive for the life cycle of a view.
///#@Binding

///#@StateObject

///#@ObservedObject

///#@GestureState

///#@Focused

///#@EnvironmentObject

///#@Environment

///#@Bindable

///#@Observed

///#@SceneStorage

///#@AppStorage


///#*   >>>  Accessibility Traits  >>>

//Module: In Xcode, a module (like a framework, library, or Swift package target) is a single unit of code distribution that can be built independently.
//Framework: A self-contained bundle of code and resources used to provide specific functionality. A single framework can only expose one module.
//Package: A package is essentially a collection of one or more modules (targets), which can include multiple frameworks.
//XCFramework: A binary package format provided by Xcode that allows bundling frameworks or libraries for multiple platforms (e.g., iOS device and iOS simulator) into a single distribution artifact.
