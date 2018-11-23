class MainController < ApplicationController

	def index

		if admin_signed_in? || usuario_signed_in?
      redirect_to props_url
    end

	end
end
