class CityPermit < ApplicationRecord

  def self.initial_import!
    permits = SODA_CLIENT.get('x37d-q5fz',
                        {'$order' => 'reviewstatuschangeddate DESC'})

    permits.each do |permit|
      cs = self.new
      cs.attributes = permit.to_hash
      cs.save!
    end
  end

  def self.update_import!
    newest_permit = CityPermit.order(reviewstatuschangeddate: :desc).one
    since_date = newest_permit.reviewstatuschangeddate.rfc3339

    permits = SODA_CLIENT.get('x37d-q5fz', {
                                '$order' => 'reviewstatuschangeddate DESC',
                                '$where' =>
                                  "reviewstatuschangeddate > '#{since_date}'"
                              })

    permits.each do |permit|
      cs = self.new
      cs.attributes = permit.to_hash
      cs.save!
    end
  end

  def self.fixup!
    Permit.delete_all
    File.open(Rails.root.join('log', 'fixup_permits.log'), 'w') do |l|
      self.in_batches.each_record do |cp|
        p = Permit.new
        begin
          addr = MiamiDadeGeo::Address.new_from_address cp.propertyaddress
          p.location = "POINT(#{addr.long} #{addr.lat})"
        rescue => e
          l.puts e
          l.puts cp.propertyaddress
        end
        p.status_date = cp.reviewstatuschangeddate
        p.city_permit = cp
        p.address = cp.propertyaddress
        p.save!
        if p.location
          print '.'
        else
          print 'x'
        end
      end
    end
  end
end
