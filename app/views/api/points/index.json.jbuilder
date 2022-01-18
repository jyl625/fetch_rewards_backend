@points_balance.each do |payer, balance|
  json.set! payer do
    balance
  end
end