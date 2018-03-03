class CityPermit < ApplicationRecord

  def self.import!
    permits = SODA_CLIENT.get('x37d-q5fz',
                        {'$order' => 'reviewstatuschangeddate ASC'})

    permits.each do |permit|
      fail permit.inspect
      cs = self.new
      cs.attributes = permit.to_hash
      cs.save!
    end
  end

  def self.fixup!
    Permit.delete_all
    File.open(Rails.root.join('log', 'fixup_permits.log'), 'w') do |l|
      self.in_batches.each_record do |cs|
        p = Permit.new
        begin
          addr = MiamiDadeGeo::Address.new_from_address cs.property_address
          p.lat = addr.lat
          p.long = addr.long
        rescue => e
          l.puts e
          l.puts cs.deliveryaddress
        end
        p.status_date = Time.parse cs.statusdate
        p.city_source_id = cs.id
        p.address = cs.deliveryaddress
        p.save!
        if p.lat
          print '.'
        else
          print 'x'
        end
      end
    end
  end
end
