module ApplicationHelper
  def avatar_url(user, size = 120)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end
