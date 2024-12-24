class Api::V1::ChallengesController < ApplicationController
  
  require "json"

  def show
    token = params[:token]
    if token.present?
      this_challenge = Challenge.find_by_token(token)
      if this_challenge.present?
        render status: 200,
        json: {
          success: true,
          data: JSON.parse(this_challenge.parsing_content.to_s)
        }
      else 
        render status: 200,
        json: {
          success: false,
          message: "Can't find challenge by token #{token}"
        }
      end
    else
      render status: 200,
      json: {
        success: false,
        message: "Token no present"
      }
    end
  end

  def delete
    search_challenge = Challenge.find(params[:id])
    if search_challenge.present?

      if search_challenge.destroy
        render status: 200,
        json: {
          success: true,
          message: "Registro borrado"
        }
      else
        render status: 200,
        json: {
          success: false,
          message: "No se pudo borrar"
        }
      end
    else
      render status: 200,
        json: {
          success: false,
          message: "Registro no encontrado"
        }
    end
  end

end
