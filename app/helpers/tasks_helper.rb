module TasksHelper
 
  def kanryo_tag(task)
    result = ""
    if task.kanryo == true
         result = '完了'
    else
      result = '<a class="btn btn-sm btn-primary" href="' + kanryo_task_path(task) + '">未完</a>'
    end
    result.html_safe
  end

 
   def kigen_format(kigen)
    result = ""
    if kigen.present?
      result = kigen.strftime("%Y/%m/%d")
    end
    result
   end
 
end

 