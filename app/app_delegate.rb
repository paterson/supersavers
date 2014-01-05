class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    documents_path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).first
  	NanoStore.shared_store = NanoStore.store(:file, documents_path + "/nano.db")
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
  	tab
  	@window.rootViewController = @tab
  	@window.makeKeyAndVisible

    true
  end

  def tab
  	tabs = [
      {
        title: "Home",
        navigationController: true,
        viewController: HomeController.new
      },
      {
        title: "My Lodgements",
        navigationController: true,
        viewController: LodgementsController.new
      },
      {
        title: "Gallery",
        navigationController: true,
        viewController: GalleryController.alloc.initWithCollectionViewLayout(UICollectionViewFlowLayout.new)
      },
      {
        title: "Info",
        navigationController: true,
        viewController: InfoController.new
      },
      {
        title: "Facebook",
        navigationController: true,
        viewController: FacebookController.new
      }
    ]
    @tab ||= MotionTab::TabBar.createTabBarControllerFromData(tabs)
    MotionTab::TabBar.select(@tab, tag: 0)
	end
end
