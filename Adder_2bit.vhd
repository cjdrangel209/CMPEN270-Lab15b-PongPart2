----------------------------------------------------------------------------
-- Entity:        Adder_2bit
-- Written By:    Cory Drangel
-- Date Created:  12 Oct 22
-- Description:   VHDL model of a 2-bit ripple-carry adder
--
-- Revision History (date, initials, description):
--  10/12/2022      -CJD    -instantiated and implemented 2 FullAdders
--
-- Dependencies:
--   FA
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Adder_2bit is
    port (
        A  : in  STD_LOGIC_VECTOR (1 downto 0);
        B  : in  STD_LOGIC_VECTOR (1 downto 0);
        Ci : in  STD_LOGIC;
        Co : out STD_LOGIC;
        S  : out STD_LOGIC_VECTOR (1 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of Adder_2bit is

    component FullAdder is
    port(
        A  : in  STD_LOGIC;
        B  : in  STD_LOGIC;
        Ci : in  STD_LOGIC;
        Co : out STD_LOGIC;
        S  : out STD_LOGIC
    );
    end component;
    
    --internal signals--
    signal C0 : STD_LOGIC;
    signal C1 : STD_LOGIC;
    signal C2 : STD_LOGIC;

begin

    C0 <= Ci;

    adder0 : FullAdder
    port map(
        A => A(0),
        B => B(0),
        Ci => C0,
        Co => C1,
        S => S(0)
    );
    
    adder1 : FullAdder
    port map(
        A => A(1),
        B => B(1),
        Ci => C1,
        Co => C2,
        S => S(1)
    );
    
    Co <= C2;

end architecture;

