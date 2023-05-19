----------------------------------------------------------------------------
-- Entity:        Debounce
-- Written By:    Cory Drangel
-- Date Created:  1 Nov 22
-- Description:   VHDL model of a debouncer
--
-- Revision History (date, initials, description):
--  11/1/2022       -CJD    -modified header comments
--                          -defined and instantiated 2 DFF_EN_RESET components
--                          -declared internal signals D2 and Q2
--
-- Dependencies:
--   DFF_EN_RESET
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Debounce is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        PULSE : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of Debounce is

    component DFF_EN_RESET is
    port(
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        EN    : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
    end component;
    
    -- internal signals --
    signal D2 : STD_LOGIC;
    signal Q2 : STD_LOGIC;

begin

    dffenreset0 : DFF_EN_RESET
    port map(
        D => D,
        CLK => CLK,
        EN => PULSE,
        RESET => '0',
        Q => D2
    );
    
    dffenreset1 : DFF_EN_RESET
    port map(
        D => D2,
        CLK => CLK,
        EN => PULSE,
        RESET => '0',
        Q => Q2
    );
    
    Q <= Q2 and D2;
    
end architecture;
