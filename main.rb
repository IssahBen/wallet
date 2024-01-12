require_relative "menu_methods"
include MenuMethods
require_relative 'Models'


customer=nil
conn  = PG.connect(dbname:'learn',user:'postgres',password:'postgres',host:'localhost')
user_table=User.new(conn)
user_table.create_table
balance_table=CustomerBalances.new(conn)
balance_table.create_table

while true

    if customer == nil
        menu_string=<<-Menu

        Welcome
        Enter 1 to create account
        Enter 2 to search  real time crypto info
        Enter 3 to login
        Enter q to quit 
        Menu

        puts menu_string

        choice=gets.chomp

        case choice
        when "1"
            customer= MenuMethods.create_account
        when "2"
            puts "Enter  crpto name to search"
            name=gets.chomp

            MenuMethods.search(name)
        when "3"
            customer=MenuMethods.login
        when "q"
            break
        end
        next
    else

        menu_string=<<-Menu

        Welcome
        Enter 0 to add asset
        Enter 1 to deposit
        Enter 2 to withdraw
        Enter 3 to view balance
        Enter 4 to latest Assets info
        Enter 5 to search  real time crypto info
        Enter 6 to Update Pin
        Enter 7 to Delete Account

        Enter q to quit 
        You will be logged out  after 3 failed login attempts
        Menu

        puts menu_string

        choice=gets.chomp

        case choice
        when "0"
            customer=MenuMethods.add_asset(customer)

        when "1"
            customer=MenuMethods.deposit(customer)

        when "2"
            customer=MenuMethods.withdraw(customer)
        when "3"
            customer=MenuMethods.view_balance(customer)
        when "4"
            MenuMethods.view_assets_data(customer)
        when "5"
            puts "Enter  crpto name to search"
            name=gets.chomp


             MenuMethods.search(name)
        when "6"
            customer=MenuMethods.update_pin(customer)
        when "7"
            MenuMethods.delete_account(customer)
            break
        when "q"
            break
        end
    end
    attempt=customer.attempt
    unless attempt !=3
        break
    end
end

