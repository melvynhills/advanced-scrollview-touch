class DotsView < BaseView

  def setup
    self.backgroundColor = UIColor.clearColor
  end

  def setupSubviews
  end

  def layoutSubviews
    super
  end

  def addDot
    dot = DotView.new
    diameter = rand(DotView::MAX_WIDTH - DotView::MIN_WIDTH) + DotView::MIN_WIDTH
    dot.bounds = CGRectMake(0, 0, diameter, diameter)
    addSubview(dot)
  end

  def arrangeDotsRandomly
    # rearrange randomly
    subviews.each do |dot|
      x = rand(width)
      y = rand(height)
      dot.center = CGPointMake(x, y)
    end
  end

  def arrangeDotsNeatly
    rx = 0
    ry = 0

    rw = DotView::MAX_WIDTH
    rh = DotView::MAX_WIDTH

    itemsPerRow = (width / rw)

    subviews.each_with_index do |dot, index|
      ix = index % itemsPerRow
      iy = (index / itemsPerRow).floor
      rx = (ix + 0.5) * rw
      ry = (iy + 0.5) * rh
      dot.center = CGPointMake(rx, ry)
      addSubview(dot)
    end
  end

  def rearrangeDotsNeatly
    # rearrange into grid
    dots = subviews.mutableCopy
    newDots = []

    rw = DotView::MAX_WIDTH
    rh = DotView::MAX_WIDTH

    ry = 0
    while ry <= height
      rx = 0
      while rx <= width
        r = CGRectMake(rx, ry, rw, rh)
        dots.each do |dot|
          p = dot.center
          contains = CGRectContainsPoint(r, p)
          if contains
            dots.delete(dot)
            newDots << dot
            break
          end
        end
        rx += 1
      end
      ry += DotView::MAX_WIDTH
    end

    newDots.each do |dot|
      addSubview(dot)
    end

    arrangeDotsNeatly
  end

  def rearrangeDotsNeatlyWithAnimation
    UIView.animateWithDuration(0.5, delay:0.0, usingSpringWithDamping:0.7, initialSpringVelocity:1.0, options:UIViewAnimationOptionCurveEaseInOut, animations:->{
      rearrangeDotsNeatly
    }, completion:nil)
  end

  def dotView
    @dotView ||= begin
      _view = DotView.new
      _view
    end
  end

end
