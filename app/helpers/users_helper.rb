module UsersHelper
    def avatar_for(user)
        dicebear_seed = Digest::MD5::hexdigest(user.email.downcase)
        dicebear_url = "https://avatars.dicebear.com/api/micah/#{dicebear_seed}.svg"
        image_tag(dicebear_url, alt: user.first_name, class: "dicebear_avatars", style: "background-color: #429f95")
    end
end