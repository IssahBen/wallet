

class User
    def initialize(conn)
        @conn=conn
    end

    def create_table
        @conn.exec("CREATE TABLE  IF NOT EXISTS users (id SERIAL PRIMARY KEY,first_name VARCHAR(50),last_name VARCHAR(50),pin VARCHAR(50))")
    end

    def insert(first_name,last_name,pin)
        @conn.exec_params("INSERT INTO users(first_name,last_name,pin) VALUES($1,$2,$3)",[first_name,last_name,pin])

    end
    
    def pull_id(first_name,last_name,pin)
        result=@conn.exec_params("SELECT id FROM users WHERE first_name=$1 AND last_name=$2 AND pin=$3",[first_name,last_name,pin] )
        return result.values.flatten.first
    end

    def customer?(first_name,last_name)
        result=@conn.exec_params("SELECT first_name,last_name FROM users WHERE first_name=$1 AND last_name=$2",[first_name,last_name])
        if result.values.empty?
            return false
        else
            true
        end
    end
    def update_pin(id,new_pin)
        @conn.exec_params("UPDATE users SET  pin=$1 WHERE id=$2 ",[new_pin,id])
    end

    def pull_pin(first_name,last_name)
        result=@conn.exec_params("SELECT pin FROM users WHERE first_name=$1 AND last_name=$2",[first_name,last_name])
        result.values.flatten.first
    end

    def delete_user(id)
        @conn.exec_params("DELETE FROM users WHERE id=$1",[id])
    end




end

class  CustomerBalances
    def initialize(conn)
        @conn=conn
    end

    def create_table
        @conn.exec("CREATE TABLE IF NOT EXISTS customer_balance(customer_id INT  REFERENCES users(id),coin_name VARCHAR(50),balance  INTEGER)")
    end

    def insert(id,coin_name,balance)
        @conn.exec_params("INSERT  INTO customer_balance(customer_id,coin_name,balance) VALUES($1,$2,$3)",[id,coin_name,balance])
    end

    def update_balance(id,coin_name,new_balance)
        @conn.exec_params("UPDATE customer_balance SET balance=$1  WHERE customer_id=$2 AND coin_name=$3",[new_balance,id,coin_name])
    end

    def pull_balance(id,coin_name)
        result = @conn.exec_params("SELECT balance FROM customer_balance WHERE customer_id=$1 AND coin_name=$2",[id,coin_name])
        result.values.flatten.first
    end

    def pull_all_coin_names(id)
        result = @conn.exec_params("SELECT coin_name FROM customer_balance WHERE customer_id=$1",[id])
        result = result.values.flatten
    end

    def delete_user(id)
        @conn.exec_params("DELETE FROM users WHERE customer_id=$1",[id])
    end
end







