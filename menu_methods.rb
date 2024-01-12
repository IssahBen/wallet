require_relative "customer"
require 'pg'
require_relative 'Models' 


module MenuMethods

    def create_account
        puts "Enter your first name"

        first_name =  gets.chomp

        puts "Enter your first name"

        last_name = gets.chomp


        puts "Enter a pin for your account"

        pin  = gets.chomp

        customer = Customer.new(first_name,last_name,pin)
    end

    def login
        conn  = PG.connect(dbname:'learn',user:'postgres',password:'postgres',host:'localhost')
        puts "Enter first name"

        first_name = gets.chomp

        puts "Enter last_name"

        last_name = gets.chomp

        user  = User.new(conn)

        if  user.customer?(first_name,last_name)
            puts "Input pin"
            pin = gets.chomp
            if pin = user.pull_pin(first_name,last_name)
                return customer = Customer.new(first_name,last_name,pin)
            else
                puts "Invalid Pin"
            end
        else
            puts "Account Doesn't Exist"
            puts "Check credentials or Create Account "
        end
    end


    def deposit(customer)
       
             puts "Enter pin"

            pin = gets.chomp

            if  customer.pin ==  pin

            
                if customer.coin_list.empty?
                    puts "Add Asset"
                    return customer
                end
                puts "Enter name of asset"

                name = gets.chomp

                puts "Enter an amount"
                amount = gets.chomp
                customer.deposit(name,amount)
                customer
            else
                p "Invalid pin"

                customer.attempt += 1
                customer
            end
    
            
    end

    def withdraw(customer)

        puts "Enter pin"
        pin = gets.chomp

        unless customer.pin != pin
            
            if customer.coin_list.empty?
                puts "Add Asset"
                return customer
            end


            puts "Enter name of asset"

            name = gets.chomp
            puts "Enter an amount"
            amount=gets.chomp
            puts customer.withdraw(name,amount)
            customer
        else
            p "Invalid pin"

            customer.attempt += 1
            customer
        end

    end

    def view_balance(customer)
        puts "Enter pin"
        pin=gets.chomp
        
        puts "Input coin_ name"
        coin_name = gets.chomp

        unless customer.pin != pin
            if customer.coin_list.empty?
                puts "Add Asset"
                return customer
            end
              
            puts "Input coin_ name"
            
            coin_name = gets.chomp
            customer.balance(coin_name)
            customer
        else 
            p "Invalid pin"

            customer.attempt += 1
            customer
            
        end

    end

    def view_assets_data(customer)
        customer.view_real_time_data
    end

    def add_asset(customer)
        puts "Enter asset name"
        asset_name = gets.chomp
        customer.add_coin(asset_name)
        customer

    end
    def search(name)
             
            response = HTTParty.get("https://api.coincap.io/v2/assets/#{name.downcase}")
            
            parsed_data = JSON.parse(response.body)
            clean_data = parsed_data["data"]
            unless clean_data
               
                return p "Invalid input"
            end

            puts "#{name} price: $#{clean_data["priceUsd"].to_f.round(3)},Precent change for-24hr #{clean_data["changePercent24Hr"].to_f.round(3)}% Market Cap:#{clean_data["marketCapUsd"].to_f.round(3)} Rank:#{clean_data["rank"]}" 
    end
    
    def update_pin(customer)
        puts "Enter a first name"
        first_name=gets.chomp
        puts "Enter a last name"

        last_name = gets.chomp

        puts "Enter Old pin"

        pin=gets.chomp

        unless pin != customer.pin
            puts "Enter New pin"
            pin=gets.chomp
            customer.update_pin(pin)
            puts "Pin has been updated"
            
        else
            puts "Invalid pin"
        end
        customer
    end
    def delete_account(customer)
        customer.delete_user_account
        puts "Account  has been deleted\n You will be logged out  "
        
    end
        


end

