import random
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
waste_mode = True


class Mist(arcade.Sprite):
    def __init__(self, x, y, width, height, screen_width, screen_height, opacity=120):
        texture = arcade.Texture.create_empty("mist", (width, height))
        super().__init__(texture)
        
        self.center_x = x
        self.center_y = y
        self.width = width
        self.height = height
        self.screen_width = screen_width
        self.screen_height = screen_height
        self.color = arcade.color.GRAY
        self.alpha = opacity  
        self.angle = 90  
        self.speed = 1.5

    def update(self):
        self.center_x += self.speed
        
        if self.center_x > self.screen_width + self.width:
            self.center_x = - (self.width/2) - 100 
        
        elif self.center_x < - (self.width):
            self.center_x = self.screen_width + (self.width/2) + 100

    def draw(self):
        arcade.draw_ellipse_filled(
            self.center_x, self.center_y,
            self.width, self.height,
            (self.color[0], self.color[1], self.color[2], self.alpha),
            self.angle
        )

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
            animals.spawn_fox(self.sprites, self.plants, self.grid)   
            animals.spawn_rat(self.sprites, self.grid)


        for i in range(10):
            animals.plants.spawn_bush(self.plants, self.grid)



        # add waste to the map
        if waste_mode == True:
            for i in range(10):
                humans.spawn_waste(self.sprites, self.grid)


        self.change_x = MOVEMENT_SPEED
        self.change_y = MOVEMENT_SPEED

        self.mist = Mist(0,400,400,600,WINDOW_WIDTH,WINDOW_HEIGHT)
    
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
        self.mist.draw()

    
    def on_update(self, delta_time):
        self.foxs = arcade.SpriteList()

        for sprite in self.sprites:
            if isinstance(sprite, (animals.Fox, animals.Rat)):
                sprite.update()
                
                if isinstance(sprite, animals.Fox):
                    self.foxs.append(sprite)
            
        hit_list = arcade.check_for_collision_with_list(self.mist,self.foxs)
        for f in hit_list:
                f.health -= 0.5
                f.health_bar.update_colors(new_full_colour=arcade.color.GREEN)
        
        self.mist.update()

        animals.plants.update_bushes(self.plants)

        animals.fox_death(self.sprites)

        if (time.time() - self.start) > 4:
            # spawn rats
            if waste_mode:
                if (time.time() - self.start) > 8:
                # spawn one trash and one rat
                    humans.spawn_waste(self.sprites, self.grid)
                    animals.spawn_rat(self.sprites, self.grid)
                    self.start = time.time()
            else:
                animals.spawn_rat(self.sprites, self.grid)
                animals.spawn_rat(self.sprites, self.grid)
                self.start = time.time()
        
    
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