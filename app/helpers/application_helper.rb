module ApplicationHelper
  def first_row_span_class index
    "no-left-margin" if index % 4 == 0
  end
end
