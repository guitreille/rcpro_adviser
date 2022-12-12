class ApplicationController < ActionController::Base
    def new
        @lead = Lead.new
        @request = Request.new
        @quote = Quote.new
    end

    def show 
        @quote = Quote.find(params[:id])
        #@request = Request.find(params[:id])
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
                redirect_to :root
            else
                # TODO: render error on page!
                render :new, status: :bad_request
            end
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

    def fetch_quote
        base_uri = 'https://staging-gtw.seraphin.be/quotes/professional-liability'
        api_key = 'fABF1NGkfn5fpHuJHrbvG3niQX6A1CO53ftF9ASD'
        puts @request.nacebel_codes.gsub(/(\[\"|\"\])/, '').split('", "')

        return HTTParty.post(base_uri, 
            :body => { "annualRevenue" => @request.annual_revenue, 
                       "enterpriseNumber" => @request.entreprise_no, 
                       "legalName" => @request.legal_name, 
                       "naturalPerson" => @request.natural_person, 
                       "nacebelCodes" => @request.nacebel_codes.gsub(/(\[\"|\"\])/, '').split('", "')
                     }.to_json,
            :headers => {   'Content-Type' => 'application/json',
                            'X-Api-Key' => api_key} )
    end
end

