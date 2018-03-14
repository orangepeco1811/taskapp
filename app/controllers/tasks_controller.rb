class TasksController < ApplicationController

  def index

  @tasks = Task
    .by_kanryo(params[:kanryo])
    .paginate(page: params[:page], per_page: 5)
    .order('kanryo asc, kigen asc')

  @grid_no = 1
 
  if params[:page].present?
    @grid_no = (params[:page].to_i - 1) * 5 + 1
  end
 
  end

  def show
   @task = Task.find(params[:id])
  end

  def new
  @task = Task.new
  end
  def edit
  @task = Task.find(params[:id])
  end

  def create
  @task = Task.new(task_params)
  if @task.valid?
    if @task.kigen_str.present?
      @task.kigen = Date.new(
        @task.kigen_str[0..3].to_i,
        @task.kigen_str[4..5].to_i,
        @task.kigen_str[6..7].to_i)
    end
    @task.kanryo = false
 
    @task.save(validate:false)
 
    flash[:msg] = "登録しました。"
    redirect_to tasks_path
  else
    render "new"
  end
 
  end

def update
 
  @task = Task.find(params[:id])
 
  @task.assign_attributes(task_params)
 
  if @task.valid?
    if @task.kigen_str.present?
      @task.kigen = Date.new(
        @task.kigen_str[0..3].to_i,
        @task.kigen_str[4..5].to_i,
        @task.kigen_str[6..7].to_i)
    end
 
    @task.save(validate:false)
 
    flash[:msg] = "編集しました。"
 
    redirect_to tasks_path
  else
    render "edit"
  end
end
  def destroy
  @task = Task.find(params[:id])
  @task.destroy
    flash[:msg] = "削除しました。"
    redirect_to request.referer
 
  end
  
  def kanryo
 
    #idでTasksテーブルを取得
    @task = Task.find(params[:id])
 
    #kanryoにtrueをセット
    @task.kanryo = true
 
    #更新処理（update文発行）
    @task.save
 
    #呼び出し元URLへリダイレクト
    redirect_to request.referer
 
  end
  

  
 def task_params
  params.require(:task).permit(
    :name,
    :shosai,
    :kigen_str
  )
 end
  
  
end