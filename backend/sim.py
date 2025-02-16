import random
import arcade
import requests
import time
import animals

import arcade.draw
import arcade.sprite_list
from perlin import world_generation
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 800
TILE_SIZE = 10
WINDOW_TITLE = "Ecosystem Simulation"
MOVEMENT_SPEED = 0.2
import os


class GameView(arcade.Window):
    def __init__(self):
        super().__init__(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_TITLE, 
                         resizable=True)
        
        self.ax = int(WINDOW_WIDTH / TILE_SIZE)
        self.ay = int(WINDOW_HEIGHT/ TILE_SIZE)

        self.background_color = arcade.csscolor.LIGHT_GREEN
        
        self.background = None

        self.grid = [[0 for _ in range(self.ax)] for _ in range(self.ay)]


        # list of all sprites
        self.sprites = arcade.SpriteList()
        self.world_tiles = None

        for i in range(2):
            fox = animals.Fox(self.sprites, "resources/fox.png", scale=0.2)
            fox.center_x = random.uniform(10, 390)
            fox.center_y = random.uniform(10, 390)
            self.sprites.append(fox)     

            rat = animals.Rat(self.sprites, "resources/rat.png", scale=1)
            rat.center_x = random.uniform(10, 390)
            rat.center_y = random.uniform(10, 390)
            self.sprites.append(rat)

        self.change_x = MOVEMENT_SPEED
        self.change_y = MOVEMENT_SPEED
    
    def find_texture(self, cell):
        if cell < -0.15:
                texture = arcade.load_texture("tiles/blue.png")
        elif cell < -0.10:
                texture = arcade.load_texture("tiles/sand.png")
        elif cell < 0.04:
                texture = arcade.load_texture("tiles/lightgreen.png")
        else:
                texture = arcade.load_texture("tiles/darkgreen.png")
        
        return texture 
    

    def setup(self):
        
        texture_grass = arcade.load_texture(":resources:images/tiles/grassCenter.png")
            
        self.ax = int(WINDOW_WIDTH / TILE_SIZE)
        self.ay = int(WINDOW_HEIGHT / TILE_SIZE)
        self.grid = world_generation(self.ax, self.ay, self.grid)
        self.terrain_list = arcade.SpriteList()

        # sets up and restarts game when called
        self.change_x = MOVEMENT_SPEED

        for row in range(self.ay):
            for col in range(self.ax):
                texture = self.find_texture(self.grid[row][col])

                original_width = texture.width 
                original_height = texture.height 

                scale_x = TILE_SIZE / original_width
                scale_y = TILE_SIZE / original_height

                scale = min(scale_x, scale_y)

                tile = arcade.BasicSprite(texture, scale=scale)
                tile = arcade.BasicSprite(texture, scale=scale)

                tile.center_x = col * TILE_SIZE + TILE_SIZE / 2
                tile.center_y = row * TILE_SIZE + TILE_SIZE / 2

                self.terrain_list.append(tile)
        print("setup done")

    def on_draw(self):
        # screen
        # clear should be called at the start


        self.clear()
        self.terrain_list.draw(pixelated = True)
        
        self.sprites.draw()
    
    def on_update(self, delta_time):

        num = len(self.sprites)
        for i in range(num):
            # checking again because the update function is called
            num = len(self.sprites)
            if i < num:
                if type(self.sprites[i]) == animals.Fox or type(self.sprites[i] == animals.Rat):
                    self.sprites[i].update()

    
    def on_close(self):
        url = 'http://127.0.0.1:5000/end'
        response = requests.post(url, json="window closed")
        arcade.close_window()
        super().on_close()

def main(parameters):
    # parameters can determine some starting conditions for the simulation

    window = GameView()
    window.setup()
    arcade.run()

    # simulation could pause after a certain amount of time


if __name__ == "__main__":
    main("default")