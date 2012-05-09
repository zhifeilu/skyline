class Skyline::AuthenticationsController < Skyline::ApplicationController
  layout false

  def new
  end
  
  def create
    if user = Skyline::Configuration.user_class.find_by_id(request.env["omniauth.auth"]["uid"])
      reset_session
      session[:skyline_user_identification] = user.identification
      redirect_to skyline_root_path
    else
      messages.now[:error] = t(:error, :scope => [:authentication,:create,:flashes])
      render :action => :new
    end    
  end
  
  def destroy
    session[:skyline_user_identification] = nil
    redirect_to new_skyline_authentication_path
  end
  
  def fail
    messages.now[:error] = t(:error, :scope => [:authentication,:create,:flashes])
    render :action => :new
  end
  
  protected
  
  def protect?
    self.action_name == "destroy"
  end
end
