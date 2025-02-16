import random
import arcade
import requests
import time
import animals

from perlin import world_generation
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 800
TILE_SIZE = 10
WINDOW_TITLE = "Ecosystem Simulation"
MOVEMENT_SPEED = 0.2


class GameView(arcade.Window):
    def __init__(self):
        super().__init__(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_TITLE, 
                         resizable=True)
        
        self.ax = int(WINDOW_WIDTH / TILE_SIZE)
        self.ay = int(WINDOW_HEIGHT/ TILE_SIZE)

        self.background_color = arcade.csscolor.LIGHT_GREEN

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
    
    def color_assignment(self, cell):
        if cell < -0.15:  
            return (80, 120, 160)   # Brighter deep water
        elif cell < -0.10:
            return (180, 150, 120)  # Brighter light brown (mud)
        elif cell < 0.04:
            return (70, 170, 70)    # Brighter dark green
        else:
            return (130, 210, 130)  # Brighter light green
    
    def setup(self):
        self.ax = int(WINDOW_WIDTH / TILE_SIZE)
        self.ay = int(WINDOW_HEIGHT / TILE_SIZE)
        self.grid = world_generation(self.ax, self.ay, self.grid)
        # sets up and restarts game when called
        self.change_x = MOVEMENT_SPEED
        self.render_world_tiles()
    
    def render_world_tiles(self):
        self.batch = arcade.shape_list.ShapeElementList()
        for row in range(self.ay):
            for col in range(self.ax):
                color = self.color_assignment(self.grid[row][col])
                left = col * TILE_SIZE  
                bottom = row * TILE_SIZE 

                rect = arcade.draw_lbwh_rectangle_filled(
                    left, bottom, TILE_SIZE, TILE_SIZE, color
                )
                self.batch.append(rect)
        self.world_tiles = self.batch

    def on_draw(self):
        # screen
        # clear should be called at the start
        if self.world_tiles:
            self.world_tiles.draw()

        self.clear()
        
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
