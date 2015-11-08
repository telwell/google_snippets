class SubscriptionsController < ApplicationController

  def create
    @subscription = Subscription.new(params_list)
  
    respond_to do |format|
      if @subscription.save && params[:user_id] == current_user.id
        format.json {render json: @subscription}
      else
        format.json {render status: :unprocessable_entity}
      end
    end
  end

  def destroy

    @subscription = Subscription.where(user_id: params[:user_id]).whhere(project_id: params[:project_id])
 
    respond_to do |format|
      if @subscription.destroy && params[:user_id] == current_user.id
        format.json {render json: @subscription}
      else
        format.json {render status: :unprocessable_entity}
      end
    end
  end

  private

  def params_list
    params.require(:project).permit(:project_id, :user_id)
  end
end
