import random
import json
import arcade
import requests
import animals, humans
import time
import arcade.draw
from perlin import world_generation

WINDOW_WIDTH = 800
WINDOW_HEIGHT = 800
TILE_SIZE = 10
WINDOW_TITLE = "Ecosystem Simulation"
MOVEMENT_SPEED = 0.2
fox_numbers = []
food_available = []
waste_mode = False
road_mode = False


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

def on_close():
        data = {"fox_numbers": fox_numbers,
                "food_numbers": food_available}


        url = 'http://127.0.0.1:5000/end'
        response = requests.post(url, json=data)
        arcade.close_window()
        super().on_close()


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
        self.urban = arcade.SpriteList()
        self.world_tiles = None
        self.road_coords = [-100, -100]

        if road_mode:
            road_y = 0
            road_centre = random.uniform(100,700) 
            for x in range(15):
                rd = humans.Road("resources/road.png", self.sprites)
                rd.center_y = road_y
                rd.center_x = road_centre
                self.urban.append(rd)
                road_y += 76

            self.road_start_x = road_centre - rd.width/2 - 20
            self.road_start_y = road_centre + rd.width/2 + 20
            self.road_coords = [self.road_start_x, self.road_start_y]

        for i in range(4):
            animals.spawn_fox(self.sprites, self.plants, self.grid, self.road_coords)   
            animals.spawn_rat(self.sprites, self.grid, self.road_coords)


        for i in range(10):
            animals.plants.spawn_bush(self.plants, self.grid)


        # add waste to the map
        if waste_mode == True:
            for i in range(10):
                humans.spawn_waste(self.sprites, self.grid)

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
        self.start = time.time()
        self.fullsimstart = time.time()
                    
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
        self.plants.draw()
        self.urban.draw()
        self.sprites.draw()

    
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

        if (time.time() - self.start) > 4:
            # spawn rats
            if waste_mode:
                if (time.time() - self.start) > 8:
                # spawn one trash and one rat
                    humans.spawn_waste(self.sprites, self.grid)
                    animals.spawn_rat(self.sprites, self.grid, self.road_coords)
                    self.start = time.time()
            else:
                animals.spawn_rat(self.sprites, self.grid, self.road_coords)
                animals.spawn_rat(self.sprites, self.grid, self.road_coords)
                self.start = time.time()
        

        # counting numbers to graph
        fox_num = 0
        food_num = 0

        for i in range(len(self.sprites)):
            if type(self.sprites[i]) == arcade.SpriteSolidColor:
                pass
            elif self.sprites[i].type == "fox":
                fox_num += 1
            elif self.sprites[i].type == "rat":
                food_num += 1

        for i in range(len(self.plants)):
            if self.plants[i].type == "berrybush":
                food_num += 1

        fox_numbers.append(fox_num)
        food_available.append(food_num)

        if time.time() - self.fullsimstart >= 60:
            on_close()


def main(parameters):
   window = GameView()
   window.setup()
   arcade.run()

if __name__ == "__main__":
   main("default")