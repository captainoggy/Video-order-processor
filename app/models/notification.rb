class Notification < ApplicationRecord
  include Filterable
  belongs_to :pm

  after_create_commit { broadcast_prepend_to "notifications.#{pm.id}", target: "notifications" }
end
