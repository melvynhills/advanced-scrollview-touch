class UIView

  def x=(value)
    self.frame = CGRectMake(value, frame.origin.y, frame.size.width, frame.size.height)
  end

  def x
    frame.origin.x
  end

  def y=(value)
    self.frame = CGRectMake(frame.origin.x, value, frame.size.width, frame.size.height)
  end

  def y
    frame.origin.y
  end

  def width=(value)
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, value, frame.size.height)
  end

  def width
    frame.size.width
  end

  def height=(value)
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, value)
  end

  def height
    frame.size.height
  end

end
