class SnippetsController < ApplicationController

  def create
    @snippet = Snippet.new(params_list)

    respond_to do |format|
      if @snippet.save && params[:user_id] == current_user.id
        format.json {render json: @snippet}
      else
        format.json {render status: :unprocessable_entity}
      end
    end
  end

  private

  def params_list
    params.require(:snippet).permit(:user_id, :project_id, :id, :text, :week)
  end

end
