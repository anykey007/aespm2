class Reportings::Plan < Report
  def lines
     ReportingForms::PlanLine.all
  end

  attr_accessor :code_028, :code_029


  after_initialize do |plan|
    plan.code_028 = values.by_code("028").first  if !values.by_code("028").first.nil?
    plan.code_029 = values.by_code("029").first  if !values.by_code("029").first.nil?
  end
end
