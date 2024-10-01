module ApplicationHelper
  def toast_class_for_type(type)
    case type
    when "notice"
      "bg-green-100 border-l-4 border-green-500 text-green-700"
    when "alert"
      "bg-red-100 border-l-4 border-red-500 text-red-700"
    else
      "bg-blue-100 border-l-4 border-blue-500 text-blue-700"
    end
  end
end
