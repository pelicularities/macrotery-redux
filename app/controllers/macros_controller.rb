class MacrosController < ApplicationController
  before_action :set_macro, only: [:edit, :update, :destroy]


def new
  @macro= Macros.new
end

def create
  macro= Macros.new(macro_params)
  macro.user = current_user
  if macro.save
    redirect_to macros_path
  else
    render :new
  end
end

def edit
end

def update
  @macro.update(macro_params)
  if @macro.save
    redirect_to macros_path(@macro)
  else
    render :edit
  end
end

def destroy
  @macro.destroy
  redirect_to macros_path
end

private

def set_macro
  @macro= Macros.find(params[:id])
end

def macro_params
  params.require(:macro).permit(:protein, :carb, :fat)
end

end
