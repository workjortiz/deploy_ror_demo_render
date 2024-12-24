class Challenge < ApplicationRecord
    validates :name, presence: true, length: { minimum: 10, maximum: 50, message: "must be between 10 and 50 characters" }
    validates :original_content, presence: true, length: { minimum: 10, maximun: 250, message: "must be between 20 and 250 characters" }

    def process_content
        error_parse_arr = Array.new
        process_string = "{"
        begin
            sentence_arr = self.original_content.split(";")
            if sentence_arr.size > 0

                sentence_arr.each do |this_sentence|
                    tmp_phase1 = this_sentence.split(".")
                    sentece_obj = '"'+tmp_phase1[0]+'"'
                    process_string += sentece_obj + ":{"

                    tmp_phase2 = tmp_phase1[1].split("=")
                    sentence_attr = tmp_phase2[0]
                    sentence_val = tmp_phase2[1]

                    process_string += '"'+sentence_attr+'"' + ":" + '"'+sentence_val+'"' + "},"
                end
            else
                error_parse_arr.push("Sentencia revisada. Contenido ingresado no valido.\nEvaluación: #{this_sentence}")
            end
        rescue StandardError => e
            error_parse_arr.push("Error no controlado identificado durante fragmentación de la oración.\nTexto ingresado: #{original_content}\nError capturado: #{e}")
        end

        process_string = process_string[0, process_string.length-1] + "}"

        if error_parse_arr.size > 0
            return error_parse_arr
        else
            return process_string
        end
    end 
end
