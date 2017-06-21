-- First of all, defining the main part of 4-bit Adder; the full adder
library ieee;
use ieee.std_logic_1164.all;
--
entity Full_Adder is
   port( X, Y, Cin : in std_logic; -- Full adder inputs; x, y and Cin a carry input 
         sum, Cout : out std_logic); -- Full adder output; the sum and Cout a carry output
end Full_Adder;


architecture dataflow of Full_Adder is -- defining the architecture of full adder as dataflow
begin
   sum <= (X xor Y) xor Cin; -- x and y sum
   Cout <= (X and (Y or Cin)) or (Cin and Y); -- carry of adding x and y
end dataflow;
--------------------------------------------------------------
-- By then; I define the logic to add or subtract two four bits numbers
library ieee;
use ieee.std_logic_1164.all;
entity adder is -- inputs here
   port( mode             : in std_logic; -- mode input; chooses to add our subtract given numbers;
          A  : in std_logic_vector (3 downto 0); -- first number input;
          B  : in std_logic_vector (3 downto 0); -- second number input;
          S  : out std_logic_vector (3 downto 0); -- summation output;
                  Cout : out std_logic); -- output carry 
end adder;

architecture struct of adder is -- addrer architecture as a structure

   component Full_Adder is	         -- define the main part component - a full adder with it's inputs & outputs
      port( X, Y, Cin : in std_logic;
            sum, Cout : out std_logic);
   end component;


   signal C1, C2, C3, C4: std_logic; -- four signals to hold carries

begin -- contecting wires in my circuit

   FA0: Full_Adder port map(A(0), B(0) xor mode, mode,  S(0), C1);-- map using a0, b0 and mode to S0 and c1; 
   FA1: Full_Adder port map(A(1), B(1) xor mode, C1,  S(1), C2);  -- map using a2, b2, c1 and mode to S1 and c2; 
   FA2: Full_Adder port map(A(2), B(2) xor mode, C2,  S(2), C3);  -- map using a3, b3, c2 and mode to S2 and c3; 
   FA3: Full_Adder port map(A(3), B(3) xor mode, C3,  S(3), C4);  -- map using a4, b4, c3 and mode to S3 and c4; 

   Cout <= C4;                                       -- set Cout; carry of summation
end struct;
