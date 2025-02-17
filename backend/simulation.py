import random
import json
import sys
import arcade
import requests
import animals, humans, plants
import time
import arcade.draw
from perlin import world_generation

WINDOW_WIDTH = 800
WINDOW_HEIGHT = 800
TILE_SIZE = 10
WINDOW_TITLE = "Ecosystem Simulation"
MOVEMENT_SPEED = 0.2
FOX_HIT = False
fox_numbers = []
food_available = []


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
    def on_close(self):
        data = {
            "fox_numbers": fox_numbers,
            "food_numbers": food_available
        }

        # Send the POST request to Flask
        url = 'http://127.0.0.1:5000/end'
        try:
            response = requests.post(url, json=data)
            print("Data sent to Flask, status code:", response.status_code)
        except Exception as e:
            print("Error sending data to Flask:", e)

        arcade.close_window()
        super().on_close()

    def __init__(self):
        super().__init__(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_TITLE, 
                         resizable=False)
        
        self.ax = int(WINDOW_WIDTH / TILE_SIZE)
        self.ay = int(WINDOW_HEIGHT/ TILE_SIZE)

        self.grid = [[0 for _ in range(self.ax)] for _ in range(self.ay)]
        self.grid = world_generation(self.ax, self.ay, self.grid)

        # list of all sprites
        self.sprites = arcade.SpriteList()
        self.plants = arcade.SpriteList()
        self.urban = arcade.SpriteList()
        self.cars = arcade.SpriteList()
        self.world_tiles = None
        self.road_coords = [-100, -100]
        self.speed = 5
        
        if road_mode:
            road_y = 0
            road_centre = random.uniform(100,700) 
            for x in range(15):
                rd = humans.Road("resources/road.png", self.sprites)
                rd.center_y = road_y
                rd.center_x = road_centre
                self.urban.append(rd)
                road_y += 76

            start_y = 0
            start_x = road_centre + 22.5
            car1 = humans.Car(start_x,start_y,WINDOW_WIDTH,WINDOW_HEIGHT,"resources/YellowBuggy.png", self.sprites,5)

            start_y_2 = 1200
            start_x_2 = road_centre - 22.5
            car2 = humans.Car(start_x_2,start_y_2,WINDOW_WIDTH,WINDOW_HEIGHT,"resources/YellowBuggy.png", self.sprites,-5)
            car2.angle = 180

            self.cars.append(car1)
            self.cars.append(car2)


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

        self.cars.draw()
        self.sprites.draw()
        if mist_mode:
            self.mist.draw()

    
    def on_update(self, delta_time):
        self.foxs = arcade.SpriteList()

        for sprite in self.sprites:
            if isinstance(sprite, (animals.Fox, animals.Rat)):
                sprite.update()
                
                if isinstance(sprite, animals.Fox):
                    self.foxs.append(sprite)
        
        if mist_mode:
            hit_list = arcade.check_for_collision_with_list(self.mist,self.foxs)
            for f in hit_list:
                    f.health -= 1
                    f.health_bar.update_colors(new_full_colour=arcade.color.GREEN)

            plant_hit_list = arcade.check_for_collision_with_list(self.mist,self.plants)
            for p in plant_hit_list:
                if p.type == "berrybush":
                    bush = plants.EmptyBush(self.plants, "resources/emptybush.png", 2)
                    bush.center_x = p.center_x
                    bush.center_y = p.center_y
                    p.kill()
                    self.plants.append(bush)

            self.mist.update()
        
        if road_mode:
            for c in self.cars:
                hit_list = arcade.check_for_collision_with_list(c, self.sprites)
                for sprite in hit_list:
                    if type(sprite) == arcade.SpriteSolidColor:
                        pass
                    elif sprite.type == "fox":
                        sprite.kill_fox()
                    elif sprite.type == "rat":
                        self.sprites.remove(sprite)

            self.cars[0].update()
            self.cars[1].update()


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
            self.on_close()


def main(parameters):
   global waste_mode, mist_mode, road_mode
   waste_mode = parameters.get('waste', False)
   mist_mode = parameters.get('mist', False)
   road_mode = parameters.get('urban', False)

   window = GameView()
   window.setup()
   arcade.run()
   sys.exit(0)

if __name__ == "__main__":
    if len(sys.argv) > 1:
        try:
            parameters = json.loads(sys.argv[1])
        except json.JSONDecodeError as e:
            print("Failed to decode JSON:", e)
            parameters = {}
    else:
        parameters = {}

    main(parameters)