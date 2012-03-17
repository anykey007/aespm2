class Reportings::Balance < Report
  def lines
     ReportingForms::BalanceLine.all
  end
end
