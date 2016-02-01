class Api::V1::IdeasController < ApplicationController
  respond_to :json

  def index
    respond_with Idea.all
  end

  def show
    respond_with find_idea
  end

  def create
    drug = Drug.new(strong_params)
    drug.save
    respond_with Idea.all
  end

  def destroy
    idea = find_idea
    drug.destroy
    respond_with Idea.all
  end

  private

  def strong_params
    params.permit(:id, :title, :body, :quality)
  end

  def find_idea
    Idea.find(strong_params)
  end
end
