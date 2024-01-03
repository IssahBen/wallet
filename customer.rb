require 'httparty'
class Customer
    attr_accessor :first_name ,:last_name, :pin,:coins, :attempt


    def initialize(first_name,last_name,pin)

        @first_name=first_name

        @last_name=last_name

        @pin=pin

        @coin_list=[]
        @attempt=0
    end

    def add_coin(name)

        new_hash=Hash.new

        new_hash[name]=0

        @coin_list << new_hash
    end

    def deposit(name,amount)

        @coin_list.each do |hash|

           if hash.keys[0] == name

            hash[name] += amount.to_i
            puts "Your balance is #{hash[name]}"
           end
        end
    end

    def balance
        balance=0
        @coin_list.each do |hash|
            
            hash.each do|k,v|
                p "#{k} : #{v}"
            end
        end
        balance

    end
    
    def withdraw(name,amount)
        
        @coin_list.each do |hash|

            if hash.keys[0] == name
 
             hash[name] -= amount.to_i

             puts "Your balance is #{hash[name]}"
            end
         
        end
    end
    def view_real_time_data
        coins=[]

        @coin_list.each do |hash|

            coins << hash.keys[0]
        end
        coins.each do |coin|
            url=
            response=HTTParty.get("https://api.coincap.io/v2/assets/#{coin}")

            parsed_data=JSON.parse(response.body)
            clean_data= parsed_data["data"]
            puts "price: $#{clean_data["priceUsd"].to_i.round},Precent change for-24hr #{clean_data["changePercent24Hr"].to_i.round}%"
        end
    end





    

end