import arcade
import random

class Waste(arcade.Sprite):
    def __init__(self, sprites, image_file, scale):
        super().__init__(image_file, scale)

        self.sprites = sprites
        self.type = "waste"


def spawn_waste(sprites, grid):
    waste = Waste(sprites, "resources/garbage.png", scale=2.5)
    waste.center_x = random.uniform(10, 790)
    waste.center_y = random.uniform(10, 790)
    sprites.append(waste)

    while grid[int(waste.center_y//10)][int(waste.center_x//10)] < -0.15:
        waste.center_x = random.uniform(10, 790)
        waste.center_y = random.uniform(10, 790)



class Road(arcade.Sprite):
    def __init__(self, image, sprites, scale=0.1):
        super().__init__(image, scale)
        self.player_texture = arcade.load_texture("resources/road.png")
        self.player_sprite = arcade.Sprite(self.player_texture)