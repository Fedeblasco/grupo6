class SubsController < ApplicationController

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.create(params.require(:sub).permit(:fecha_inicio, :fecha_fin, :prop_id))
    if @sub.save
      redirect_to subs_path
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def index
    @subs = Sub.all
  end

  def update
  end

end
