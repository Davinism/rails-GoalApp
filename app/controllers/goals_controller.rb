class GoalsController < ApplicationController
  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      redirect_to user_url(@goal.user)
    else
      flash.now[:errors]=@goal.errors.full_messages
      render :new
    end

  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal && @goal.update(goal_params)
      redirect_to user_url(@goal.user)
    else
      flash.now[:errors]=@goal.errors.full_messages
      render :edit
    end

  end

  def show
    @goal = Goal.find(params[:id])
  end

  def destroy
    @goal = Goal.find(params[:id])

    if @goal.destroy
      redirect_to user_url(@goal.user)
    else
      flash[:errors] = ["This goal must stay!"]
      redirect_to goal_url(@goal)
    end
  end

  private
  def goal_params
    params.require(:goal).permit(:description, :user_id, :privacy, :progress)
  end
end
