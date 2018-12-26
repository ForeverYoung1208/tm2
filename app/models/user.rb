class User < ActiveRecord::Base
#   attr_accessible :email, :password, :password_confirmation, :name, :user_level_id
    belongs_to :userlevel
    has_many :aorders
    has_many :actions
    belongs_to :company
 
    attr_accessor :password
    before_save :encrypt_password

    validates :name, :presence=>true;
    validates_confirmation_of :password
    validates_presence_of :password, :on => :create
    validates_presence_of :email
    validates_presence_of :userlevel_id
#    validates_uniqueness_of :email
    validates_uniqueness_of :name
    validates :company, :presence => true


    def encrypt_password
       if password.present?
         self.password_salt = BCrypt::Engine.generate_salt
         self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
       end
    end

    def self.authenticate(name, password)
     user = find_by_name(name)
     if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
       user
     else
       nil
     end
    end

    def ip_check(remote_ip)
      !self.is_ip_controlled || 
      (self.ip_address && self.ip_address.gsub(/\s+/, "").split(';').include?(remote_ip)) || 
      ::SUPERUSERS.include?(self.name)
    end

end
