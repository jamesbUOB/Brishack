import arcade
from perlin import world_generation

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 800
TILE_SIZE = 10
PLAYER_SPEED = 5
CHARACTER_SCALING = 1

class MyGame(arcade.Window):
    def __init__(self, num_plants=8):
        super().__init__(SCREEN_WIDTH, SCREEN_HEIGHT, "Procedural Terrain")
        self.terrain = None
        self.ax = int(SCREEN_WIDTH / TILE_SIZE)
        self.ay = int(SCREEN_HEIGHT / TILE_SIZE)
        self.background_color = arcade.color.BABY_BLUE
        self.plants = arcade.SpriteList()
        self.grid = [[0 for _ in range(self.ax)] for _ in range(self.ay)]
        
    def setup(self):
        self.ax = int(SCREEN_WIDTH / TILE_SIZE)
        self.ay = int(SCREEN_HEIGHT / TILE_SIZE)
        self.grid = world_generation(self.ax, self.ay, self.grid)

    def color_assignment(self, cell):
        if cell < -0.15:  
            return (80, 120, 160)   # Brighter deep water
        elif cell < -0.10:
            return (180, 150, 120)  # Brighter light brown (mud)
        elif cell < 0.04:
            return (70, 170, 70)    # Brighter dark green
        else:
            return (130, 210, 130)  # Brighter light green
            
           
    def on_draw(self):
        self.clear()
        
        for row in range(self.ay):
            for col in range(self.ax):
                color = self.color_assignment(self.grid[row][col])
                left = col * TILE_SIZE  
                bottom = row * TILE_SIZE  
                arcade.draw_lbwh_rectangle_filled(left, bottom, TILE_SIZE, TILE_SIZE, color)
        
        image = arcade.get_image(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)  
        image.save("terrain.png", "PNG")
        print("Terrain saved to terrain.png")
    
def main():
    game = MyGame()
    game.setup()
    arcade.run()
    arcade.close_window()

if __name__ == "__main__":
    main()

