class Reportings::Labor < Report
  def lines
     ReportingForms::LaborLine.all
  end
end
