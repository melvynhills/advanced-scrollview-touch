class ScrollView < UIScrollView

  def init
    initWithFrame(CGRectZero)
  end

  def initWithFrame(frame)
    super
    if self
      setup
      setupSubviews
    end
    self
  end

  def setup
    self.pagingEnabled = true
    self.alwaysBounceVertical = true
    self.showsVerticalScrollIndicator = false
    self.showsHorizontalScrollIndicator = false
    self.decelerationRate = UIScrollViewDecelerationRateFast
  end

  def setupSubviews
    addSubview(drawer)
    drawer.addSubview(dotsView)
  end

  def layoutSubviews
    super
    drawer.frame = CGRectMake(0, -height, width, height + 300)
    dotsView.frame = CGRectMake(0, height, width, 300)
    self.contentSize = CGSizeMake(width, height + 300)
  end

  def hitTest(point, withEvent:event)
    hitView = super
    # let direct touches go through this view
    if hitView == self
      return nil
    end
    hitView
  end

  def drawer
    @drawer ||= begin
      _view = BaseView.new
      _view.backgroundColor = UIColor.colorWithWhite(0.0, alpha:0.7)
      _view
    end
  end

  def dotsView
    @dotsView ||= begin
      _view = DotsView.new
      _view
    end
  end

end
