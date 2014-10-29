module AnalyticsHelper
  def add_event(category, action, label)
    (session[:events] ||= []).tap do |s|
      s.push([category, action, label])
    end
  end

  def each_event(&block)
    (session[:events] || []).each do |(category, action, label)|
      yield(category, action, label)
    end
    session[:events] = []
  end
end
