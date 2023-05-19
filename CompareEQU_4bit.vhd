----------------------------------------------------------------------------
-- Entity:        CompareEQU_4bit
-- Written By:    Cory Drangel
-- Date Created:  16 Nov 22
-- Description:   VHDL model of an 8-bit equality comparitor
--
-- Revision History (date, initials, description):
--  11/16/2022      -CJD    -defined internal signals
--                          -implemented logic for equality comparitor
--  12/6/2022       -CJD    -modified logic from 8 bit to 4 bit
--
-- Dependencies:
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity CompareEQU_4bit is
    port (
        A   : in  STD_LOGIC_VECTOR(3 downto 0);
        B   : in  STD_LOGIC_VECTOR(3 downto 0);
        EQU : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of CompareEQU_4bit is

    -- internal signals --
    signal n0 : STD_LOGIC;
    signal n1 : STD_LOGIC;
    signal n2 : STD_LOGIC;
    signal n3 : STD_LOGIC;
    
begin

    n0 <= A(0) xnor B(0);
    n1 <= A(1) xnor B(1);
    n2 <= A(2) xnor B(2);
    n3 <= A(3) xnor B(3);
    
    EQU <= n0 and n1 and n2 and n3;
	
end architecture;
