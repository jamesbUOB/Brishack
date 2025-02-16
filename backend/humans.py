import arcade

class Waste(arcade.Sprite):
    def __init__(self, sprites, image_file, scale):
        super().__init__(self, image_file, scale)

        self.sprites = sprites
        self.type = "waste"