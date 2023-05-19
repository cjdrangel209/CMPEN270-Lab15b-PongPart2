----------------------------------------------------------------------------
-- Entity:        Synch
-- Written By:    Cory Drangel
-- Date Created:  1 Nov 22
-- Description:   VHDL model of a synchronizer
--
-- Revision History (date, initials, description):
--  11/1/2022       -CJD    -modified header comments
--                          -defined and instantiated 2 DFF components
--                          -declared internal signal D2
--
-- Dependencies:
--   DFF
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Synch is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of Synch is

    component DFF is
    port(
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
    end component;

    -- internal signal --
    signal D2 : STD_LOGIC;

begin
    
    dff0 : DFF
    port map(
        D => D,
        CLK => CLK,
        Q => D2
    );
    
    dff1 : DFF
    port map(
        D => D2,
        CLK => CLK,
        Q => Q
    );

end architecture;
