import UIKit
//true == 1, false == 0

//create a matrix ("uiTable") to represent input table UI as seen below..
/*                      | UMN      |  LMN  |  fib.../PSW | fascic... | neur...denervation |
 bulbar                 |  R0,C0   | R0,C1 |       ?     |       ?   |       R0, C4       |
 cervical               |  R1,C0   |   ?   |       ?     |       ?   |       ?            |
 thoracic               |  R2,C0   |   ?   |       ?     |       ?   |       ?            |
 lumbosacral            |  R3,C0   |   ?   |       ?     |       ?   |       ?            |
 
 family-history...      |  R?,C?   |   ?   |       ?     |       ?   |       ?            |
 UMN-rostral_LMN...     |  R?,C?   |   ?   |       ?     |       ?   |       ?            |
*/

/* will use a separate matrix for the el escorial algorithms
 
 */

let row = 4 //rows
let col = 5 // cols
//Make 4x5 matrix:
var uiTable = [[Bool]](repeating: [Bool](repeating: false, count: col), count: row) //create uiTable matrix (holds input values)

print(uiTable)

var umnUICol = [Bool](repeating: false, count: row) //initialize umnUICol array (later fill with uiTable col), makes 1x4 array
var lmnUICol = [Bool](repeating: false, count: row)
var pswUICol = [Bool](repeating: false, count: row)
var fasUICol = [Bool](repeating: false, count: row)
var neuUICol = [Bool](repeating: false, count: row)

//Fill each col with whatever the table inputs are:
func fillColArrs(uiTable: [[Bool]]){
    for i in 0..<row {    //goes through uiTable row by row
        umnUICol.insert(uiTable[i][0], at: 0) //fill umnUICol array with first col of uiTable matrix
        lmnUICol.insert(uiTable[i][1], at: 0)
        pswUICol.insert(uiTable[i][2], at: 0)
        fasUICol.insert(uiTable[i][3], at: 0)
        neuUICol.insert(uiTable[i][4], at: 0)
    }
}

print(umnUICol)
/* Create function that takes in specific region and 1) tells you the region in which it is present ('TRUE'), then passes info along....
 // OKAY just try and do one case and theN make a function to duplicate!!
 */

//UMN + LMN:
var bothUmnLmn = [Bool](repeating: false, count: col)

for i in 0..<col {
    if(umnUICol[i] && lmnUICol[i] == true){
        bothUmnLmn[i] = true
    }
}

//The following 3 for statements are a recreation of the excel alogarithms created for UMN>=LMN case:
//1. UMN >= LMN (col 1):
var moreUmn = [Bool](repeating: false, count: col) //UMN>=LMN algorithm previously created (returns true or false)
var moreUmnBlk = [Bool](repeating: false, count: col) //UMN>=LMN algorithm previously created (returns true, false or blank)

for i in 0..<col { //
    if(umnUICol[i] == false && lmnUICol[i] == true){ //only case moreUMn is false is if lmn > umn
        moreUmn[i] = false
    } else {moreUmn[i] = true}
}

//2. UMN >= LMN (col 2):
for i in 0..<col {
    //=IF(AND($M2=TRUE,$B2=FALSE,$C2=FALSE),"BLANK","")
    if(moreUmn[i] == true && umnUICol[i] == false && lmnUICol[i] == false){
        moreUmnBlk[i] = true
    }
}

//3. Right-most col of El Escorial table:



//****************************************************************************************************

//Number of Regions:
func regionCount(Array: [Bool], startCount:Int)->Int{ //startCount = when in the desired array do you want to start counting amt of 'true' elements
    var counter = 0
    for i in startCount..<col {
        if(Array[i] == true){
            counter += 1
        }
    }
    return counter
}

//count all regions (including bulbar), (tally how many regions have UMN, LMN or UMN&LMN present)
var umnLmnRegion = regionCount(Array: bothUmnLmn, startCount: 0)
var umnRegion = regionCount(Array: umnUICol, startCount: 0)
var lmnRegion = regionCount(Array: lmnUICol, startCount: 0)

//count UMN or LMN non-bulbar regions only! (tally how many regions have UMN or LMN present)
var umnNoBulb = regionCount(Array: umnUICol, startCount: 1)
var lmnNoBulb = regionCount(Array: lmnUICol, startCount: 1)



/********************************************** Algorithms *********************************************/

var finalResult = 0; //represents if a result has been found/calculated yet

//Definite:
//=IF( OR(AND($J$3=TRUE,$J$4=TRUE,$J$5=TRUE),AND($K$2=TRUE,$L$2=TRUE,$K$7>1,$L$7>1) ), "Definite", "")
if(bothUmnLmn[1] == true && bothUmnLmn[2] == true && bothUmnLmn[3] == true || umnUICol[0] == true && lmnUICol[0] == true && umnNoBulb>1 && lmnNoBulb>1){
    finalResult = 1
    print("Definite")
} else{ print("N/A") }


/*
//Probable:
//=IF(AND($K$6>1,$L$6>1,$J$8="",$O$8=TRUE,$B$7=TRUE),"Probable", "")
if(umnRegion>1 && lmnRegion>1 && finalResult == 0 && ){
    print("Probable")
} else{ print("N/A") }

 */

//Possible
//=IF(      AND(    OR($J$6>=1,$K$6>=2),J$8="",J$9=""   ),"Possible", ""    )
var possibleCounter = 0
if( umnLmnRegion >= 1 && lmnRegion >=2 ){
    possibleCounter = 1
}
if( possibleCounter == 1 && finalResult == 0 ){
    print("Possible")
    finalResult = 1
} else{ print("N/A") }

//Suspected
//=IF(AND(L$6>=2,J$8="",J$9="",J$10=""),"Suspected", "")
if( lmnRegion >=2 && finalResult ==0){
    print("Suspected")
    finalResult = 1
} else{ print("N/A")}




