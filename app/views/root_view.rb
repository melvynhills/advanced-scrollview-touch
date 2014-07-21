class RootView < BaseView

  def setup
    self.backgroundColor = UIColor.darkGrayColor
  end

  def setupSubviews
    addSubview(dotsView)
    addSubview(scrollView)
  end

  def layoutSubviews
    super
    dotsView.frame = bounds
    scrollView.frame = bounds
  end

  def dotsView
    @dotsView ||= begin
      _view = DotsView.new
      _view
    end
  end

  def scrollView
    @scrollView ||= begin
      _view = ScrollView.new
      _view
    end
  end

end
