class SimulationsController < ApplicationController

    def new
        @lead = Lead.new
        @request = Request.new
    end

    def create
        @lead = Lead.new(lead_params)
        @request = Request.new(request_params)
    
        if @lead.save and @request.save
            puts 'Success!!!!!'
            redirect_to :root
        else
            render :new, status: :unprocessable_entity
        end
    end


    private
    def request_params
      params.permit(:annual_revenue, :entreprise_no, :legal_name, :natural_person, :nacebel_codes, nacebel_codes: [])
    end

    def lead_params
        params.permit(:firstname, :lastname, :email, :phone, :address)
    end
end
