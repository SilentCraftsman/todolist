class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      Rails.logger.error(@task.errors.full_messages)  # Enregistre dans les logs
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "Task was successfully deleted."
  end

  # Action show
  def show
    @task = Task.find(params[:id])
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :completed)  # Une seule version
  end
end
