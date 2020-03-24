class DepartmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_department, only: %i[edit update destroy]

  def index
    @departments = current_user.departments.all.page(params[:page]).per(2)
  end

  def new
    @department = current_user.departments.new
  end

  def edit; end

  def create
    @department = current_user.departments.new(department_params)
    if @department.save
      redirect_to departments_path, notice: 'Department was successfully created.'
    else
      render :new
    end
  end

  def update
    if @department.update(department_params)
      redirect_to departments_path, notice: 'Department was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @department.destroy
    redirect_to departments_path, notice: 'Department was successfully destroyed.'
  end

  private

  def set_department
    @department = current_user.departments.find(params[:id])
  end

  def department_params
    params.require(:department).permit(:name, :user_id)
  end
end