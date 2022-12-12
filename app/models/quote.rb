class Quote < ApplicationRecord
    belongs_to :request
    Inf = 1.0/0

    def get_advice 
        return [coverage_advice, deductible_advice, cover_advice]
    end

    private 
    def coverage_advice
        puts coverage_ceiling 
        case coverage_ceiling
        when 0..99999  
            'small'
        when 100000..Inf
            'large'
        else  
            'Error: invalid'
        end
    end

    def deductible_advice
        case deductible
        when 0..9999
            'small'
        when 10000..20000
            'medium'
        when 20000..Inf
            'large'
        else
            'Error: invalid'
        end
    end
    
    def cover_advice
        'legal expenses'
    end
end
