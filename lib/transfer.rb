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
    
    if valid? != true || self.sender.balance < amount
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    elsif self.status != "complete"
      self.sender.deposit(-amount)
      self.receiver.deposit(amount)
      self.status = "complete"
    end
    
  end
  
  def reverse_transfer
    if self.status == "complete"
      self.sender.deposit(amount)
      self.receiver.deposit(-amount)
      self.status = "reversed"
    end
  end
  
  
end
