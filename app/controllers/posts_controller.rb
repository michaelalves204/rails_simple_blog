# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    posts
  end

  def show
    post
  end

  private

  def posts
    @posts ||= Post.all
  end

  def post
    @post ||= Post.find_by(sid: params[:id])

    return unless @post.nil?

    flash[:alert] = 'Post not found'
    render 'errors/not_found', status: :not_found
  end
end
