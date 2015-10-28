class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  def index
    @post = Post.new
    @posts = Post.paginate(:page => params[:page])
  end

  def search
    @posts
    if params[:content].blank?
      flash[:danger] = "Search cannot be blank."
      redirect_to root_url and return
    end

    condition = params[:condition] ||= Array.new
    type = params[:type] ||= Array.new
    username = params[:username] if params.has_key?(:username)
    date = params[:date] ||= Array.new
    range = params[:range] ||= Array.new

    if !validate_date(date) || !validate_range(range)
      flash[:danger] = "Your input date was invalid"
      redirect_to root_url and return
    end

    ctr = condition.count == type.count ? condition.count : 0
    query = Array.new
    attrb = "content LIKE ? "
    query << "%#{params[:content]}%"

    if ctr > 0
      for i in 0..ctr-1
        if condition[i] == "and" || condition[i] == "or"
          if type[i] == "date"
            if date[i].blank?
              flash[:danger] = "Date can't be blank"
              redirect_to root_url and return
            end
            attrb  += "#{condition[i]} created_at #{range[i]} ? "
            query << date[i]
          elsif type[i] == "user"
            if username[i].blank?
              flash[:danger] = "Username can't be blank"
              redirect_to root_url and return
            end
            attrb += "#{condition[i]} username = ? "
            query << username[i]
          else
            flash[:danger] = "Your input attribute was invalid"
            redirect_to root_url and return
          end
        else
          flash[:danger] = "Your input condition was invalid"
          redirect_to root_url and return
        end
      end
    end

    query.insert(0,attrb)

    @posts = query.empty? ? Post.find_substring(params[:content]) : Post.joins(:user).where(query)
    @posts = @posts.paginate(:page => params[:page])

    if @posts.any?
      flash.now[:success] = "Search results for #{params[:content]}"
    else
      flash.now[:danger] = "No results found for #{params[:content]}"
    end
  end

  protect_from_forgery with: :exception
  include SessionsHelper

  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    redirect_to root_url
    flash[:danger] = "Unauthorized access. Try again."
  end
  private

    def post_params
      params.require(:post).permit(:content, :condition, :type, :username, :range, :date)
    end

    def validate_range(range)
      range.each do |i|
        if !%w(<= >= =).include?(i)
          false
        end
      end
      true
    end

    def validate_date(date)
      date.each do |i|
        if (Date.parse(i) rescue ArgumentError) == ArgumentError
          false
        end
      end
      true
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def admin_user
      if !current_user.admin?
				flash[:danger] = "Unauthorized access. Try again."
				redirect_to root_url
			end
    end

    def store_location
      session[:return_to] = request.url
    end
end
