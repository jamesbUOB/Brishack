import random
import arcade
import requests
import animals
import time


import arcade.draw
from perlin import world_generation
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 800
TILE_SIZE = 10
WINDOW_TITLE = "Ecosystem Simulation"
MOVEMENT_SPEED = 0.2
import os


class Mist:


   def __init__(self,x,y,screen_width, screen_height, opacity=100):


       self.x = x
       self.y = y
       self.screen_width = screen_width
       self.screen_height = screen_height
       self.opacity = opacity
  
   def mist_texture(self):
        texture = arcade.load_texture("tiles/smoke.png")
       
        arcade.draw_rect_filled(arcade.rect.XYWH(self.x, self.y, self.screen_width, self.screen_height),color)


class GameView(arcade.Window):
    def __init__(self):
        super().__init__(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_TITLE, 
                         resizable=True)
        
        self.ax = int(WINDOW_WIDTH / TILE_SIZE)
        self.ay = int(WINDOW_HEIGHT/ TILE_SIZE)

        self.grid = [[0 for _ in range(self.ax)] for _ in range(self.ay)]
        self.grid = world_generation(self.ax, self.ay, self.grid)

        # list of all sprites
        self.sprites = arcade.SpriteList()
        self.plants = arcade.SpriteList()
        self.world_tiles = None


        for i in range(4):
            fox = animals.Fox(self.sprites, self.grid, self.plants, "resources/fox.png", scale=0.2)
            fox.center_x = random.uniform(10, 790)
            fox.center_y = random.uniform(10, 790)
            self.sprites.append(fox)     

            rat = animals.Rat(self.sprites, self.grid, "resources/rat.png", scale=1)
            rat.center_x = random.uniform(10, 790)
            rat.center_y = random.uniform(10, 790)
            self.sprites.append(rat)


        for i in range(8):
            bush = animals.plants.BerryBush(self.plants, "resources/berrybush.png", scale=2)
            bush.center_x = random.uniform(10, 790)
            bush.center_y = random.uniform(10, 790)
            self.plants.append(bush)



        # add waste to the map
        if waste_mode == True:
            for i in range(10):
                waste = humans.Waste(self.sprites, "resources/garbage.png", scale=2.5)
                waste.center_x = random.uniform(10, 790)
                waste.center_y = random.uniform(10, 790)
                self.sprites.append(waste)


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
                    
        self.ax = int(WINDOW_WIDTH / TILE_SIZE)
        self.ay = int(WINDOW_HEIGHT / TILE_SIZE)
        # sets up and restarts game when called
        self.change_x = MOVEMENT_SPEED
        self.terrain_list = arcade.SpriteList()


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


    def on_draw(self):
        # screen
        # clear should be called at the start


        self.clear()
        self.terrain_list.draw(pixelated = True)
        self.sprites.draw()
        self.plants.draw()
    

   # def spawn_rat(self):
   #     # print(time.time())
   #     current_time = (int(time.time()) % 60)
   #     # if current_time - last_time >= 5:
   #     # current_time = time.time()
   #     if current_time % 10 == 0:
   #         rat = animals.Rat(self.sprites, "resources/rat.png", scale=1)
   #         rat.center_x = random.uniform(10, 790)
   #         rat.center_y = random.uniform(10, 790)
   #         self.sprites.append(rat)


   #         # self.last_spawn_time = current_time

    
    def on_update(self, delta_time):

        num = len(self.sprites)
        for i in range(num):
            # checking again because the update function is called
            num = len(self.sprites)
            if i < num:
                if type(self.sprites[i]) == animals.Fox or type(self.sprites[i] == animals.Rat):
                    self.sprites[i].update()

        animals.plants.update_bushes(self.plants)

        animals.fox_death(self.sprites)

        # self.spawn_rat()


    
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