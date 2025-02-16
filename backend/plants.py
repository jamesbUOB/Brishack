import arcade
import time


class Plant(arcade.Sprite):
   def __init__(self, sprites, image_file, scale):
       super().__init__(image_file, scale)




class EmptyBush(Plant):
   def __init__(self, sprites, image_file, scale):
       super().__init__(sprites, image_file, scale)


       self.start = time.time()
       self.type = "emptybush"




class BerryBush(Plant):
   def __init__(self, sprites, image_file, scale):
       super().__init__(sprites, image_file, scale)


       self.type = "berrybush"
  


def update_bushes(plants):
   for i in range(len(plants)):
       if type(plants[i]) == EmptyBush:
           currentTime = time.time()
           elapsed = currentTime - plants[i].start


           if elapsed > 10:
               bush = BerryBush(plants, "resources/berrybush.png", 2)
               bush.center_x = plants[i].center_x
               bush.center_y = plants[i].center_y
               plants.append(bush)
               plants[i].kill()
               # length of loop changes
               break


              


          
          
