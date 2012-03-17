class Reportings::Finresult < Report
  def lines
     ReportingForms::FinresultLine.all
  end
end
