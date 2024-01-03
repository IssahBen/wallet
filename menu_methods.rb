require_relative "customer"

module MenuMethods

    def self.create_account
        puts "Enter your first name"

        first_name=gets.chomp

        puts "Enter your first name"

        last_name=gets.chomp


        puts "Enter a pin for your account"

        pin=gets.chomp

        customer=Customer.new(first_name,last_name,pin)
    end

    def deposit(customer)
        puts "Enter name of asset"

        name=gets.chomp

        puts "Enter pin"

        pin=gets.chomp

        if  customer.pin ==  pin
            puts "Enter an amount"
            amount=gets.chomp
            customer.deposit(name,amount)
        end
        customer
    end

    def withdraw(customer)

        puts "Enter name of asset"

        name=gets.chomp

        puts "Enter pin"
        pin=gets.chomp

        unless customer.pin != pin
            puts "Enter an amount"
            amount=gets.chomp
            customer.withdraw(name,amount)
        end
        customer
    end

    def view_balance(customer)
        puts "Enter pin"
        pin=gets.chomp

        unless customer.pin != pin
            customer.balance
        end
    end

    def view_assets_data(customer)
        customer.view_real_time_data
    end

    def add_asset(customer)
        puts "Enter asset name"
        asset_name=gets.chomp
        customer.add_coin(asset_name)
        customer

    end
    def search(name)
             
            response=HTTParty.get("https://api.coincap.io/v2/assets/#{name.downcase}")
            
            parsed_data=JSON.parse(response.body)
            clean_data= parsed_data["data"]
            unless clean_data
                return p "Invalid input"
            end

            puts "price: $#{clean_data["priceUsd"].to_f.round(3)},Precent change for-24hr #{clean_data["changePercent24Hr"].to_f.round(3)}% Market Cap:#{clean_data["marketCapUsd"].to_f.round(3)} Rank:#{clean_data["rank"]}" 
    end
end

