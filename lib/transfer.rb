require 'pry'
class Transfer
  attr_accessor :sender, :receiver, :amount, :status
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end
  
  def valid?
    sender.valid? && receiver.valid?
  end
  
  def execute_transaction
    
    # shouldn't execute if sender or receiver has an invalid account
    if valid? != true
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    # shouldn't execute if the sender's balance is less than the transfer amount
    elsif self.sender.balance < amount
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    # as long as the transaction hasn't been completed yet...
    elsif self.status != "complete"
      self.sender.deposit(-amount)
      self.receiver.deposit(amount)
      self.status = "complete"
    end
    
  end
  
  def reverse_transfer
    # should only execute on transfers that have already been completed
    if self.status == "complete"
      self.sender.deposit(amount)
      self.receiver.deposit(-amount)
      self.status = "reversed"
    end
  end
  
  
end
