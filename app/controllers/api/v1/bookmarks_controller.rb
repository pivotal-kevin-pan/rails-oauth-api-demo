module Api::V1
  class BookmarksController < ApplicationController
    # before_filter :restrict_access
    doorkeeper_for :all
    respond_to :json

    def index
      respond_with Bookmark.all
    end

    def show
      respond_with Bookmark.find(params[:id])
    end

    def create
      respond_with Bookmark.create(bookmark_params)
    end

    def update
      respond_with Bookmark.update(bookmark_params)
    end

    def destroy
      respond_with Bookmark.destroy(params[:id])
    end

    private
      def bookmark_params
        params.require(:bookmark).permit(:title, :url)
      end
      def restrict_access
        api_key = ApiKey.find_by_access_token(params[:access_token])
        head :unauthorized unless api_key
      end
  end
end