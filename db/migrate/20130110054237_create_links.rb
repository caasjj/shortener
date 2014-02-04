# Put your database migration here!
#
# Each one needs to be named correctly:
# timestamp_[action]_[class]
#
# and once a migration is run, a new one must
# be created with a later timestamp.

class CreateLinks < ActiveRecord::Migration
    # PUT MIGRATION CODE HERE TO SETUP DATABASE

    def self.up
      create_table :links do |link|
        link.string :short
        link.text :url
        link.timestamps
      end
    end

    def self.down
      drop_table :links
    end

end