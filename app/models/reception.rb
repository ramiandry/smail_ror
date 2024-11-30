class Reception < ApplicationRecord
  belongs_to :utilisateur
  belongs_to :email
  belongs_to :transfert, class_name: "Utilisateur", optional: true
end
