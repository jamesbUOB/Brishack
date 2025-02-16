import arcade
from perlin import world_generation

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 800
TILE_SIZE = 10

class MyGame(arcade.Window):
    def __init__(self, num_plants=8):
        super().__init__(SCREEN_WIDTH, SCREEN_HEIGHT, "Procedural Terrain")
        self.terrain = None
        self.ax = int(SCREEN_WIDTH / TILE_SIZE)
        self.ay = int(SCREEN_HEIGHT / TILE_SIZE)
        self.background_color = arcade.color.BABY_BLUE
        self.plants = arcade.SpriteList()
        self.grid = [[0 for _ in range(self.ax)] for _ in range(self.ay)]

    def color_assignment(self, cell):
            if cell < -0.25:  # Deep water (reduced coverage)
                return (50, 90, 130)    # Darker blue for water
            else:
                return (40, 140, 40) 
           
    def on_draw(self):
        self.grid = world_generation(self.ax, self.ay, self.grid)
        arcade.set_background_color(arcade.color.BLACK)

        for row in range(self.ay):
            for col in range(self.ax):
                color = self.color_assignment(self.grid[row][col])
                left = col * TILE_SIZE  
                bottom = row * TILE_SIZE  
                arcade.draw_lbwh_rectangle_filled(left, bottom, TILE_SIZE, TILE_SIZE, color)

def main():
    game = MyGame()
    arcade.run()

if __name__ == "__main__":
    main()
