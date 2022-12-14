class Nacebel < ApplicationRecord
    Sector = ENV['SECTOR']

    def self.nacebels_from_sector
        case Sector
        when 'medical'
            [26600, 32500, 77295]
        when 'informatics'
            [62010, 62030, 62090, 63110]
        end
    end
end
