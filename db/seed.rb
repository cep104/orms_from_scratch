class Seed
    def self.seed_data 
        5.times do 
            Tweet.create({user:"RuPaul", content: Faker::TvShows::RuPaul.quote})
        end

        5.times do 
            Tweet.create({user:"Michael Scott", content: Faker::TvShows::MichaelScott.quote})
        end

        5.times do 
            Tweet.create({user:"Kylo Ren", content: Faker::Movies::StarWars.quote(character: "kylo_ren")})
        end
        
    end
end