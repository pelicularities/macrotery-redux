class MacrosController < ApplicationController
  # before_action :set_macros


def index
  @macro= Macro.all
end

def new
  @macro = Macro.new
end

def create
  macro= Macro.new(macro_params)
  macro.user = current_user
  if macro.save!
    redirect_to macros_path
  else
    @macro = Macro.new
    render :new
  end
end

def edit
end

def update
  @macro.update(macro_params)
  if @macro.save
    redirect_to profile_macros_path(@macro)
  else
    render :edit
  end
end

def destroy
  @macro.destroy
  redirect_to macros_path
end

private

# def set_macros
#   @macro= Macro.find(params[:id])
# end

def macro_params
  params.require(:macro).permit(:name, :protein, :carbs, :fats)
end

end
