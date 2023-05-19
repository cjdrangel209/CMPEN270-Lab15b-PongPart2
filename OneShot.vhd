----------------------------------------------------------------------------
-- Entity:        OneShot
-- Written By:    Cory Drangel
-- Date Created:  26 Oct 22
-- Description:   VHDL model of a one-shot (rising edge detector)
--  10/26/2022      -CJD    -modified header comments
--  10/27/2022      -CJD    -added delcaration and instantiated DFF
--                          -added additional logic
--
-- Revision History (date, initials, description):
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity OneShot is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of OneShot is

    component DFF is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
    end component;
    
    -- internal signals --
    signal nextState : STD_LOGIC;
    signal currentState: STD_LOGIC;

begin

    flipflop : DFF
    port map(
        D => nextState,
        CLK => CLK,
        Q => currentState
    );

    nextState <= not D;
    Q <= currentState and D;
   

end architecture;
