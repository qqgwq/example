module ApplicationHelper
  def avatar_url(user)
    gravatar_url = Digest::MD5.hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_url}.png?d=wavatar"
  end
end
