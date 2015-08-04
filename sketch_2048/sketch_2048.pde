int board[][] = {{0, 0, 0, 0},
                 {0, 0, 0, 0},
                 {0, 0, 0, 0},
                 {0, 0, 0, 0}};

int boardCoor[][][] = {{{16, 16}, {137, 16}, {258, 16}, {379, 16}},
                      {{16, 137}, {137, 137}, {258, 137}, {379, 137}},
                      {{16, 258}, {137, 258}, {258, 258}, {379, 258}},
                      {{16, 379}, {137, 379}, {258, 379}, {379, 379}} };

void setup()
{
  clearBoard();
  placeBlock();
  placeBlock();
  updateBoard();
  message("2048");
}

void draw()
{
  
}

///////////////// IMPORTANT /////////////////

// checks if board is filled (loss)
boolean checkFilled()
{
  for (int i = 0; i < 4; i++)
   for (int j = 0; j < 4; j++)
    if (board[i][j] == 0) return false;

  return true;
}

// places 2 randomly (will add placing 4)
void placeBlock()
{
  int i, j;
  do {
     i = (int) random(0, 4);
     j = (int) random(0, 4);
  } while (board[i][j] != 0);

  board[i][j] = random(0, 1) < 0.9 ? 1 : 2;
}

// updates board with new things
void updateBoard()
{
  clearBoard();
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      if(board[i][j] != 0) {
        
        int ij = board[i][j];
        
        if (ij == 1) fill(223, 223, 223);
        else if (ij == 2) fill(210, 210, 210);
        else if (ij == 3) fill(247, 177, 107);
        else if (ij == 4) fill(255, 144, 89);
        else if (ij == 5) fill(255, 122, 89);
        else if (ij == 6) fill(255, 70, 57);
        else if (ij == 7) fill(117, 167, 241);
        else if (ij == 8) fill(69, 133, 242);
        else fill(237, 207 - 10*(ij - 7), 114 - 6*(ij - 7));
        
        rect(boardCoor[i][j][0], boardCoor[i][j][1], 106, 106, 3, 3, 3, 3);
        
        fill(0);
        textAlign(CENTER);
        textSize(35);
        text((int)pow(2, board[i][j]), boardCoor[i][j][0] + 52.5, boardCoor[i][j][1] + 70.0);
      }
    }
  }
}

// this function does the moves
void move(char p)
{
   if (p == 'w' || p == 'W')
   {
     int skip;
      for (int i = 0; i < 4; i++) {
        skip = 1;
        for (int j = 1; j < 4; j++) {
          skip = slide("UP", j, i, skip);
      }}
   }

   else if (p == 'a' || p == 'A')
   {
      int skip;
       for (int i = 0; i < 4; i++) {
         skip = 1;
        for (int j = 1; j < 4; j++) {
          skip = slide("LEFT", i, j, skip);
      }}
   }

   else if (p == 's' || p == 'S')
   {
      int skip;
       for (int i = 0; i < 4; i++) {
         skip = 2;
        for (int j = 2; j >= 0; j--) {
          skip = slide("DOWN", j, i, skip);
       }}
   }

   else if (p == 'd' || p == 'd')
   {
     int skip;
       for (int i = 0; i < 4; i++) {
        skip = 2;
        for (int j = 2; j >= 0; j--) {
          skip = slide("RIGHT", i, j, skip);
       }
     }
   }
}

// check loss
boolean checkLoss()
{
   if (!up() && !down() && !left() && !right()) return true;
   else return false;  
}

// this function does the sliding of things
int slide(String dir, int y, int x, int skip)
{
   if (dir == "UP") {
      while (board[y-1][x] == 0 && y > skip) {
         board[y-1][x] = board[y][x];
         board[y][x] = 0;
         y--;
      }

      if (board[y-1][x] == 0) {
        board[y-1][x] = board[y][x];
        board[y][x] = 0;
      }

      else {
        if (board[y-1][x] == board[y][x]) {
            board[y-1][x]++;
            board[y][x] = 0;
            skip = y+1;
        }
      }
   }

   else if (dir == "DOWN") {
      while (board[y+1][x] == 0 && y < skip) {
         board[y+1][x] = board[y][x];
         board[y][x] = 0;
         y++;
      }

      if (board[y+1][x] == 0) {
        board[y+1][x] = board[y][x];
        board[y][x] = 0;
      }

      else {
        if (board[y+1][x] == board[y][x]) {
            board[y+1][x]++;
            board[y][x] = 0;
            skip = y-1;
        }
      }
   }

   else if (dir == "LEFT") {
      while (board[y][x-1] == 0 && x > skip) {
         board[y][x-1] = board[y][x];
         board[y][x] = 0;
         x--;
      }

      if (board[y][x-1] == 0) {
        board[y][x-1] = board[y][x];
        board[y][x] = 0;
      }

      else {
        if (board[y][x-1] == board[y][x]) {
            board[y][x-1]++;
            board[y][x] = 0;
            skip = x+1;
        }
      }
   }

   else if (dir == "RIGHT") {
      while (board[y][x+1] == 0 && x < skip) {
         board[y][x+1] = board[y][x];
         board[y][x] = 0;
         x++;
      }

      if (board[y][x+1] == 0) {
        board[y][x+1] = board[y][x];
        board[y][x] = 0;
      }

      else {
        if (board[y][x+1] == board[y][x]) {
            board[y][x+1]++;
            board[y][x] = 0;
            skip = x-1;
        }
      }
   }
   
   return skip;
}

boolean checkWin()
{
  for (int i = 0; i < 4; i++)
    for (int j = 0; j < 4; j++) 
      if (board[i][j] == 11) 
        return true;
  
  return false;
}

///////// CONFIRMERS

boolean up()
{
  for (int x = 0; x < 4; x++) {
        for (int y = 1; y < 4; y++) {
          if (board[y][x] != 0) {
            if (board[y-1][x] == 0) return true;
            else if (board[y-1][x] == board[y][x]) return true;
          }
        }
      }
   return false;
}

boolean right()
{
   for (int y = 0; y < 4; y++) {
        for (int x = 2; x >= 0; x--) {
         if (board[y][x] != 0) {
           if (board[y][x+1] == 0) return true;
           else if (board[y][x+1] == board[y][x]) return true;
         }
     }
   }
   
   return false;
}

boolean down()
{
  for (int x = 0; x < 4; x++) {
        for (int y = 2; y >= 0; y--) {
          if (board[y][x] != 0) {
            if (board[y+1][x] == 0) return true;
            else if (board[y+1][x] == board[y][x]) return true;
          }
       }
  }
  
  return false;
}

boolean left()
{
  for (int y = 0; y < 4; y++) {
       for (int x = 1; x < 4; x++) {
          if (board[y][x] != 0) {
            if (board[y][x-1] == 0) return true;
            else if (board[y][x-1] == board[y][x]) return true;
          }
      }
    }
  return false;
}

////////////////////// KEYPRESSED ////////////////////////

// this is the essense of program: waits for keypress, runs on keypress
void keyPressed()
{
  if ((key == 'w' || key == 'W' )&& up()) program('w');
  if ((key == 's' || key == 'S') && down()) program('s');
  if ((key == 'a' || key == 'A') && left()) program('a');
  if ((key == 'd' || key == 'D') && right()) program('d');
}

// program
void program(char p)
{
     move(p);
     updateBoard();
     if(checkLoss())
     {
        fill(0);
        rect(0, 0, 500, 700);
        fill(255);
        text("You lose!", 250, 250);
     }
     if(checkWin())
     {
        fill(0);
        rect(0, 0, 500, 700);
        fill(255);
        text("You win!", 250, 250);
     }

     if(!checkFilled()) {
       placeBlock();
       updateBoard();
     }
     if(checkLoss())
     {
        fill(0, 0, 0, 128);
        rect(0, 0, 500, 700);
        fill(255);
        text("You lose!", 250, 250);
     }
     
     if(checkWin())
     {
        fill(0, 0, 0);
        rect(0, 0, 500, 700);
        fill(255);
        text("You win!", 250, 250);
     }
     
     message(Integer.toString(score()));
}

///////////////// HELPER /////////////////

// clears the board
void clearBoard()
{
  size(500, 700);

  stroke(187, 173, 160);
  fill(187, 173, 160);
  rect(0, 0, 500, 500);

  fill(0);
  rect(0, 500, 500, 200);

  stroke(192, 192, 192);
  fill(192, 192, 192);
  for (int i = 0; i < 4; i++)
    for (int j = 0; j < 4; j++)
      rect(16 + 121*i, 16 + 121*j, 105, 105, 3, 3, 3, 3);
}

// calculates score
int score()
{
  int score = 0;
  
  for (int i = 0; i < 4; i++)
    for (int j = 0; j < 4; j++)
      if (board[i][j] != 0) score += (int)pow(2, board[i][j]);

  return score;
}

// outputs message on bottom
void message(String mes)
{
  fill(0);
  rect(0, 500, 500, 200);

  textSize(100);
  textAlign(CENTER);
  fill(150);
  text(mes, 250, 635);
}
