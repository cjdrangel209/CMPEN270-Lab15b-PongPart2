----------------------------------------------------------------------------
-- Entity:        DFF_EN_RESET
-- Written By:    Cory Drangel
-- Date Created:  6 Oct 22
-- Description:   VHDL model of a D flip-flop with enable and reset
--
-- Revision History (date, initials, description):
--  10/6/2022       -CJD        -declared components for mux 2 to 1 and d flip flop
--                              -instantiated mux and d flip flop
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity DFF_EN_RESET is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        EN    : in  STD_LOGIC;
        RESET : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of DFF_EN_RESET is

    component Mux2to1 is
        port (
            D0 : in STD_LOGIC;
            D1 : in STD_LOGIC;
            SEL: in STD_LOGIC;
            Y  : out STD_LOGIC
        );
    end component;
    
    component DFF is
        port (
            D    : in  STD_LOGIC;
            CLK  : in  STD_LOGIC;
            Q    : out STD_LOGIC
        );
    end component;
    
    -- internal signals --
    signal n1 : STD_LOGIC;
    signal n2 : STD_LOGIC;
    signal Q_int : STD_LOGIC;

begin

    n2 <= n1 and not RESET;
    
    mux1 : Mux2to1
    port map (
        D0 => Q_int,
        D1 => D,
        SEL => EN,
        Y => n1
    );
    
    dff1 : DFF
    port map (
        D => n2,
        CLK => CLK,
        Q => Q_int
    );
    
    Q <= Q_int;

end architecture;
