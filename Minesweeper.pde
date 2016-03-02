import de.bezier.guido.*;
public final static int NUM_COLS = 20;
public final static int NUM_ROWS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );    
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  for (int y = 0; y < 20; y++)
    for (int x = 0; x < 20; x++)
      buttons[x][y] = new MSButton(x, y);

  for (int i = 0; i < 20; i++)
    setBombs();
}
public void setBombs()
{
  int x = (int)(Math.random()*20);
  int y = (int)(Math.random()*20);
  if (bombs.contains(buttons[x][y]) ==false)
    bombs.add(buttons[x][y]);
  else
    setBombs();
}

public void draw()
{
  background( 0 );
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
  //your code here
  return false;
}
public void displayLosingMessage()
{
  //your code here
}
public void displayWinningMessage()
{
  //your code here
}
//--------------------------------------------------------------------------------------------
public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;

  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager

  public void mousePressed () 
  {
    clicked = true;
    if(keyPressed == true)
      marked = true;
    else if(bombs.contains(this))
      displayLosingMessage();
    else if(countBombs(row,col) > 0)
    {
      label = countBombs();
    }
    
    else if (!bombs.contains(this))
     {
      if (isValid(r, c-1) && buttons[r][c-1].isMarked()==false && buttons[r][c-1].isClicked()==false)
       buttons[r][c-1].mousePressed();

      if (isValid(r, c+1) && buttons[r][c+1].isMarked()==false && buttons[r][c+1].isClicked()==false)
       buttons[r][c+1].mousePressed();

      if (isValid(r-1, c) && buttons[r-1][c].isMarked()==false && buttons[r-1][c].isClicked()==false)
       buttons[r-1][c].mousePressed();

      if (isValid(r+1, c) && buttons[r+1][c].isMarked()==false && buttons[r+1][c].isClicked()==false)
       buttons[r+1][c].mousePressed();
     } 
  }

  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
      fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    if (r > 19 || r < 0 || c > 19 || c < 0)
      return false;
    return true;
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    for(int r = row-1; r <= row+1; r++)
      for(int c = col-1; c<= col+1; c++)
        if(isValid(row,col) == true && bombs.contains(buttons[row][col])==true)
          numBombs++;
     
     return numBombs;
  }
}


