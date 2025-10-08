# Game of Loop

## Things to add

### Audio

- clicks
- removenig cells
- iteration changes
- music

### QoL

- button (middle click) to select color from grid
- grid clear button
- scrollable timeline of iterations
- always accesible sandbox level where you can try out different cells
- pop-up if not all cells are spend
- sellected cell visual
- animation of cells between iterations (purple cell converst white cell)

### Turorial

- more easy levels
- explain the rules
- difficulty modes based on information given to player

## Technical design 

### All places using cell type:
- level layout
- editing grid
- simulation grid
- cell type select


### Cell edit attributes
- Cell type
- locked for editing 


### What I want in the game:

- main menu
- level select
- level
- sandbox level
- rules page


### Gui editable cell behaviour

#### Cell attributes 
- Type 
- Priority
- When born
- When survive
- When die
- Color


Priority system

var cell_priority: Array = [DESTROYER, BASIC]



Cell condition
Type of cell to detect and its amount
Then what cell to become

## Ideas

levels with borders that connect to the opposite side
