import arcade
import requests
import asyncio
import websockets

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
WINDOW_TITLE = "Test"


class GameView(arcade.Window):
    def __init__(self):
        super().__init__(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_TITLE, 
                         resizable=True)
        self.background_color = arcade.csscolor.LAWNGREEN
        self.animal_texture = arcade.load_texture("resources/sprite_0055.png")
        self.animal_sprite = arcade.Sprite(self.animal_texture)
        self.animal_sprite.center_x = 64
        self.animal_sprite.center_y = 128
        self.animal_sprite.scale = 0.2

    def setup(self):
        # sets up and restarts game when called
        pass

    def on_draw(self):
        # screen
        # clear should be called at the start
        self.clear()

        arcade.draw_sprite(self.animal_sprite)
    
    def on_close(self):
        arcade.close_window()
        url = 'http://127.0.0.1:5000/end'
        response = requests.post(url, json="window closed")

        super().on_close()

def main():
    window = GameView()
    window.setup()
    arcade.run()


if __name__ == "__main__":
    main()