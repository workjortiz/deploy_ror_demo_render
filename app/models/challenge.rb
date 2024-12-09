class Challenge < ApplicationRecord

    validates :name, presence: true, length: {minimum: 10, maximum: 50, message: "must be between 10 and 50 characters"}
    validates :original_content, presence: true, length: {minimum: 20,maximun: 250, message: "must be between 20 and 250 characters"}

end
