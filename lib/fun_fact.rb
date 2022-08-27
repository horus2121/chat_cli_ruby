require_relative '../config/env'

class FetchAPI

    def self.get_fact
        response = open("https://uselessfacts.jsph.pl/random.json?language=en").read
        json = JSON.parse(response)
        fun_fact = json["text"]
    end

end