import noise
import random

scale = 100
octaves = 5
persistence = 0.5
lacunarity = 2.0
lake_scale = 25  
seed = 42
target_water_coverage = 0.1  

def world_generation(width, height, world):
    for i in range(height):
        for j in range(width):
            world[i][j] = noise.pnoise2(i/scale, j/scale, octaves, base=seed)
    
    all_values = [cell for row in world for cell in row]
    all_values.sort()
    water_level = all_values[int(len(all_values) * target_water_coverage)]

    for i in range(height):
        for j in range(width):
            if world[i][j] < water_level:
                world[i][j] -= 0.1
    return world