class Api::V1::IdeasController < ApplicationController
  respond_to :json

  def index
    respond_with Idea.all
  end

  def show
    respond_with find_idea
  end

  def create
    idea = Idea.new(strong_params)
    idea.save
    redirect_to api_v1_ideas_path
  end

  def update
    idea = find_idea
    idea.update(strong_params)
    redirect_to api_v1_ideas_path
  end

  def destroy
    idea = find_idea
    idea.destroy
    redirect_to api_v1_ideas_path
  end

  private

  def strong_params
    params.permit(:id, :title, :body, :quality)
  end

  def find_idea
    Idea.find(strong_params[:id])
    # rescue ActiveRecord::RecordNotFound

  end
end
