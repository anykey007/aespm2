class Reportings::Balance < Report
  def lines
     BalanceLine.all
  end
end
