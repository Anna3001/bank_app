
class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    random_delay  # DELAY

    @user = User.find_by(email: params[:email])
    @info = ""

    if(@user)
      if @user.failed_attempts >= 3
        @info = "sad"
      end  

      if @user.last_used_combination_positions.present?
        @combination = @user.combinations.find_by(positions: @user.last_used_combination_positions)
      else
        @combination = @user.combinations.sample
      end

      @l = @user.password_length
      @left = 20 - @user.password_length
    
      @user.update(last_used_combination_positions: @combination.positions)
    else
      @combination = Combination.new(positions: generate_random_positions(5, 8))
      @l = 20
      @left = 0
 
      @attempt = Attempt.find_or_create_by(email: params[:email]) do |attempt|
        attempt.count = 0
      end
      
      @attempt.save

      if (@attempt.count >= 3) 
        @info = "BLOCK THIS HACKERRRRRR"

        if @attempt
          @attempt.destroy
        end  
      end
    end

    super
  end

  # POST /resource/sign_in
  def create

    random_delay  # DELAY

    user = User.find_by(email: params[:user][:email])
    
    if (user)
      c = User.find_by(email: params[:user][:email]).combinations.find_by(positions: params[:user][:positions])

      if c && valid_combination?(c, params[:user][:password_chars].values)
        sign_in(user)
        reset_attempts(user)
        user.update(last_used_combination_positions: nil)
        redirect_to root_path, notice: 'Signed in successfully.'
      else
        puts "Incorrect Combination"
        p c
        lock_user(user)
      end
    else   
      @attempt = Attempt.find_by(email: params[:user][:email])

      @attempt.count += 1
      @attempt.save

      if (@attempt.count >= 3) 
        redirect_to request.referrer || root_path
      end
    end  

  end

  #lock user after 3 attempts
  def lock_user(user)
    user.failed_attempts +=  1
    if (user.failed_attempts >= 3)
      puts "User has been locked"
      user.lock_access!
      flash[:alert] = "User access locked."
      @info = "sad"
      user.send_reset_password_instructions
      redirect_to request.referrer || root_path
    end
    user.save
  end

  def reset_attempts(user)
    puts "Resetting failed attempts"
    user.failed_attempts = 0
    user.save
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected
  # Make our custom thing accessible
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:combination])
  end

  private

  def random_delay
    delay_seconds = rand(2..5)
    sleep(delay_seconds)
  end  

  def valid_combination?(combination, entered_chars)
    bcrypt = BCrypt::Password.new(combination.hashed_combination)

    entered_password = entered_chars.join('')

    bcrypt.is_password?(entered_password)
  end

  def generate_random_positions(min_length, max_length)
    length = rand(min_length..max_length)
    (0..19).to_a.sample(length).join(',')
  end

end
