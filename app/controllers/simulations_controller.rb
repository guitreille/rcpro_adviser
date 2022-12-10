class SimulationsController < ApplicationController

    def new
        @lead = Lead.new
        @request = Request.new
    end

    def create
        @lead = Lead.new(lead_params)
        @request = Request.new(request_params)
        @request.lead_id = @lead.id

        # If lead doesn't exist yet (look by e-mail and phone number --> composite key), try to save it
        lead_exists = Lead.where(email: @lead.email, phone: @lead.phone)
        puts 'lead exist? we will check!'
        puts lead_exists
        if (not lead_exists)
            puts 'Lead doesnt exist!'
        else
            puts 'Lead exists!'
        end

        if @lead.save
            redirect_to :root
        else
            render :new, status: :unprocessable_entity
        end
    
        if @request.save and @lead.save
            redirect_to :root
        else
            #render :new, status: :unprocessable_entity
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
