// display a 2 dimensional grid

class GridDisplayer
{
  PVector start_point;
  PVector stop_point;
  float size;
  int num;
  
  GridDisplayer(PVector _start_point, float _size, int _num)
  {
    start_point = _start_point;
    size = _size;
    num = _num;
    
    stop_point = PVector.add(start_point, new PVector(size, size));
  }
  
  void display(Cell[][] grid)
  {
    noStroke();
    
    for(int i = 0; i < num; i++)
    {
      for(int j = 0; j < num; j++)
      {
        float x = map(j, 0, num, start_point.y, stop_point.y);
        float y = map(i, 0, num, start_point.x, stop_point.x);
        
        if(grid[i][j].state == 0)
        {
          fill(255); // sain : blanc
        }
        else if(grid[i][j].state == 1)
        {
          fill(255, 0, 0); // infecte : rouge
        }else if(grid[i][j].state == 2)
        {
          fill(0, 255, 0); // gueri : vert
        }else
        {
          fill(255);
        }
        
        square(x, y, size/num);
      }
    }
  }
  
}