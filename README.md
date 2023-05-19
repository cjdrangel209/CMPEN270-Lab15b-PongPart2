# CMPEN270-Lab15b-PongPart2
Build a circuit that uses the datapath and control approach

Functional Specification
In this lab you will improve on basic pong game made earlier. The game works the same except the score 
is shown on the 4-digit display. The score is shown in binary coded decimal (BCD).
1. I/O
a. Map switches to SWITCH, type STD_LOGIC_VECTOR(15 downto 0)
b. Map the left, right, up and down buttons to BTNL, BTNR, BTNU and BTND, type STD_LOGIC
c. Map the board clock to CLK, type STD_LOGIC
d. Map LEDs 15:0 to LED, type STD_LOGIC_VECTOR(15 downto 0)
e. Map 7-segment display segments to SEGMENT, type STD_LOGIC_VECTOR(0 to 6)
f. Map 7-segment display anodes to ANODE, type STD_LOGIC_VECTOR(3 downto 0)
2. Operation
a. Player 1 is on the left side and player 2 is on the right side.
b. The left button is the paddle for player 1 and the right button is the paddle for player 2.
c. The up button serves the ball.
d. When player 1 serves the ball, the LEDs move to the right. Player 2 must press the right button 
when LED 3, 2, or 1 is lit, or they lose the point and player 1 serves again. If player 2 presses the 
right button when LED 3, 2 or 1 is lit, the ball moves to the left and player 1 must press the left 
button when LED 14, 13 or 12 is lit or they lose the point and player 2 serves again. If player 1 
presses the left button when LED 14, 13 or 12 is lit, the ball moves to the right and play 
continues.
e. The down button resets the game, with player 1 ready to serve.
f. The score is shown on the 4-digit display in binary coded decimal. The two left digits are 
player 1's score and two right digits are player 2's score.

Discussion
This lab uses the datapath and control approach to implement a score board using binary coded decimal 
(BCD). Binary coded decimal uses 4-bits for each digit, just like hexadecimal. However, only decimal 
digits are displayed, so the resulting number is decimal. Counting in 2-digit BCD goes 08, 09, 10, 11, 
etc., compared to 08, 09, 0A, 0B, etc. in hexadecimal. One way to do this is to examine the least 
significant digit after adding one. If it is 'A' (1010 in binary), then six is added so the least significant 
digit becomes '0' and the most significant digit increases by one. The datapath consists of registers to 
store the values, an adder, an equality comparitor to check if the least significant digit is 'A', and 
multiplexers to select the proper values to add. The control circuit is an FSM that sequences through the 
steps and outputs con[Lab15b_TopLevel.pdf](https://github.com/cjdrangel209/CMPEN270-Lab15b-PongPart2/files/11512691/Lab15b_TopLevel.pdf)
[Lab15b_ScoreBoard.pdf](https://github.com/cjdrangel209/CMPEN270-Lab15b-PongPart2/files/11512692/Lab15b_ScoreBoard.pdf)
trol signals such as the load input to the registers and the select signals for the 
multiplexers.

[Lab15b_TopLevel.pdf](https://github.com/cjdrangel209/CMPEN270-Lab15b-PongPart2/files/11512695/Lab15b_TopLevel.pdf)
[Lab15b_ScoreBoard.pdf](https://github.com/cjdrangel209/CMPEN270-Lab15b-PongPart2/files/11512696/Lab15b_ScoreBoard.pdf)
