class SessionsController < Devise::SessionsController
  before_action :authenticate_user!

  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end
end
