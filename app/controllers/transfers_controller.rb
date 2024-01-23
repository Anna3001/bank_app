class TransfersController < ApplicationController
    before_action :authenticate_user!

    def index
        # Paginacja dla przekazywanych przelewów
        @transfers_sent = current_user.transfers.paginate(page: params[:sent_page], per_page: 4)
    
        # Paginacja dla otrzymywanych przelewów
        @transfers_received = Transfer.where(receiver_account_number: current_user.account_no)
                                      .paginate(page: params[:received_page], per_page: 4)
      end
      

    def new
        @transfer = Transfer.new
    end

    def create
        @transfer = Transfer.new(transfer_params)

        if enough_balance? && @transfer.save
            
            if valid_receiver?
                transfer_money_to_receiver
            end 

            redirect_to root_path, alert: 'Transfer created successfully.'
        else
            flash.now[:alert] = 'Error creating transfer. Please fix the following issues:'
            render :new
        end
    end
    
      private
    
      def transfer_params
        params.require(:transfer).permit(:amount, :sender_account_number, :receiver_account_number,:user_id,:address,:name,:title)
      end

      def valid_receiver?
        receiver = User.find_by(account_no: @transfer.receiver_account_number)
        return receiver.present?
      end

      def transfer_money_to_receiver
        receiver = User.find_by(account_no: @transfer.receiver_account_number)
        receiver.money += @transfer.amount
        receiver.save
      end

      def enough_balance?
        if @transfer.amount.blank?
            @transfer.errors.add(:base, 'Amount cannot be blank')
            return false
        end

        user = User.find(transfer_params[:user_id])

        if user.money >= @transfer.amount
            user.money -= @transfer.amount
            user.save
            return true
        else
            @transfer.errors.add(:amount, 'Insufficient balance for the transfer')
        return false
    end

      end

end


 