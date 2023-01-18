require 'sqlite3'
require 'active_record'
require 'byebug'


ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'customers.sqlite3')
# Show queries in the console.
# Comment this line to turn off seeing the raw SQL queries.
ActiveRecord::Base.logger = Logger.new(STDOUT)

class Customer < ActiveRecord::Base
  def to_s
    "  [#{id}] #{first} #{last}, <#{email}>, #{birthdate.strftime('%Y-%m-%d')}"
    # convert input frome .csv to string
  end

  #  NOTE: Every one of these can be solved entirely by ActiveRecord calls.
  #  You should NOT need to call Ruby library functions for sorting, filtering, etc.

  def self.any_candice
    # YOUR CODE HERE to return all customer(s) whose first name is Candice
    # probably something like:  Customer.where(....)
    return Customer.where(first:"Candice")
    #find and return customer who start with Candice by .where
  end

  def self.with_valid_email
    # YOUR CODE HERE to return only customers with valid email addresses (containing '@')
    return Customer.where("email like '%@%'")  
    #return customer with @ in email
  end
  
  def self.with_dot_org_email
    Customer.where("email like '%.org.")
  end
  #find mail with .org

  def self.with_invalid_email
    Customer.where.not("email like '%@%'")
  end
  #find invalid mail that without @
  
  def self.with_blank_email
    Customer.where("email is null")
  end
  #find blank email

  def self.born_before_1980
    Customer.where("birthdate < '1980-01-01'")
  end
  #find who born before 1980

  def self.with_valid_email_and_born_before_1980
    Customer.where("email like '%@%' and birthdate < '1980-01-01'")
  end
  #find who put valid mail and born before 1980

  def self.last_name_starting_with_b
    Customer.where("last like 'B%")
  end
  #find who last name start with B

  def self.twenty_youngest
    Customer.order("birthdate DESC").limit(20)
  end
  #Sort by DESC (low to high) and choose first to 20th 

  def self.update_gussie_murray_birthdate
    Customer.find_by(first:'Gussie').update(birthdate:'2004-02-08')
  end
  #find who named Gussie and change birthdate to 2004-02-08
  
  def self.change_all_invalid_emails_to_blank
    Customer.where("email != '' AND email IS NOT NULL and email NOT LIKE '%@%'").update_all "email = ''"
  end
  #upadate all invalid email that not null and not have @ into null

  def self.delete_meggie_herman
    Customer.find_by(:first => 'Maggie', :lasr => 'Herman').destroy
  end
  #find who name maggie herman and delete data

  def self.delete_everyone_born_before_1978
    Customer.where('birthdate < ? ', time.parse("1 january 1987")).destroy_all
  end
  #delete everyone who born before 1987-01-01

      # etc. - see README.md for more details
end

#checking program is work by "bundle exec rspec spec/activerecord_practice_spec.rb"
## "bundle exec" is for sure that call correct ver. of ruby 

puts Customer.all.order('first')