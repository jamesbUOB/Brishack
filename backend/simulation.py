import random
import arcade
import requests
import time
import animals, plants

WINDOW_WIDTH = 800
WINDOW_HEIGHT = 800
WINDOW_TITLE = "Ecosystem Simulation"
MOVEMENT_SPEED = 0.2


class GameView(arcade.Window):
    def __init__(self):
        super().__init__(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_TITLE, 
                         resizable=True)
        self.background_color = arcade.csscolor.LIGHT_GREEN

        # list of all sprites
        self.sprites = arcade.SpriteList()

        for i in range(2):
            fox = animals.Fox(self.sprites, "resources/fox.png", scale=0.2)
            fox.center_x = random.uniform(10, 390)
            fox.center_y = random.uniform(10, 390)
            self.sprites.append(fox)     

            rat = animals.Rat(self.sprites, "resources/rat.png", scale=1)
            rat.center_x = random.uniform(10, 390)
            rat.center_y = random.uniform(10, 390)
            self.sprites.append(rat)

            bush = plants.EmptyBush(self.sprites, "resources/emptybush.png", scale=0.2)
            bush.center_x = random.uniform(10, 390)
            bush.center_y = random.uniform(10, 390)
            self.sprites.append(bush)

        self.change_x = MOVEMENT_SPEED
        self.change_y = MOVEMENT_SPEED

    def setup(self):
        # sets up and restarts game when called
        self.change_x = MOVEMENT_SPEED

    def on_draw(self):
        # screen
        # clear should be called at the start
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
