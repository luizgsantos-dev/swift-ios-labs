  import SwiftUI
  import Firebase

  @main
  struct BolaoCopaApp: App {
      init() {
          let provider = AppCheckDebugProviderFactory()
          AppCheck.setAppCheckProviderFactory(provider)
          FirebaseApp.configure()
      }

      var body: some Scene {
          WindowGroup {
              ContentView()
          }
      }
  }

