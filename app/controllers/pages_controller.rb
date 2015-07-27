class PagesController < ApplicationController
    before_filter :authenticate_user!, except: [:about, :contact]
      def admin
        @video = Video.new
      end

      def about
      end

      def contact
      end
     
     
end
