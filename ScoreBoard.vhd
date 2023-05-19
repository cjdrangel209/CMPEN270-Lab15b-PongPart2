----------------------------------------------------------------------------
-- Entity:        ScoreBoard
-- Written By:    Cory Drangel
-- Date Created:  7 Dec 22
-- Description:   VHDL model of the score board for a Pong game
--
-- Revision History (date, initials, description):
--  12/7/2022       -CJD    -modified header comments
--                          -ScoreBoardFSM declared and instantiated
--                          -ScoreBoardDatapath declared and instantiated
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity ScoreBoard is
    port (
        P1POINT : in  STD_LOGIC;
        P2POINT : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        P1SCORE : out STD_LOGIC_VECTOR(7 downto 0);
        P2SCORE : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of ScoreBoard is

    component ScoreBoardFSM is
    port(
        P1POINT : in  STD_LOGIC;
        P2POINT : in  STD_LOGIC;
        EQU10   : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        LOADP1  : out STD_LOGIC;
        LOADP2  : out STD_LOGIC;
        P1ORP2  : out STD_LOGIC;
        ADD1OR6 : out STD_LOGIC
    );
    end component;
    
    component ScoreBoardDatapath is
    port(
        LOADP1  : in  STD_LOGIC;
        LOADP2  : in  STD_LOGIC;
        P1ORP2  : in  STD_LOGIC;
        ADD1OR6 : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        P1SCORE : out STD_LOGIC_VECTOR(7 downto 0);
        P2SCORE : out STD_LOGIC_VECTOR(7 downto 0);
        EQU10   : out STD_LOGIC
    );
    end component;

    -- internal signals --
    signal equ10_int : STD_LOGIC;
    signal loadP1_int : STD_LOGIC;
    signal loadP2_int : STD_LOGIC;
    signal p1OrP2_int : STD_LOGIC;
    signal add1Or6_int : STD_LOGIC;
    signal p1Score_int : STD_LOGIC_VECTOR(7 downto 0);
    signal p2Score_int : STD_LOGIC_VECTOR(7 downto 0);

begin

    sbFSM : ScoreBoardFSM
    port map(
        P1POINT => P1POINT,
        P2POINT => P2POINT,
        EQU10 => equ10_int,
        CLK => CLK,
        RESET => RESET,
        LOADP1 => loadP1_int,
        LOADP2 => loadP2_int,
        P1ORP2 => p1OrP2_int,
        ADD1OR6 => add1Or6_int
    );
    
    sbDP : ScoreBoardDatapath
    port map(
        LOADP1 => loadP1_int,
        LOADP2 => loadP2_int,
        P1ORP2 => p1OrP2_int,
        ADD1OR6 => add1Or6_int,
        CLK => CLK,
        RESET => RESET,
        P1SCORE => p1Score_int(7 downto 0),
        P2SCORE => p2Score_int(7 downto 0),
        EQU10 => equ10_int
    );
    
    P1SCORE <= p1Score_int(7 downto 0);
    P2SCORE <= p2Score_int(7 downto 0);

end architecture;
