----------------------------------------------------------------------------
-- Entity:        Decoder2to4_ALO
-- Written By:    Cory Drangel
-- Date Created:  28 Sept 22
-- Description:   VHDL model of a 2 to 4 decoder with active low outputs
--
-- Revision History (date, initials, description):
--  9/28/2022   -CJD    -added the logic for the different outputs
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Decoder2to4_ALO is
    port (
        A : in  STD_LOGIC_VECTOR(1 downto 0);
        Y : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of Decoder2to4_ALO is

begin

    Y(3) <= not (A(0) and A(1));
    Y(2) <= not (not A(0) and A(1));
    Y(1) <= not (A(0) and not A(1));
    Y(0) <= not (not A(0) and not A(1));

end architecture;
