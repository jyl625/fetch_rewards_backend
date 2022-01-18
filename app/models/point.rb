class Point < ApplicationRecord

  #Model validations
  validates :payer,   presence: true
  validates :points, presence: true
  validates :remaining_points, presence: true
  validates :timestamp, presence: true

  #To ensure that Point instance has a remaining_points value
  after_initialize :set_remaining_points

  #Sets Point instance's remaining_points value if it doens't excist already (for newly posted transaction)
  def set_remaining_points
    self.remaining_points ||= self.points
  end

  #Points::balance method definiton for returning remaining_points for each payer
  def self.balance
    #Using Rail's ActiveRecord query (similar to SQL query)
    self.group(:payer).sum(:remaining_points)
  end

  #Points::balance method definition for returning amount spent on each payer
  def self.spend(amount)
    #to keep track of which points to be spent
    points_spent = {} #ex. { <Point instance> => <points to be deducted> }
    amount_remaining = amount #to keep track of total amount of points that need to be spent

    #Loop through points db record one at a time and keep track of which points record need to be deducted
    i = 0
    until amount_remaining == 0
      #Query oldest transaction where there are points to be spent
      points_obj = self.where.not(remaining_points: 0)
                        .order(:timestamp)
                        .offset(i)
                        .limit(1)
                        .first

      #return nothing if there are not enough points to be spent
      return [] if points_obj.nil?

      #take the minimum of amount_remaining or each instance's remaining_points
      #to prevent over-spending points 
      amount_deducted = [amount_remaining, points_obj.remaining_points].min
      points_spent[points_obj] = amount_deducted

      amount_remaining -= amount_deducted

      i += 1
    end

    #executes point deduction and returns summary hash
    self.execute_deduction(points_spent)

  end

  private

  def self.execute_deduction(points_spent)
    summary_hash = Hash.new(0)
    points_spent.each do |points_obj, amount|
      #update database to reflect point deduction
      points_obj.update(remaining_points: points_obj.remaining_points - amount)
      #keep track of amount deducted for each payer
      summary_hash[points_obj.payer] -= amount
    end

    #converts hash to array for formatting
    summary_hash.map do |payer, amount|
      {payer: payer, points: amount}
    end
  end
end
