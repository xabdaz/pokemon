
import UIKit
import ModuleCore

class SplashScreenVC: BaseViewController {
    private let viewModel: SplashScreenViewModel
    init(viewModel: SplashScreenViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = ThemeManager.color.primary
        self.viewModel.setupData()
    }
}
