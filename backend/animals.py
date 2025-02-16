import random
from typing import Tuple
import arcade
from pytiled_parser import Color
import plants

INDICATOR_BAR_OFFSET = 32
WINDOW_WIDTH = 800
WINDOW_HEIGHT = 800
MOVEMENT_SPEED = 0.5

class Animal(arcade.Sprite):

    def __init__(self, sprites, image_file, scale):
        super().__init__(image_file, scale)

        self.sprites = sprites
        
    def update(self):
        pass


    def reproduce(self):
        pass
        


# fox
class Fox(Animal):
    def __init__(self, sprites, plant_list, image_file, scale):
        super().__init__(sprites, image_file, scale)
        self.type = "fox"
        self.health = 500
        self.hunger = 1000
        # indicator bars
        self.health_bar = IndicatorBar(self, sprites, (0.0, 0.0), scale=(0.75,0.75), full_colour=arcade.color.RED)
        self.hunger_bar = IndicatorBar(self, sprites, (0.0, 0.0), full_colour=arcade.color.MEAT_BROWN, scale=(0.75, 0.75))
    
        self.plant_list = plant_list
        self.born = plants.time.time()
        self.reproduce = False

    def createNew(self):
        fox = Fox(self.sprites, self.plant_list, "resources/fox.png", 0.2)
        fox.center_x = self.center_x
        fox.center_y = self.center_y
        self.sprites.append(fox)  

    def set_reproduce_false(self):
        self.reproduce = False
        self.color = arcade.color.WHITE

    def set_reproduce_true(self):
        self.reproduce = True
        self.color = arcade.color.RED

    def update(self):
        if self.hunger <= 0 and self.health > 0:
            self.health -= 1
        elif self.hunger > 0:
            self.hunger -= 1

        
        self.health_bar.fullness = self.health/500.0
        self.hunger_bar.fullness = self.hunger/1000.0

        self.hunger_bar.position = (
        self.center_x,
        self.center_y + INDICATOR_BAR_OFFSET,
        )
        self.health_bar.position = (
            self.center_x,
            self.center_y + (1.5*INDICATOR_BAR_OFFSET)
        )


        # Move the sprite
        self.center_x += self.change_x
        self.center_y += self.change_y

        # Randomize direction and speed when colliding with window edges
        if self.left <= 0 or self.right >= WINDOW_WIDTH:
            self.change_x = -1 * self.change_x


        if self.top >= WINDOW_HEIGHT or self.bottom <= 0:
            self.change_y = -1 * self.change_y

        # Occasionally change direction randomly
        if random.random() < 0.01:  # 1% chance per update
            self.change_x = random.choice([-1, 1]) * random.normalvariate(0.4, 0.1)
            self.change_y = random.choice([-1, 1]) * random.normalvariate(0.4, 0.1)


        # eat rats and berries
        if self.reproduce == True:
            animal_reproduce(self, self.sprites)
        elif self.hunger <= 700:
            food = arcade.SpriteList()
            # move toward rats or berries  self.  self.  self.set_reproduce_false()self.set_reproduce_false()  self.set_reproduce_false()  self.set_reproduce_false()set_reproduce_false()  self.set_reproduce_false()roduce_false()
            for i in range(len(self.sprites)):
                if type(self.sprites[i]) == Rat:
                    food.append(self.sprites[i]) 

            for i in range(len(self.plant_list)):
                if type(self.plant_list[i]) == plants.BerryBush:
                    food.append(self.plant_list[i])
                    
            if len(food) != 0:
                closest_food = arcade.get_closest_sprite(self, food)
                follow_sprite(self, closest_food[0])
                sprite_collisions(self, closest_food[0], self.sprites, self.plant_list, "eat")
        
        
        
        if self.health <= 0:
            self.kill_fox()

        if random.random() < 0.0005:
            self.set_reproduce_true()
        

        
    def kill_fox(self):
        self.hunger_bar.remove()
        self.health_bar.remove()
        self.kill()



def follow_sprite(self, sprite):
    speed = MOVEMENT_SPEED
    if self.hunger <= 0:
        speed = MOVEMENT_SPEED * 2

    if self.center_y < sprite.center_y:
        self.center_y += min(speed, sprite.center_y - self.center_y)

    elif self.center_y > sprite.center_y:
        self.center_y -= min(speed, self.center_y - sprite.center_y)

    if self.center_x < sprite.center_x:
        self.center_x += min(speed, sprite.center_x - self.center_x)

    elif self.center_x > sprite.center_x:
        self.center_x -= min(speed, self.center_x - sprite.center_x)


def sprite_collisions(self, sprite, sprites, plant_list, type):
    collision = arcade.check_for_collision(self, sprite)

    if collision and type == "eat":
        if sprite.type == "rat":
            sprite.kill()
            self.hunger = 1000
        elif sprite.type == "berrybush":
            bush = plants.EmptyBush(sprites, "resources/emptybush.png", 2)
            bush.center_x = sprite.center_x
            bush.center_y = sprite.center_y
            sprite.kill()
            plant_list.append(bush)
            self.hunger += 500
            if self.hunger > 1000: self.hunger = 1000

    if collision and type == "mate":
        if self.type == sprite.type:
            self.createNew()
            self.set_reproduce_false()
            sprite.set_reproduce_false()


def fox_death(sprites):
    for i in range(len(sprites)):
        if type(sprites[i]) == Fox:
            currentTime = plants.time.time()
            elapsed = currentTime - sprites[i].born

            if elapsed > 60:
                # kill the fox
                sprites[i].texture = arcade.load_texture("resources/foxold.png")
                if sprites[i].health > 0: sprites[i].health -= 1


def animal_reproduce(sprite, sprites):
    # find closest animal of same type
    animals = arcade.SpriteList()
    for i in range(len(sprites)):
        if (type(sprite) == type(sprites[i])) and sprite != sprites[i]:
            animals.append(sprites[i])
    
    if len(animals) >= 0:
        closest_animal = arcade.get_closest_sprite(sprite, animals)
        follow_sprite(sprite, closest_animal[0])
        sprite_collisions(sprite, closest_animal[0], sprites, sprites, "mate") 


class Rat(Animal):
    def __init__(self, sprites, image_file, scale=0.2):
        super().__init__(sprites, image_file, scale)
        self.type = "rat"
    
    def update(self):
        # Move the sprite
        self.center_x += self.change_x
        self.center_y += self.change_y

        # Randomize direction and speed when colliding with window edges
        if self.left <= 0 or self.right >= WINDOW_WIDTH:
            self.change_x = -1 * self.change_x


        if self.top >= WINDOW_HEIGHT or self.bottom <= 0:
            self.change_y = -1 * self.change_y

        # Occasionally change direction randomly
        if random.random() < 0.01:  # 1% chance per update
            self.change_x = random.choice([-1, 1]) * random.normalvariate(0.4, 0.1)
            self.change_y = random.choice([-1, 1]) * random.normalvariate(0.4, 0.1)

           


class IndicatorBar:

    def __init__(
        self,
        owner: Animal,
        sprite_list: arcade.SpriteList,
        position: Tuple[float, float] = (0, 0),
        full_colour: Color = arcade.color.BLUE,
        background_colour: Color = arcade.color.WHITE,
        width: int = 100,
        height: int = 4,
        border_size: int = 4,
        scale: Tuple[float, float] = (1.0, 1.0),
    ) -> None:

        # Store the reference to the owner and the sprite list

        self.owner: Animal = owner

        self.sprite_list: arcade.SpriteList = sprite_list


        # Set the needed size variables
        self._bar_width: int = width
        self._bar_height: int = height
        self._center_x: float = 0.0
        self._center_y: float = 0.0
        self._fullness: float = 0.0
        self._scale: Tuple[float, float] = (1.0, 1.0)


        # Create the boxes needed to represent the indicator bar
        self._background_box: arcade.SpriteSolidColor = arcade.SpriteSolidColor(
            self._bar_width + border_size,
            self._bar_height + border_size,
            color=background_colour,
        )

        self._full_box: arcade.SpriteSolidColor = arcade.SpriteSolidColor(
            self._bar_width,
            self._bar_height,
            color=full_colour,
        )

        self.sprite_list.append(self._background_box)
        self.sprite_list.append(self._full_box)


        # Set the fullness, position and scale of the bar
        self.fullness = 1.0
        self.position = position
        self.scale = scale

    
    def __repr__(self) -> str:
        return f"<IndicatorBar (Owner={self.owner})>"
    
    def remove(self) -> None:
        """Remove the indicator bar sprites from their sprite list."""
        self._background_box.kill()
        self._full_box.kill()



    @property
    def background_box(self) -> arcade.SpriteSolidColor:
        """Returns the background box of the indicator bar."""
        return self._background_box


    @property
    def full_box(self) -> arcade.SpriteSolidColor:
        """Returns the full box of the indicator bar."""
        return self._full_box


    @property
    def bar_width(self) -> int:
        """Gets the width of the bar."""
        return self._bar_width


    @property
    def bar_height(self) -> int:
        """Gets the height of the bar."""
        return self._bar_height


    @property
    def center_x(self) -> float:
        """Gets the x position of the bar."""
        return self._center_x


    @property
    def center_y(self) -> float:
        """Gets the y position of the bar."""
        return self._center_y


    @property
    def top(self) -> float:
        """Gets the y coordinate of the top of the bar."""
        return self.background_box.top


    @property
    def bottom(self) -> float:
        """Gets the y coordinate of the bottom of the bar."""
        return self.background_box.bottom


    @property
    def left(self) -> float:
        """Gets the x coordinate of the left of the bar."""
        return self.background_box.left


    @property
    def right(self) -> float:
        """Gets the x coordinate of the right of the bar."""
        return self.background_box.right


    @property
    def fullness(self) -> float:
        """Returns the fullness of the bar."""
        return self._fullness


    @fullness.setter
    def fullness(self, new_fullness: float) -> None:
        """Sets the fullness of the bar."""
        # Check if new_fullness if valid
        if not (0.0 <= new_fullness <= 1.0):
            raise ValueError(
                f"Got {new_fullness}, but fullness must be between 0.0 and 1.0."
            )


        # Set the size of the bar
        self._fullness = new_fullness
        if new_fullness == 0.0:
            # Set the full_box to not be visible since it is not full anymore
            self.full_box.visible = False

        else:
            # Set the full_box to be visible incase it wasn't then update the bar
            self.full_box.visible = True
            self.full_box.width = self._bar_width * new_fullness * self.scale[0]
            self.full_box.left = self._center_x - (self._bar_width / 2) * self.scale[0]


    @property
    def position(self) -> Tuple[float, float]:
        """Returns the current position of the bar."""
        return self._center_x, self._center_y


    @position.setter
    def position(self, new_position: Tuple[float, float]) -> None:
        """Sets the new position of the bar."""
        # Check if the position has changed. If so, change the bar's position

        if new_position != self.position:
            self._center_x, self._center_y = new_position
            self.background_box.position = new_position
            self.full_box.position = new_position

            # Make sure full_box is to the left of the bar instead of the middle

            self.full_box.left = self._center_x - (self._bar_width / 2) * self.scale[0]


    @property
    def scale(self) -> Tuple[float, float]:
        """Returns the scale of the bar."""
        return self._scale


    @scale.setter
    def scale(self, value: Tuple[float, float]) -> None:
        """Sets the new scale of the bar."""
        # Check if the scale has changed. If so, change the bar's scale
        if value != self.scale:
            self._scale = value
            self.background_box.scale = value
            self.full_box.scale = value