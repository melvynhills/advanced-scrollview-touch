class DotView < BaseView

  MIN_WIDTH = 16
  MAX_WIDTH = 64

  COLORS = [
    UIColor.redColor,
    UIColor.orangeColor,
    UIColor.yellowColor,
    UIColor.greenColor,
    UIColor.blueColor,
    UIColor.cyanColor,
    UIColor.purpleColor,
    UIColor.magentaColor,
  ]

  def setup
    @defaultColor = getRandomColor
    @highlightColor = @defaultColor.darkerColor
    self.backgroundColor = @defaultColor
  end

  def layoutSubviews
    super
    layer.cornerRadius = width / 2.0
  end

  def pointInside(point, withEvent:event)
    rect = bounds
    r = layer.cornerRadius
    if r < 22.0
      rDiff = 22.0 - r
      rect = CGRectInset(rect, -rDiff, -rDiff)
    end
    CGRectContainsPoint(rect, point)
  end

  def getRandomColor
    COLORS[rand(COLORS.count)]
  end

  def setHighlighted(highlighted)
    self.backgroundColor = highlighted ? @highlightColor : @defaultColor
  end

  def setGrabbed(grabbed)
    if grabbed
      self.alpha = 0.8
      self.transform = CGAffineTransformMakeScale(1.2, 1.2)
    else
      self.alpha = 1.0
      self.transform = CGAffineTransformIdentity
    end
  end

  def touchesBegan(touches, withEvent:event)
    super
    setHighlighted(true)
  end

  def touchesMoved(touches, withEvent:event)
    super
  end

  def touchesEnded(touches, withEvent:event)
    super
    setHighlighted(false)
  end

  def touchesCancelled(touches, withEvent:event)
    super
    setHighlighted(false)
  end

end
