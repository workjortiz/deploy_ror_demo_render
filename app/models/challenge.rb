class Challenge < ApplicationRecord

    before_save :process_content

    validates :name, presence: true, length: {minimum: 10, maximum: 50, message: "must be between 10 and 50 characters"}
    validates :original_content, presence: true, length: {minimum: 20,maximun: 250, message: "must be between 20 and 250 characters"}

    def process_content

        error_parse_arr = Array.new
        begin
            sentece_arr = original_content.split(";")
            if sentece_arr.presence?

            else
                error_parse_arr.push("No contenido ingresado o valido")
            end
        rescue StandardError => e
            error_parse_arr.push("Error no controlado identificado: #{e}")
        end
    end 
end
