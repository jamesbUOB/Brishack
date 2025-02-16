import arcade

class Plant(arcade.Sprite):
    def __init__(self, sprites, image_file, scale=0.2):
        super.__init__(image_file, scale)


class EmptyBush(Plant):
    def __init__(self, sprites, image_file, scale=0.2):
        super().__init__(sprites, image_file, scale)

    