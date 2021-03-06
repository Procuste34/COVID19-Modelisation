class GridUpdater
{
  float contagiosite = 0.1;
  float tauxVoyage = 0.5;
  float tauxGuerison = 0.01;
  
  int currentInfected = 0;
  int totalInfected = 0;
  
  int maxCurrentInfected = 0;
  
  float txCroissance = 0;
  
  GridUpdater() {} // TODO : params ??

  Cell[][] update(Cell[][] grid)
  {
    int oldTotalInfected = totalInfected;
    int oldCurrentInfected = currentInfected;
    
    //int num = grid.length;
    int width_num = grid[0].length;
    int height_num = grid.length;

    Cell[][] newGrid = new Cell[height_num][width_num];    
    arrayCopy(grid, newGrid);

    for (int i = 0; i < height_num; i++)
    {
      for (int j = 0; j < width_num; j++)
      {
        if(grid[i][j].state == 0)
        {
          int numInfectedNeighbors = infectedNeighbors(grid, i, j);
          float p_infection = min(contagiosite * numInfectedNeighbors, 1);
          
          if(random(0, 1) < p_infection)
          {
            newGrid[i][j].state = 1;
            currentInfected++;
            totalInfected++;
          }
        } else if(grid[i][j].state == 1)
        {
          //guerison avec une certaine prob
          if(random(0, 1) < tauxGuerison)
          {
            newGrid[i][j].state = 2;
            currentInfected--;
          }
          
        }
      }
    }
    
    //if(random(0, 1) < 0.01 + (1/(totalInfected))) //déplacement
    if(random(0, 1) < tauxVoyage)
    {
      int random_row = round(random(0, height_num-1));
      int random_col = round(random(0, width_num-1));
      
      if(newGrid[random_row][random_col].state == 0)
      {
        newGrid[random_row][random_col].state = 1;
        currentInfected++;
        totalInfected++;
      } 
    }
    
    maxCurrentInfected = max(maxCurrentInfected, currentInfected);
    
    txCroissance = float(totalInfected)/float(oldTotalInfected);
    
    //println("NEW INFECTED:", totalInfected-oldTotalInfected, "NPE:", oldCurrentInfected * contagiosite * 8 * ((10000-totalInfected)/10000));
    
    return newGrid;
  }
  
  void updateParams(float newContagiosite, float newTauxGuerison, float newTauxVoyage)
  {
    contagiosite = newContagiosite;
    tauxVoyage = newTauxVoyage;
    tauxGuerison = newTauxGuerison;
  }

  int infectedNeighbors(Cell[][] grid, int row, int col)
  {
    //int num = grid.length;
    int width_num = grid[0].length;
    int height_num = grid.length;
    
    int numInfectedNeighbors = 0;

    for (int i = row-1; i <= row+1; i++)
    {
      for (int j = col-1; j <= col+1; j++)
      {        
        if(((i >= 0) && (i <= height_num-1)) && ((j >= 0) && (j <= width_num-1)))
        {
          if (grid[i][j].state == 1)
          {
            if ((i != row) || (j != col)) // ne pas compter la cell dans le nombre de voisins
            {
              numInfectedNeighbors++;
            }
          }
        }
      }
    }

    return numInfectedNeighbors;
  }
}
