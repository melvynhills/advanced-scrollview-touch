class TouchDelayRecognizer < UIGestureRecognizer

  def initWithTarget(target, action:action)
    super
    if self
      self.delaysTouchesBegan = true
    end
    self
  end

  def touchesBegan(touches, withEvent:event)
    @timer = NSTimer.scheduledTimerWithTimeInterval(0.15, target:self, selector:"timerFired:", userInfo:nil, repeats:false)
  end

  def touchesEnded(touches, withEvent:event)
    failed
  end

  def touchesCancelled(touches, withEvent:event)
    failed
  end

  def timerFired(timer)
    failed
  end

  def failed
    self.state = UIGestureRecognizerStateFailed
  end

  def reset
    @timer.invalidate
    @timer = nil
  end

end
