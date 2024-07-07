class UsersController < ApplicationController
  before_action :require_user_logged_in, only: %i[ reject_loan ]
  def index
  end

  def new
    @user  = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      redirect_to new_session_path, flash: { notice: 'Sign up successfully' }
    else  
      flash[:notice] = 'Something went wrong'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @wallet_balance = @user.wallet.balance.to_i
    @open_loan = Loan.open_loans(current_user.id).count
    @closed_loan = Loan.closed_loans(current_user.id).count
  end

  def confirm_loan
    @loan = Loan.find(params[:id])
    @admin_user =  User.find_by(admin: true)
    if @loan.update(state: 'open') &&  @admin_user.wallet.balance >= @loan.amount
      @loan.user.wallet.update(balance: @loan.user.wallet.balance + @loan.amount)
      @admin_user.wallet.update(balance: @admin_user.wallet.balance - @loan.amount)
      InterestCalculatorJob.perform_async(@loan.id)
      DebitLoanJob.perform_async(@loan.id)
      redirect_to root_path, flash: { notice:  'Loan confirmed and amount credited to your wallet.' }
    end
  end

  def reject_loan
    @loan = Loan.find(params[:id])
    if @loan.update(state: 'rejected')
      redirect_to root_path, flash: { notice: 'Loan rejected.' }
    else
      redirect_to root_path, flash: { notice: 'Unable to reject loan.' }
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
