class Reportings::Plan < Report
  def lines
     ReportingForms::PlanLine.all
  end
end
