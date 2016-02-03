class Api::V1::IdeasController < ApplicationController
  respond_to :json

  def index
    ideas = Idea.order
    respond_with ideas
  end

  def show
    respond_with find_idea
  end

  def create
    idea = Idea.new(idea_params)
    idea.save
    respond_with :api, :v1, idea
  end

  def update
    idea = find_idea
    idea.update(idea_params)
    respond_with idea, json: idea
  end

  def destroy
    idea = find_idea
    idea.destroy
    respond_with :api, :v1, idea
  end

  private


end
