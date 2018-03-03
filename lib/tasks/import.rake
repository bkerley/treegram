namespace :import do
  task permits: :environment do
    CityPermit.import!
  end
end
