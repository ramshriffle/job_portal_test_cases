class SendEmailsJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
  end
end
