class Reportings::Tanimoto < Report
  def lines
     ReportingForms::Tanimoto.all
  end

  def count_one
    arr = values.map(&:value1)
    arr.delete(0)
    arr.size
  end

  def compare_tanimoto(other_report)
  	general_count = 0
  	values.each_index do |i|
  		if(values[i].value1==other_report.values[i].value1 && values[i].value1==1)
  			general_count+=1
  		end
  	end
  	k = ((general_count+0.0)/(count_one+other_report.count_one-general_count)).round(2)
  end

  def compare_tanimotos(report_ids)
    coefs = []
    report_ids.each do |id|
      report = Reportings::Tanimoto.find(id)
      general_count = 0
      values.each_index do |i|
        if(values[i].value1==report.values[i].value1 && values[i].value1==1)
          general_count+=1
        end
      end
      coef = ((general_count+0.0)/(count_one+report.count_one-general_count)).round(2)
      coefs << coef
    end
    Hash[*[report_ids,coefs].transpose.flatten]
  end

end
