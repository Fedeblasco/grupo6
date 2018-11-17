class Admin::PropsController < ApplicationController

  def index

  @props = Prop.order(hotsale: :desc)

  end
end
