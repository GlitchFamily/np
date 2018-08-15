alias Np.Resources.Album.Links

aokigahara = %{name: "Aokigahara", artist: "Harakiri for the Sky", tags: "Black metal, Post-Hardcore", cover: "/images/covers/aokigahara.jpg", 
                links: %Links{youtube: "https://youtu.be/dZa6AzFg084",
                              spotify: "https://play.spotify.com/album/63QDHFL9Vt158vy6gN4Old",
                              applemusic: "https://itunes.apple.com/us/album/aokigahara/1032661166?uo=4",
                              googleplay: "https://play.google.com/music/m/Bnqdhtet6wepzq4p5hhfurxq5b4?signup_if_needed=1",
                              deezer: "https://www.deezer.com/album/8502753",
                              amazonmusic: "https://www.amazon.com/Aokigahara-Harakiri-Sky/dp/B014AO5SO4?SubscriptionId=AKIAJ2ZJBLTVW2RH7GAQ&tag=mobilead05388-20&linkCode=xm2&camp=2025&creative=165953&creativeASIN=B014AO5SO4",
                             }
              }

corpomente = %{name: "Corpo-Mente", artist: "Corpo-Mente", tags: "Baroque, Folk, Metal", cover: "/images/covers/corpo-mente.jpg"}

whobitthemoon = %{name: "Who Bit the Moon", artist: "David Maxim Micic", tags: "Foo, Bar", cover: "/images/covers/who-bit-the-moon.jpg"}


Enum.each [aokigahara, corpomente, whobitthemoon], fn album -> Np.Resources.create_album(album) end
