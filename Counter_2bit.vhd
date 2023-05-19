----------------------------------------------------------------------------
-- Entity:        Counter_2bit
-- Written By:    Cory Drangel
-- Date Created:  12 Oct 22
-- Description:   VHDL model of a 2-bit counter with enable and clear
--
-- Revision History (date, initials, description):
--  10/12/2022      -CJD    -instantiated 2bit adder and 2bit register and signals
--                          -implemented logic for adder and register
--
-- Dependencies:
--   Adder_4bit
--   Counter_4bit
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity Counter_2bit is
    port (
        EN   : in  STD_LOGIC;
        CLK  : in  STD_LOGIC;
        CLR  : in  STD_LOGIC;
        ROLL : out STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR(1 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of Counter_2bit is

    component Adder_2bit is
    port (
        A  : in  STD_LOGIC_VECTOR (1 downto 0);
        B  : in  STD_LOGIC_VECTOR (1 downto 0);
        Ci : in  STD_LOGIC;
        Co : out STD_LOGIC;
        S  : out STD_LOGIC_VECTOR (1 downto 0)
    );
    end component;
    
    component Reg_LOAD_CLR_2bit is
    port (
        D    : in  STD_LOGIC_VECTOR(1 downto 0);
        CLK  : in  STD_LOGIC;
        LOAD : in  STD_LOGIC;
        CLR  : in  STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR(1 downto 0)
    );
    end component;
    
    --internal signals--
    signal Q_int : STD_LOGIC_VECTOR (1 downto 0);
    signal nextCount : STD_LOGIC_VECTOR (1 downto 0);
    
begin

    adder : Adder_2bit
    port map(
        A => "01",
        B => Q_int(1 downto 0),
        Ci => '0',
        Co => ROLL,
        S => nextCount(1 downto 0)
    );
    
    reg : Reg_LOAD_CLR_2bit
    port map(
        D => nextCount(1 downto 0),
        CLK => CLK,
        LOAD => EN,
        CLR => CLR,
        Q => Q_int(1 downto 0)
    );
    
   Q(1 downto 0) <= Q_int(1 downto 0);
    
end architecture;
