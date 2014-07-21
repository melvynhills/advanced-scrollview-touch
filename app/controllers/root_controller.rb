class RootController < BaseController

  def loadView
    self.view = RootView.new
  end

  def prefersStatusBarHidden
    true
  end

  def viewDidLoad
    super
  end

  def viewDidAppear(animated)
    super
    addDots
    setupGestures

    view.scrollView.contentOffset = CGPointMake(0, 300)
  end

  def addDots
    20.times do
      view.dotsView.addDot
    end
    view.dotsView.rearrangeDotsRandomly

    20.times do
      view.scrollView.dotsView.addDot
    end
    view.scrollView.dotsView.rearrangeDotsNeatly
  end

  def setupGestures
    view.addGestureRecognizer(view.scrollView.panGestureRecognizer)

    # mimic UIScrollView.delayContentTouches behavior on a regular view
    touchDelay = TouchDelayRecognizer.alloc.initWithTarget(nil, action:nil)
    view.dotsView.addGestureRecognizer(touchDelay)

    setupDotsGesturesForView(view.dotsView)
    setupDotsGesturesForView(view.scrollView.dotsView)
  end

  def setupDotsGesturesForView(dotsView)
    dotsView.subviews.each do |dot|
      longPressGestureRecognizer = UILongPressGestureRecognizer.alloc.initWithTarget(self, action:"dotWasLongPressed:")
      # prevent long press canceling current touch state
      longPressGestureRecognizer.cancelsTouchesInView = false
      longPressGestureRecognizer.minimumPressDuration = 0.3
      longPressGestureRecognizer.delegate = self
      dot.addGestureRecognizer(longPressGestureRecognizer)
    end
  end

  def dotWasLongPressed(gestureRecognizer)
    dot = gestureRecognizer.view
    case gestureRecognizer.state
    when UIGestureRecognizerStateBegan    then grabDot(dot, withGesture: gestureRecognizer)
    when UIGestureRecognizerStateChanged  then moveDot(dot, withGesture: gestureRecognizer)
    when UIGestureRecognizerStateEnded    then dropDot(dot, withGesture: gestureRecognizer)
    end
  end

  def grabDot(dot, withGesture: gestureRecognizer)
    # stop panning
    view.scrollView.panGestureRecognizer.enabled = false
    view.scrollView.panGestureRecognizer.enabled = true

    # transfer dot to main view
    dot.center = view.convertPoint(dot.center, fromView:dot.superview)
    view.addSubview(dot)

    UIView.animateWithDuration(0.2, animations:->{
      dot.setGrabbed(true)
      moveDot(dot, withGesture: gestureRecognizer)
    })

    view.scrollView.dotsView.rearrangeDotsNeatlyWithAnimation
  end

  def moveDot(dot, withGesture: gestureRecognizer)
    dot.center = gestureRecognizer.locationInView(dot.superview)
  end

  def dropDot(dot, withGesture: gestureRecognizer)
    UIView.animateWithDuration(0.2, animations:->{
      dot.setGrabbed(false)
    })

    # transfer dot to main dots view or drawer dots view
    locationInDrawer = gestureRecognizer.locationInView(view.scrollView.dotsView)
    isInDrawer = CGRectContainsPoint(view.scrollView.dotsView.bounds, locationInDrawer)
    if isInDrawer
      view.scrollView.dotsView.addSubview(dot)
    else
      view.dotsView.addSubview(dot)
    end
    dot.center = view.convertPoint(dot.center, toView:dot.superview)

    view.scrollView.dotsView.rearrangeDotsNeatlyWithAnimation
  end

  # UIGestureRecognizerDelegate

  def gestureRecognizer(gestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer)
    # allow panning during long presses
    if otherGestureRecognizer == view.scrollView.panGestureRecognizer
      return true
    end
    false
  end

end
