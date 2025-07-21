class NotificationJob < ApplicationJob
  queue_as :default

  def perform(project)
    Notification.create!(
      pm: project.pm,
      message: "New project '#{project.name}' has been assigned to you."
    )
  end
end
