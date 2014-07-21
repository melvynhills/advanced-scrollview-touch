class BaseView < UIView

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
    # implement me
  end

  def setupSubviews
    # implement me
  end

end
