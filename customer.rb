require 'httparty'
require 'pg'
require_relative "Models"
class Customer
    attr_reader :first_name ,:last_name, :pin
    attr_accessor :attempt
    
    

    def initialize(first_name,last_name,pin)
        conn = PG.connect(dbname:'learn',user:'postgres',password:'postgres',host:'localhost')


        @first_name = first_name

        @last_name = last_name

        @pin  = pin
        @attempt  =0
        @user_table = User.new(conn)
        @balance_table = CustomerBalances.new(conn)

       

        unless @user_table.customer?(first_name,last_name) 

            @user_table.insert(first_name,last_name,pin)
        end

        @id = @user_table.pull_id(first_name,last_name,pin)


    end

    def add_coin(coin_name)
        @balance_table.insert(@id,coin_name,0)


    end

    def deposit(coin_name,amount)
        balance = @balance_table.pull_balance(@id,coin_name)

        new_balance = amount.to_i+balance.to_i

        @balance_table.update_balance(@id,coin_name,new_balance)
    end

    def balance(coin_name)
        result = @balance_table.pull_balance(@id,coin_name)
        puts(result)

    end
    
    def withdraw(coin_name,amount)
        balance = @balance_table.pull_balance(@id,coin_name)
        new_balance =- amount.to_i+balance.to_i
        unless new_balance < 0

            @balance_table.update_balance(@id,coin_name,new_balance)
            return "New balance: #{new_balance}"
        else
            return 'INSUFFICIENT BALANCE'
        end
            
    end
    def view_real_time_data
        coins = @balance_table.pull_all_coin_names(@id)
        
        coins.each do |coin|
            
            response = HTTParty.get("https://api.coincap.io/v2/assets/#{coin}")

            parsed_data = JSON.parse(response.body)
            clean_data = parsed_data["data"]
            puts "#{coin } price : $#{clean_data["priceUsd"].to_i.round},Precent change for-24hr #{clean_data["changePercent24Hr"].to_i.round}%"
        end
    end

    def update_pin(new_pin)
        @pin=pin

        @user_table.update_pin(@id,new_pin)
    end





    

end