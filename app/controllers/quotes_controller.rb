class QuotesController < ApplicationController
    layout "application"

    def index
        request_ids = Request.where(:lead_id => params["lead"]).pluck(:id)
        @quotes = Quote.where(:request_id => request_ids)
    end

    def new
        @lead = Lead.new
        @request = Request.new
        @quote = Quote.new
    end

    def show 
        @quote = Quote.find(params[:id])
        @request = @quote.request
        @lead = @request.lead
    end

    def create
        @lead = Lead.new(lead_params)
        @request = Request.new(request_params)

        # If lead doesn't exist yet (look by e-mail and phone number --> composite key), try to save it
        lead_exists = Lead.where(email: @lead.email, phone: @lead.phone)
        if (lead_exists.length > 0)
            @request.lead_id = lead_exists[0].id
        else
            #New lead
            if (@lead.save)
                @request.lead_id = @lead.id
            else
                render :new, status: :unprocessable_entity
                return 
            end
        end
    
        if @request.save
            response = JSON.parse(fetch_quote.body)
            puts JSON.pretty_generate(response)
            if response['success']
                # Save to db
                quote = Quote.create(available: response['data']["available"],
                    coverage_ceiling: response['data']["coverageCeiling"],
                    deductible: response['data']["deductible"],
                    api_quote_id: response['data']["quoteId"],
                    gross_premiums: response['data']["grossPremiums"],
                    request_id: @request.id)
                redirect_to action: 'show', id: quote.id
            else
                @request.errors.add(:base, message: response["message"] + ": " + response["data"]["message"])
                render :new, status: :bad_request
            end
        else
            render :new, status: :unprocessable_entity
        end
    end


    private
    def request_params
        puts params
        params.permit(:annual_revenue, :entreprise_no, :legal_name, :natural_person, nacebel_codes: [])
    end

    def lead_params
        params.permit(:firstname, :lastname, :email, :phone, :address)
    end

    def fetch_quote
        nacebel_codes = @request.nacebel_codes.gsub(/(\[\"|\"\])/, '').split('", "')

        return HTTParty.post(ENV['API_URI'], 
            :body => { "annualRevenue" => @request.annual_revenue, 
                       "enterpriseNumber" => @request.entreprise_no, 
                       "legalName" => @request.legal_name, 
                       "naturalPerson" => @request.natural_person, 
                       "nacebelCodes" => nacebel_codes
                     }.to_json,
            :headers => {   'Content-Type' => 'application/json',
                            'X-Api-Key' => ENV['API_KEY']} )
    end
end

