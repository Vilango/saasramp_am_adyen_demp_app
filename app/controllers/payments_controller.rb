class PaymentsController < ApplicationController
  include ActiveMerchant::Billing::Integrations
  
  protect_from_forgery :except => :hook
  
  
  # def index
  #   cur_order_id = "ORDER-ID-#{Time.new.to_i.to_s}"
  #   
  #   @data = {
  #     :merchantAccount => ADYEN_MERCHANT_ACCOUNT,
  #     :merchantReference => cur_order_id,   # The (merchant) reference for this payment.
  #     :price => "EUR 50".to_money, 
  #     :order_id => cur_order_id,
  #     :order_data => Base64.encode64("<p><b>Order Data</b></p><p>A brief description of the product</p>").gsub("\n",""),
  #     :shopper_email => "gerwin.brunner@gmail.com",
  #     :shopper_first_name => "Gerwin",
  #     :shopper_last_name => "Brunner",
  #     
  #     :shopperStatement => "Birkenbihl Sprachen - #{cur_order_id}",
  #     :shopperLocale => "de",
  #     :shopperReference => "1234567",
  #     
  #     :recurringContract => "RECURRING",
  #     
  #     :shared_secret => ADYEN_SHARED_SECRET,
  #     :skinCode => ADYEN_SKIN_CODE
  #   }
  #   
  # end
  
  def return
    #paypal calls this action to confirm payment
    @adyen_return = Adyen::Return.new(request.query_string, :shared_secret => ADYEN_SHARED_SECRET)
    
    ### check if retrun from server is valid...

    if @adyen_return.success?
      flash[:notice] = "Thank you! Your payment is processing now. This may take several minutes."
    else
      flash[:error] = "There was an error. Please verify your data and try again."
    end
        
    redirect_to account_path
  end
  
  def hook 
    notify = Adyen::Notification.new(request.raw_post)
    #save notification # state unprocessed
    
    
    #@payment = Payment.new(:item_id => notify.item_id, :amount => notify.amount,
    #    :payment_method => 'paypal', :txid => notify.transaction_id,
    #    :description => notify.params['item_name'], :status => notify.status,
    #    :test => notify.test?)
    #  @payment.save
  
  
    if notify.acknowledge # does nothing
      if notify.complete?
        # we have an  notification (AUTHORISATION) from an "AM integration" that we can map to a subscription
        
        # find subscription
        subscription_id = notify.merchant_reference.split('-').first
        sub = Subscription.find(subscription_id)
        
        sub.receive_notification(notify)
      else
        logger.error("Failed to verify Adyen's notification, please investigate: #{notify.inspect}")
      end
    end
    
    # process
     
    # change state to done!
#    render "[accepted]"
    render :nothing => true, :text => "[accepted]"
  end
  
end
