class Reception < ApplicationRecord
  belongs_to :utilisateur
  belongs_to :email
end
