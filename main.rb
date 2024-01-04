require_relative "menu_methods"
include MenuMethods

customer=nil

while true
    
    if customer == nil
        menu_string=<<-Menu

        Welcome
        Enter 1 to create account
        Enter 2 to search  real time crypto info
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
        when "q"
            break
        end
        next
    else
        p customer
        menu_string=<<-Menu

        Welcome
        Enter 0 to add asset
        Enter 1 to deposit
        Enter 2 to withdraw
        Enter 3 to view balance
        Enter 4 to latest Assets info
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
        when "q"
            break
        end
    end
    attempt=customer.attempt
    unless attempt !=3
        break
    end
end

