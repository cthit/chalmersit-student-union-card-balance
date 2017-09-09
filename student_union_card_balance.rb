require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist_debug do |app|
  Capybara::Poltergeist::Driver.new(app, :inspector => true, :js_errors => false)
end

class StudentUnionCardBalance
  include Capybara::DSL

  CARD_BALANCE_URL = "https://kortladdning3.chalmerskonferens.s/"

  def initialize
    Capybara.default_driver = :poltergeist_debug
  end

  def student_union_card_balance(number)
    begin
      visit CARD_BALANCE_URL
    rescue Capybara::Poltergeist::StatusFailError
      raise "Kortladdning service unreachable."
    end

    begin
      fill_in 'txtCardNumber', with: "#{number}"
      click_button('btnNext')
    rescue Capybara::ElementNotFound
      raise "Failed to submit number. Service might be down."
    end

    sleep 0.5
    begin
      {
        balance: find(:id, 'txtPTMCardValue').text,
        name: find(:id, 'txtPTMCardName').text,
        number: find(:id, 'txtPTMCardNumber').text
      }
    rescue Capybara::ElementNotFound
      raise "Invalid card number."
    end
  end
end
