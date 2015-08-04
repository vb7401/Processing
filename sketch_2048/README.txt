2048 by Vivek Bhupatiraju

TABLE OF CONTENTS
-----------------

int board;
int boardCoor;

void setup();
void draw();

-- important --

boolean checkloss();
void placeBlock();
void updateBoard();
void move();
void slide();

-- keypressed --

void keyPressed();
void program();

-- helper --

void clearBoard();
int score();
void message();
void waitForExit();

BUGS
---- 

checkLoss() is bad YES
  - make checkLoss() -> checkFilled()
    - add to placeBlock() function -> prevents no space
  - add boolean functions that check if you can move up, down, left, or right
    - replace checkLoss() with a combination of all four
    
ADDITIONS
---------

updateBoard()
  - different colors for each square
  - OPTIONAL: animations

click to Restart()
 - OPTIONAL

high scores
- keep at bottom right