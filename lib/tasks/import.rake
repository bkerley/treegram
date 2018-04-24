namespace :import do
  task initial: :environment do
    CityPermit.initial_import!
  end

  task update: :environment do
    CityPermit.update_import!
  end
end
