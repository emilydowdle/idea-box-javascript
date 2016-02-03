class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found

  def not_found
    render json: { message: "Record not found" }
  end

  def find_idea
    Idea.find(idea_params[:id])
  end

  def idea_params
    params.permit(:id, :title, :body, :quality, :direction)
  end
end
