class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,
                  :phone, :firstName, :lastName, :gender, :birth, :is_beauty

  validates :email, :password, :phone, :firstName, :lastName, :gender, :birth, :presence => true
  validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create }
  validates :firstName, :lastName, :length => { :maximum => 50 }
  validates :phone, :length => { :maximum => 15 }


end