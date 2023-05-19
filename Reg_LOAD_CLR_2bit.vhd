----------------------------------------------------------------------------
-- Entity:        Reg_LOAD_CLR_2bit
-- Written By:    Cory Drangel
-- Date Created:  12 Oct 22
-- Description:   VHDL model of a 2-bit register with load and clear
--
-- Revision History (date, initials, description):
--  10/12/2022      -CJD    -added DFF_EN_RESET to components
--                          -implemented 2 DFF_EN_RESET's in logic
--
-- Dependencies:
--   DFF_EN_RESET
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Reg_LOAD_CLR_2bit is
    port (
        D    : in  STD_LOGIC_VECTOR(1 downto 0);
        CLK  : in  STD_LOGIC;
        LOAD : in  STD_LOGIC;
        CLR  : in  STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR(1 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of Reg_LOAD_CLR_2bit is

    component DFF_EN_RESET is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        EN    : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
    end component;    

begin

    dffenres0 : DFF_EN_RESET
    port map (
        D => D(0),
        CLK => CLK,
        EN => LOAD,
        RESET => CLR,
        Q => Q(0)
    );

    dffenres1 : DFF_EN_RESET
    port map (
        D => D(1),
        CLK => CLK,
        EN => LOAD,
        RESET => CLR,
        Q => Q(1)
    );

end architecture;
