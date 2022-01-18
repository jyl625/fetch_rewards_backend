class Point < ApplicationRecord

  validates :payer,   presence: true
  validates :points, presence: true
  validates :remaining_points, presence: true
  validates :timestamp, presence: true

  after_initialize :set_remaining_points

  def set_remaining_points
    self.remaining_points ||= self.points
  end

  def self.balance
    self.group(:payer).sum(:remaining_points)
  end

  def self.spend(amount)
    points_spent = {}
    remaining_amount = amount

    i = 0
    until remaining_amount == 0
      points_obj = self.where.not(remaining_points: 0)
                        .order(:timestamp)
                        .offset(i)
                        .limit(1)
                        .first

      return [] if points_obj.nil?

      amount_deducted = [remaining_amount, points_obj.remaining_points].min
      points_spent[points_obj] = amount_deducted

      remaining_amount -= amount_deducted

      i += 1
    end

    summary_hash = Hash.new(0)
    points_spent.each do |points_obj, amount|
      points_obj.execute_point_deduction(amount)
      summary_hash[points_obj.payer] -= amount
    end

    summary_hash.map do |payer, amount|
      {payer: payer, points: amount}
    end
  end

  def execute_point_deduction(amount)
    self.update(remaining_points: self.remaining_points - amount)
  end
end
