class CityPermit < ApplicationRecord
  has_one :permit

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
    newest_permit = CityPermit.order(reviewstatuschangeddate: :desc).first
    since_date = newest_permit.reviewstatuschangeddate.rfc3339

    permits = SODA_CLIENT.get('x37d-q5fz', {
                                '$order' => 'reviewstatuschangeddate ASC',
                                '$where' =>
                                  "reviewstatuschangeddate > '#{since_date}'"
                              })

    permits.each do |permit|
      cs = self.new
      cs.attributes = permit.to_hash
      cs.save!
      cs.fixup!
    end
  end

  def self.fixup!
    Permit.delete_all
    File.open(Rails.root.join('log', 'fixup_permits.log'), 'w') do |l|
      self.in_batches.each_record do |cp|
        cp.fixup!
      end
    end
  end

  # single permit fixup
  def fixup!
    if self.permit
      print '-'
      return
    end

    p = self.build_permit

    begin
      addr = MiamiDadeGeo::Address.new_from_address self.propertyaddress
      p.location = "POINT(#{addr.long} #{addr.lat})"
    rescue => e
      Rails.logger.info e
      Rails.logger.info self.propertyaddress
    end

    p.status_date = self.reviewstatuschangeddate
    p.address = self.propertyaddress

    p.save!

    if p.location
      print '.'
    else
      print 'x'
    end
  end
end
