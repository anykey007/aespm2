class Reportings::Plan < Report
  def lines
     PlanLine.all
  end
end
