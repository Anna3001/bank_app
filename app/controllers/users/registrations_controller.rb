# frozen_string_literal: true
require 'bcrypt'
class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
   #GET /resource/sign_up
   def new
     super
   
   end

  # POST /resource
   def create
     super

    end

    def after_sign_up_path_for(resource)
      # resource represents the newly created user
      
      puts "Generatings non repetitive combinations"
      resource.password_length = params[:user][:password].length
      resource.save
      # Generate all possible combinations of 3 to 5 indices
      all_combinations = []

      (5..(resource.password_length - 3)).each do |comb_length|
        all_combinations += (0...resource.password_length).to_a.combination(comb_length).to_a
      end
    
      shuffled_combinations = all_combinations.shuffle
      selected_combinations = shuffled_combinations.first(5)
    
      selected_combinations.each do |indices|
        result_string = create_combination_from_indices(params[:user][:password], indices)
        bcrypt_password = BCrypt::Password.create(result_string, cost: 15)
        indices_as_string = indices.join(',')
        combination = resource.combinations.create(hashed_combination: bcrypt_password, positions: indices_as_string)
      end

      generate_and_save_account_number(resource)
      generate_and_save_id_number(resource)
      generate_and_save_card_number(resource)
      
      root_path
    end

    def update_combinations(new_pass)
      current_user.combinations.destroy_all
      puts "Regenerating non-repetitive combinations"
      current_user.password_length = params[:user][:password].length
      current_user.save
      
      length_of_password = new_pass.length
      all_combinations = []

      (5..(length_of_password - 3)).each do |comb_length|
        all_combinations += (0...length_of_password).to_a.combination(comb_length).to_a
      end
    
      shuffled_combinations = all_combinations.shuffle
      selected_combinations = shuffled_combinations.first(5)
    
      selected_combinations.each do |indices|
        result_string = create_combination_from_indices(new_pass, indices)

        bcrypt_password = BCrypt::Password.create(result_string, cost: 15)

        indices_as_string = indices.join(',')
        combination = resource.combinations.create(hashed_combination: bcrypt_password, positions: indices_as_string)
      end
    end
    
    def create_combination_from_indices(password, indices)
      combination = indices.map { |index| password[index] }.sort.join('')
    end
    
    def create_combination_from_indices(input_string, indices)
      result = indices.map { |index| input_string[index] }.join
      return result
    end

  # GET /resource/edit
   def edit
    
     super
   end

  # PUT /resource
  #  def update
  #   super

  #   update_combinations(params[:user][:password])
  #  
  #  end

  def update
    resource = current_user

    if !resource.valid_password?(params[:user][:current_password])
      resource.errors.add(:current_password, "is incorrect.")
    end

      if params[:user][:password].present?
        entropy = calculate_entropy(params[:user][:password])
    
        if  params[:user][:password] != params[:user][:password_confirmation]
          resource.errors.add(:password_confirmation, "Password confirmation doesn't match the password.")
        elsif entropy < 3.4
          resource.errors.add(:password, "Please choose a stronger password.")
        else
          flash[:notice] = "Password updated successfully!"
        end
    
        Rails.logger.info("Password Entropy: #{entropy}")
      end
    
      if resource.errors.empty? && resource.update(account_update_params.slice(:email, :password))
        update_combinations(params[:user][:password])
        sign_in(resource_name, resource, bypass: true)
        redirect_to after_update_path_for(resource)
      else
        clean_up_passwords resource
        set_minimum_password_length
        render "edit"
      end
  end
  
   private

    def account_update_params
      params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
    end

    def generate_and_save_account_number(user)
      user.account_no = generate_unique_account_number
      user.save
    end

    def generate_unique_account_number
      loop do
        random_account_number = rand(10**26).to_s.rjust(26, '0')
        break random_account_number unless User.exists?(account_no: random_account_number)
      end
    end

    def generate_and_save_id_number(user)
      user.id_number = generate_unique_id_number
      user.save
    end
  
    def generate_unique_id_number
      loop do
        random_letters = ('A'..'Z').to_a.sample(3).join
        random_digits = rand(10**6).to_s.rjust(6, '0')
        id_number = "#{random_letters}#{random_digits}"
        break id_number unless User.exists?(id_number: id_number)
      end
    end

    def generate_and_save_card_number(user)
      user.card_number = generate_unique_card_number
      user.save
    end
    
    def generate_unique_card_number
      loop do
        random_card_number = rand(10**16).to_s.rjust(16, '0')
        break random_card_number unless User.exists?(card_number: random_card_number)
      end
    end

    def calculate_entropy(password)
      password_length = password.length

      character_counts = Hash.new(0)
      password.each_char { |char| character_counts[char] += 1 }

                                # Transform stats to probability
      probabilities = character_counts.transform_values { |count| count.to_f / password_length }

      # H = −∑pi⋅log2(pi)
      entropy = -probabilities.values.sum { |prob| prob * Math.log2(prob) }
      
      entropy.round(2) 
    end


  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  
end
