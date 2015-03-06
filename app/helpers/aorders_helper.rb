module AordersHelper

  def td_odometer(odobegin, odoend, outofcity, args={}, &block )
    classes='hoverable'
    classes+=' badodometer' if (odoend-odobegin-outofcity)>100 or (odoend-odobegin-outofcity)<0
    args[:class] = classes
    content_tag(:td, args, &block )
  end

end
