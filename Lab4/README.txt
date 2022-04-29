
## LL1 PARSER

Group Name: ShubhamVikasCS321
Group Members:
-   Shubham Jhawar - 1901194
-   Vikas Rajput - 1901216



## Contribution:

The individual contribution of the members were as follows:-
1.) Vikas - Implemented first and follow.
2.) Shubham - Implemented the elimination of left recursion.
The rest of the work like Reading the grammar was done.

Rest of the work was done by us. 
## assumptions


Our main assumptions related to our parser and guidelines for the users are as follows-

-   Epsilon is represented by '@'.
-   Productions can be of the form:

    S -> A alpha | beta | @
    OR
    S -> A alpha
    S -> beta
    S -> @

    where S is a NonTerminal and RHS has set of rules spearted by '|' or a single rule with spaces between each symbol(T or NT) or @ reprsesenting epsilon.

-   Only Single Upper Case Alphabets are Non-Terminals and everything else is a terminal.
-   The L.H.S. of the first production rule is the start symbol.
-   '$' should not be in grammar as it is reserved for stack parsing.
-   All input Strings have to end with a '$'.
-   If the grammar has a left recursion which cannot be terminated, then our parser will throw an error.
-   If the grammar is not LL1, a relevant error message will be higlighted.


## Usage

-   For giving Grammar and Expressions on console
    `python code.py`

-   For giving Grammar through a file and Expressions on console
    `python code.py grammar.txt`

-   For giving Grammar and Expressions through file
    `python code.py grammar.txt expression.txt`

## Sample Input and Output

HERE'S A SAMPLE INPUT- OUTPUT FOR CONVENIENCE

INPUT:

grammar.txt

E -> E + T | E - T
E -> T
T -> T * F| T / F | F
F -> ( E ) | num | id

expression.txt

id + id * id $
id + * id $

OUTPUT:

> Non-terminal E has Left recursion !
> Non-terminal T has Left recursion !

Unambigous productions generated are:
E -> TE'
T -> FT'
F -> (E) | num | id
E' -> @ | +TE' | -TE'
T' -> @ | *FT' | /FT'

         NonTerminal          |            FIRST             |            FOLLOW
 --------------------------------------------------------------------------------------------
              E               |          num, id, (          |             $, )
              T               |          num, id, (          |          $, +, -, )
              F               |          num, id, (          |       /, $, *, +, -, )
              E'              |           -, @, +            |             $, )
              T'              |           /, @, *            |          -, $, +, )

LL1 Predictive Parsing Table

        |   /    |   *    |   id   |   -    |   (    |  num   |   $    |   +    |   )
-----------------------------------------------------------------------------------------
   F    |        |        |   id   |        |  (E)   |  num   |        |        |
-----------------------------------------------------------------------------------------
   E'   |        |        |        |  -TE'  |        |        |   @    |  +TE'  |   @
-----------------------------------------------------------------------------------------
   T'   |  /FT'  |  *FT'  |        |   @    |        |        |   @    |   @    |   @
-----------------------------------------------------------------------------------------
   E    |        |        |  TE'   |        |  TE'   |  TE'   |        |        |
-----------------------------------------------------------------------------------------
   T    |        |        |  FT'   |        |  FT'   |  FT'   |        |        |
-----------------------------------------------------------------------------------------

>> Expression: id + id * id $
            Stack             |            Input             |            Action
 --------------------------------------------------------------------------------------------
             $ E              |        id + id * id $        |       Expand by E->TE'
            $ E' T            |        id + id * id $        |       Expand by T->FT'
          $ E' T' F           |        id + id * id $        |       Expand by F->id
          $ E' T' id          |        id + id * id $        |          Matched id
           $ E' T'            |         + id * id $          |       Expand by T'->@
             $ E'             |         + id * id $          |      Expand by E'->+TE'
           $ E' T +           |         + id * id $          |          Matched +
            $ E' T            |          id * id $           |       Expand by T->FT'
          $ E' T' F           |          id * id $           |       Expand by F->id
          $ E' T' id          |          id * id $           |          Matched id
           $ E' T'            |            * id $            |      Expand by T'->*FT'
         $ E' T' F *          |            * id $            |          Matched *
          $ E' T' F           |             id $             |       Expand by F->id
          $ E' T' id          |             id $             |          Matched id
           $ E' T'            |              $               |       Expand by T'->@
             $ E'             |              $               |       Expand by E'->@
              $               |              $               |          Matched $
----------------------------------->>Expression accepted<<-----------------------------------

>> Expression: id + * id $
            Stack             |            Input             |            Action
 --------------------------------------------------------------------------------------------
             $ E              |         id + * id $          |       Expand by E->TE'
            $ E' T            |         id + * id $          |       Expand by T->FT'
          $ E' T' F           |         id + * id $          |       Expand by F->id
          $ E' T' id          |         id + * id $          |          Matched id
           $ E' T'            |           + * id $           |       Expand by T'->@
             $ E'             |           + * id $           |      Expand by E'->+TE'
           $ E' T +           |           + * id $           |          Matched +
            $ E' T            |            * id $
 --------------------------------->>Expression NOT accepted<<---------------------------------

## INTRODUCTION:

We have made an LL1 parser in Python which takes the CFG as an input
and generates the First set, and Follow set for each non - Terminal in grammar and displays its corresponding LL(1) Predictive Parsing Table
after eliminating any left recursion which may exist in the grammar.

Upon Execting the file and providing the grammar, it will ask the user for a expression to demonstrate the action of the LL(1) parsing.
Each step of the LL(1) parsing is highlighted along with the final result which is the string will either get accepted or rejected.