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

class Car(arcade.Sprite):

    def __init__(self, x,y,screen_width, screen_height, image, sprites, scale=1):
        super().__init__(image,scale)
        self.player_texture = arcade.load_texture("resources/YellowBuggy.png")
        self.player_sprite = arcade.Sprite(self.player_texture)
        self.center_x = x
        self.center_y = y
        self.screen_width = screen_width
        self.screen_height = screen_height
        self.speed = 5
    
    def update(self):
        self.center_y += self.speed
        
        if self.center_y > self.screen_height + self.player_sprite.height:
            self.center_y = - (self.player_sprite.height/2) - random.randint(20,400) 
        
        elif self.center_y < - (self.player_sprite.height):
            self.center_y = self.screen_height + (self.player_sprite.height/2) +random.randint(20,400)