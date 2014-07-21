class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    window.makeKeyAndVisible
    true
  end

  def window
    @window ||= begin
      _window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
      _window.rootViewController = rootController
      _window
    end
  end

  def rootController
    @rootController ||= begin
      _rootController = RootController.new
      _rootController
    end
  end

end
