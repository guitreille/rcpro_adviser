class Quote < ApplicationRecord
    belongs_to :request
    Inf = 1.0/0

    def get_advice 
        {
            coverage:  coverage_advice[0], 
            coverage_reason: coverage_advice[1],
            deductible: deductible_advice[0],
            deductible_reason: deductible_advice[1], 
            cover: cover_advice[0],
            cover_reason: cover_advice[1],
            additional_text: text_advice
        }
    end

    private 
    def coverage_advice
        case coverage_ceiling
        when 0..99999  
            ['small', 'as it is a good advice in your case.']
        when 100000..Inf
            ['large', 'as this will protect you for much higher amounts that the default one in case of dangerous consequences of your actions.']
        else  
            ['Error: invalid coverage', '']
        end
    end

    def deductible_advice
        case deductible
        when 0..9999
            ['small', 'as it will reduce your price and it\'s not that important for you (because the probability is limited).']
        when 10000..20000
            ['medium', ' as it is a good advice in your case.']
        when 20000..Inf
            ['large', 'as it is a good advice in your case (the probability is high).' ]
        else
            ['Error: invalid deductible formula', '']
        end
    end
    
    def cover_advice
        ['legal expenses', 'as it is strongly recommended in your case because the risks are high. There\'s a high probability that the claim would be followed by legal actions. You must thus be able to defend yourself. ']
    end

    def text_advice
        'As a doctor, your risk is limited in terms frequency, but the risk is very high as the amount involved in a medical error are enormous.' 
    end
end
