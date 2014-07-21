class UIColor

  def getHSBA
    h = Pointer.new(:float)
    s = Pointer.new(:float)
    b = Pointer.new(:float)
    a = Pointer.new(:float)
    if getHue(h, saturation:s, brightness:b, alpha:a)
      return [h.value, s.value, b.value, a.value]
    end
    return nil
  end

  def lighterColor
    hsba = getHSBA
    return self unless hsba
    h, s, b, a = hsba
    UIColor.colorWithHue(h, saturation:s, brightness:[b * 1.33, 1.0].min, alpha:a)
  end

  def darkerColor
    hsba = getHSBA
    return self unless hsba
    h, s, b, a = hsba
    UIColor.colorWithHue(h, saturation:s, brightness:b * 0.75, alpha:a)
  end

end
