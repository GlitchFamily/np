aokigahara = %{name: "Aokigahara", artist: "Harakiri for the Sky", tags: "Black metal, Post-Hardcore", cover: "/images/covers/aokigahara.jpg"}

corpomente = %{name: "Corpo-Mente", artist: "Corpo-Mente", tags: "Baroque, Folk, Metal", cover: "/images/covers/corpo-mente.jpg"}

whobitthemoon = %{name: "Who Bit the Moon", artist: "David Maxim Micic", tags: "Foo, Bar", cover: "/images/covers/who-bit-the-moon.jpg"}


Enum.each [aokigahara, corpomente, whobitthemoon], fn album -> Np.Resources.create_album(album) end
