class BaseController < UIViewController

  def viewDidLoad
    super
    puts "#{self.class}::viewDidLoad"
  end

  def viewWillAppear(animated)
    super
    puts "#{self.class}::viewWillAppear(#{animated})"
  end

  def viewDidAppear(animated)
    super
    puts "#{self.class}::viewDidAppear(#{animated})"
  end

  def viewWillDisappear(animated)
    super
    puts "#{self.class}::viewWillDisappear(#{animated})"
  end

  def viewDidDisappear(animated)
    super
    puts "#{self.class}::viewDidDisappear(#{animated})"
  end

end
