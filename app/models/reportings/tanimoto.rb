class Reportings::Tanimoto < Report
  def lines
     ReportingForms::Tanimoto.all
  end

  def compare_tanimoto(other_report)
  	general_count = 0
  	values.each_index do |i|
  		if(values[i].value1==other_report.values[i].value1)
  			general_count+=1
  		end
  	end
  	k = (general_count+0.0)/(values.length*2-general_count)
  end

end
