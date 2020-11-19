require_relative "bank_account.rb"

class Transfer
  attr_accessor :sender, :receiver, :amount, :status

  @@records = []

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if valid? && self.sender.balance >= self.amount && self.status == "pending"
      self.sender.balance -= amount
      self.receiver.balance += amount
      self.status = "complete"
      @@records << self
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    @@records.last.sender.balance += amount
    @@records.last.receiver.balance -= amount
    @@records.last.status = "reversed"
  end
end