import XCTest
import SnapshotTesting
@testable import MoviesApp

final class LoginViewControllerSnapshotTests: XCTestCase {

    func testLoginViewController() {
        let viewController = LoginViewController(viewModel: LoginViewModel())

        assertSnapshot(matching: viewController, as: .image, record: false)
      }
}
