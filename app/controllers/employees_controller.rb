class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee, only: %i[edit update destroy]

  def index
    @employees = current_user.employees.all.page(params[:page]).per(4)
  end

  def new
    @employee = current_user.employees.new
  end

  def edit; end

  def create
    @employee = current_user.employees.new(employee_params)
    if @employee.save
      redirect_to employees_path, notice: 'Employee was successfully created.'
    else
      render :new
    end
  end

  def update
    if @employee.update(employee_params)
      redirect_to employees_path, notice: 'Employee was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @employee.destroy
    redirect_to employees_path, notice: 'Employee was successfully destroyed.'
  end

  private

  def set_employee
    @employee = current_user.employees.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name, :active, :department_id, :user_id)
  end
end