module AnalyticsHelper
  def add_event(category, action)
    (session[:events] ||= []).tap do |s|
      s.push([category, action])
    end
  end

  def each_event(&block)
    (session[:events] || []).each do |(category, action, label)|
      yield(category, action)
    end
    session[:events] = []
  end
end
