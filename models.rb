require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection

class User < ActiveRecord::Base
    has_secure_password
    
    validates :name,
      presence: true,
      uniqueness: true
    
    validates :mail, 
      presence: true, 
      uniqueness: true

    validates :password, 
      presence: true,
      format: { with: /\A(?=.*[a-zA-Z])(?=.*[0-9]).+\z/ }
end
