import 'dart:html';
import 'dart:math';

Map<LIElement, Dice> diceMap;
var diceUList;
var resultsUList;
var numDiceTextBox;

void main() {
  diceMap = new Map<LIElement, Dice>();
  diceUList = querySelector("#dice_list");
  resultsUList = querySelector("#results_list");
  numDiceTextBox = querySelector("#dice_side_num");
  
  querySelector("#add_dice_button")
    ..onClick.listen(AddDiceButtonPressed);
  querySelector("#remove_dice_button")
    ..onClick.listen(RemoveAllDiceButtonPressed);
  querySelector("#roll_button")
    ..onClick.listen(RollButtonPressed);
  querySelector("#clear_button")
    ..onClick.listen(ClearResultsButtonPressed);
}

void AddDiceButtonPressed(MouseEvent event)
{
  if(numDiceTextBox.value == null)
    window.alert("Please enter the number of sides for this dice.");
  else
  {
    int numSides;
    try {
      numSides = int.parse(numDiceTextBox.value);
    }
    on FormatException {
      window.alert("Number of sides for dice is not valid");
      return;
    }
    
    Dice d = new Dice(numSides);
    var newLI = new LIElement();
    newLI.text = "d" + numSides.toString();
    var deleteBtn = new ButtonElement();
    deleteBtn.text = "-";
    deleteBtn.onClick.listen(RemoveSingleDiceButtonPressed);
    newLI.children.add(deleteBtn);
    diceUList.children.add(newLI);
    diceMap[newLI] = d;
  }
}

void RemoveSingleDiceButtonPressed(MouseEvent event)
{
  var li = event.target.parent;
  if(li != null)
  {
    li.remove();
    if(diceMap.containsKey(li))
      diceMap.remove(li);
  }
}

void RemoveAllDiceButtonPressed(MouseEvent event)
{
  diceUList.children.clear();
  diceMap.clear();
}

void RollButtonPressed(MouseEvent event)
{
  var newLI = new LIElement();
  var range = new Random();
  int rolledTotal = 0;
  diceMap.forEach((li, dice) { 
    int rolled = dice.Roll();
    rolledTotal += rolled;
  });
  newLI.text = rolledTotal.toString();
  resultsUList.children.add(newLI);
}

void ClearResultsButtonPressed(MouseEvent event)
{
  resultsUList.children.clear();
}

class Dice
{
  int sides;
  
  Dice(this.sides);
  
  int Roll()
  {
    var range = new Random();
    return range.nextInt(sides - 1) + 1;
  }
}