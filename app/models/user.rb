class User
    def initialize(id, username, avatar_hash)
        @id       = id
        @username = username
        @avatar   = 'https://cdn.discordapp.com/avatars' + '/' + @id + '/' + avatar_hash + '.jpg?size=64'
    end

    def username
        return @username
    end

    def avatar
        return @avatar
    end

end
