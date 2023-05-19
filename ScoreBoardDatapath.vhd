----------------------------------------------------------------------------
-- Entity:        ScoreBoardDatapath
-- Written By:    Cory Drangel
-- Date Created:  6 Dec 22
-- Description:   VHDL model of the score board datapath for a Pong game
--
-- Revision History (date, initials, description):
--  12/6/2022       -CJD    -modified header comments 
--                          -8 bit registers declared and instantiated
--                          -4 bit CompareEQU declared and instantiated
--                          -declared and instantiated 2 8 bit muxs
--                          -adder delcared and instantiated
--
-- Dependencies:
--   FA
--  Reg_LOAD_CLR_8bit
--  CompareEQU_4bit
--  Mux2to1_8bit
--  Adder_8bit
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity ScoreBoardDatapath is
    port (
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
end entity;
----------------------------------------------------------------------------

architecture Structural of ScoreBoardDatapath is

    component Reg_LOAD_CLR_8bit is
    port(
        D    : in  STD_LOGIC_VECTOR(7 downto 0);
        CLK  : in  STD_LOGIC;
        LOAD : in  STD_LOGIC;
        CLR  : in  STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR(7 downto 0)
    );
    end component;
    
    component CompareEQU_4bit is
    port(
        A   : in  STD_LOGIC_VECTOR(3 downto 0);
        B   : in  STD_LOGIC_VECTOR(3 downto 0);
        EQU : out STD_LOGIC
    );
    end component;
    
    component Mux2to1_8bit is
    port(
        D0  : in  STD_LOGIC_VECTOR (7 downto 0);
        D1  : in  STD_LOGIC_VECTOR (7 downto 0);
        SEL : in  STD_LOGIC;
        Y   : out STD_LOGIC_VECTOR (7 downto 0)
    );
    end component;
    
    component Adder_8bit is
    port(
        A   : in  STD_LOGIC_VECTOR (7 downto 0);
        B   : in  STD_LOGIC_VECTOR (7 downto 0);
        SUM : out STD_LOGIC_VECTOR (7 downto 0)
    );
    end component;
    
    -- internal signals --
    signal adderToReg : STD_LOGIC_VECTOR(7 downto 0);
    signal P1SCORE_int : STD_LOGIC_VECTOR(7 downto 0);
    signal P2SCORE_int : STD_LOGIC_VECTOR(7 downto 0);
    signal P1orP2mux_int : STD_LOGIC_VECTOR(7 downto 0);
    signal Add1or6mux_int : STD_LOGIC_VECTOR(7 downto 0);

begin

    reg1 : Reg_LOAD_CLR_8bit
    port map(
        D => adderToReg(7 downto 0),
        CLK => CLK,
        LOAD => LOADP1,
        CLR => RESET,
        Q => P1SCORE_int(7 downto 0)
    );
    
    P1SCORE <= P1SCORE_int(7 downto 0);
    
    reg2 : Reg_LOAD_CLR_8bit
    port map(
        D => adderToReg(7 downto 0),
        CLK => CLK,
        LOAD => LOADP2,
        CLR => RESET,
        Q => P2SCORE_int(7 downto 0)
    );
    
    P2SCORE <= P2SCORE_int(7 downto 0);

    compare : CompareEQU_4bit
    port map(
        A => P1orP2mux_int(3 downto 0),
        B => "1010",
        EQU => EQU10
    );
    
    P1orP2mux : Mux2to1_8bit
    port map(
        D0 => P1SCORE_int(7 downto 0),
        D1 => P2SCORE_int(7 downto 0),
        SEL => P1ORP2,
        Y => P1orP2mux_int(7 downto 0)
    );
    
    add1or6mux : Mux2to1_8bit
    port map(
        D0 => "00000001",
        D1 => "00000110",
        SEL => ADD1OR6,
        Y => Add1or6mux_int(7 downto 0)
    );
    
    adder : Adder_8bit
    port map(
        A => Add1or6mux_int(7 downto 0),
        B => P1orP2mux_int(7 downto 0),
        SUM => adderToReg(7 downto 0)
    );
end architecture;
