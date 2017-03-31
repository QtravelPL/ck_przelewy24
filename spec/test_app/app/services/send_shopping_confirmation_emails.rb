class SendShoppingConfirmationEmails

  def initialize( order_id )
    @order_id = order_id
  end

  def call
    # mailer logic
  end
end
