class OrdertimeValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    res=true
    if value< record.ftime
      record.errors[attribute] << (options[:message] || 'Время "по" должно быть больше "с"')
      res=false
    end
    res
  end
end