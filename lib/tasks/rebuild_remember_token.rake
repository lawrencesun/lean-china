namespace :user do
  desc "Rebuild Remember-Tokens"
  task :rebuild_remember_token => :environment do
    User.transaction do
      User.all.each { |u|
        u.update_attribute :remember_token, SecureRandom.urlsafe_base64
      }
    end
  end
end