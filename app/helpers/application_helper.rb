module ApplicationHelper 
  def my_form_for(record, options={}, &proc)
    form_for(record, options.merge!({builder:FormBuilder}), &proc)
  end
end
