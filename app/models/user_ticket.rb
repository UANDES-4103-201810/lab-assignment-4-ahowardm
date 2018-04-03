class UserTicket < ApplicationRecord
  belongs_to :user
  belongs_to :ticket
  validate :user_cannot_buy_if_in_debt , :ticket_cannot_be_bought_after_start_date


  # The User can’t buy any tickets if there is at least one user’s ticket that hasnt been paid.
  def user_cannot_buy_if_in_debt
    user_tickets_from_user = UserTicket.where(user: self.user)
    user_tickets_from_user.each do |tkts|
      if tkts.paid == false
        errors.add(:user, "user has an unpaid ticket" )
      end
    end
  end

  # No ticket can be bought after the start date of the event.
  def ticket_cannot_be_bought_after_start_date
    event_start_date = self.ticket.event.start_date
    if self.time.to_date > event_start_date
      errors.add(:time, "ticket cannot be bought after start date of event" )
    end
  end
end
