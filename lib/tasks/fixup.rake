namespace :fixup do
  task permits: :environment do
    CityPermit.fixup!
  end
end
