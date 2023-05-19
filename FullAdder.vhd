----------------------------------------------------------------------------
-- Entity:        FullAdder
-- Written By:    Cory Drangel
-- Date Created:  11 Oct 22
-- Description:   VHDL model of a full adder.  Adds three bits, producing
--   a sum and a carry-out bit
--
-- Revision History (date, initials, description):
--  10/11/2022      -CJD    -added logic for Full Adder
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity FullAdder is
    port (
        A  : in  STD_LOGIC;
        B  : in  STD_LOGIC;
        Ci : in  STD_LOGIC;
        Co : out STD_LOGIC;
        S  : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of FullAdder is

begin

	Co <= (not A and B and Ci) or (A and not B and Ci) or (A and B and not Ci) or 
	       (A and B and Ci);
	S <= (not A and not B and Ci) or (not A and B and not Ci) or (A and not B and not Ci)
	       or (A and B and Ci);
	       
end architecture;
