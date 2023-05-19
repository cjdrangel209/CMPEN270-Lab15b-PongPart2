--------------------------------------------------------------------------------
-- Entity:        Lab15b_cjd209
-- Written By:    Cory Drangel
-- Date Created:  5 Dec 22
-- Description:   CMPEN 270 Lab #15b starting VHDL
--
-- Revision History (date, initials, description):
--  12/5/2022       -CJD    -modified header content and entity name
--                          -synchs declared and instantiated
--                          -debounces declared and instantiated
--                          -one shots declared and instantiated
--                          -pulse generator 1 ms declared and instantiated
--                          -pulse generator 125 ms declared and instantiated
--                          -display FSM declared and instantiated
--  12/6/2022       -CJD    -control FSM declared and instantiated
--                          -modified header comments and entity name
--  12/7/2022       -CJD    -declared and instantiated ScoreBoard component
--                          -declared and instantiated WordTo4DigitDisplayDriver component
--
-- Dependencies:
--  Synch
--  Debounce
--  OneShot
--  PulseGenerator_1ms
--  PulseGenerator_125ms
--  DisplayFSM
--  ControlFSM
--  ScoreBoard
--  WordToDigitDisplayDriver
--------------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

--------------------------------------------------------------------------------
entity Lab15b_cjd209 is
    port (
		SWITCH  : in  STD_LOGIC_VECTOR(15 downto 0);
		BTNL    : in  STD_LOGIC;
		BTNR    : in  STD_LOGIC;
		BTNU    : in  STD_LOGIC;
		BTND    : in  STD_LOGIC;
		CLK     : in  STD_LOGIC;
		LED     : out STD_LOGIC_VECTOR(15 downto 0);
		SEGMENT : out STD_LOGIC_VECTOR(0 to 6);
        ANODE   : out STD_LOGIC_VECTOR(3 downto 0)
	);
end entity;
--------------------------------------------------------------------------------

architecture Structural of Lab15b_cjd209 is

    component Synch is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
    end component;
    
    component Debounce is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        PULSE : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
    end component;
    
    component OneShot is
    port (
        D     : in  STD_LOGIC;
        CLK   : in  STD_LOGIC;
        Q     : out STD_LOGIC
    );
    end component;
    
    component PulseGenerator_1ms is
    port (
        CLK    : in  STD_LOGIC;
        PULSE  : out STD_LOGIC
    );
    end component;
    
    component PulseGenerator_125ms is
    port (
        CLK    : in  STD_LOGIC;
        PULSE  : out STD_LOGIC        
    );
    end component;
    
    component DisplayFSM is
    port(
        MOVELEFT  : in  STD_LOGIC;
        MOVERIGHT : in  STD_LOGIC;
        P1RTS     : in  STD_LOGIC;
        P1POINT   : in  STD_LOGIC;
        P2RTS     : in  STD_LOGIC;
        P2POINT   : in  STD_LOGIC;
        CLK       : in  STD_LOGIC;
        RESET     : in  STD_LOGIC;
        POS       : out STD_LOGIC_VECTOR(15 downto 0)
    );
    end component;
    
    component ControlFSM is
    port (
        BTNU      : in  STD_LOGIC;
        BTNL      : in  STD_LOGIC;
        BTNR      : in  STD_LOGIC;
        POS       : in  STD_LOGIC_VECTOR(15 downto 0);
        CLK       : in  STD_LOGIC;
        RESET     : in  STD_LOGIC;
        MOVELEFT  : out STD_LOGIC;
        MOVERIGHT : out STD_LOGIC;
        P1RTS     : out STD_LOGIC;
        P1POINT   : out STD_LOGIC;
        P2RTS     : out STD_LOGIC;
        P2POINT   : out STD_LOGIC
    );
    end component;
    
    component ScoreBoard is
    port(
        P1POINT : in  STD_LOGIC;
        P2POINT : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        RESET   : in  STD_LOGIC;
        P1SCORE : out STD_LOGIC_VECTOR(7 downto 0);
        P2SCORE : out STD_LOGIC_VECTOR(7 downto 0)
    );
    end component;
    
    component WordTo4DigitDisplayDriver is
    port(
        WORD    : in  STD_LOGIC_VECTOR(15 downto 0);
        PULSE   : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        SEGMENT : out STD_LOGIC_VECTOR(0 to 6);
        ANODE   : out STD_LOGIC_VECTOR(3 downto 0)
    );
    end component;
    
    -- internal signals --
    signal synch2debounce1 : STD_LOGIC;
    signal synch2debounce2 : STD_LOGIC;
    signal pulse_1ms : STD_LOGIC;
    signal debounce21shot1 : STD_LOGIC;
    signal debounce21shot2 : STD_LOGIC;
    signal oneShot2cntrlFSM1 : STD_LOGIC;
    signal oneShot2cntrlFSM2 : STD_LOGIC;
    signal pulse_125ms : STD_LOGIC;
    signal pos_int : STD_LOGIC_VECTOR(15 downto 0);
    signal moveLeft_int : STD_LOGIC;
    signal moveRight_int : STD_LOGIC;
    signal p1Rts_int : STD_LOGIC;
    signal p1Point_int : STD_LOGIC;
    signal p2Rts_int : STD_LOGIC;
    signal p2Point_int : STD_LOGIC;
    signal dMoveLeft : STD_LOGIC;
    signal dMoveRight : STD_LOGIC;
    signal displayWord : STD_LOGIC_VECTOR(15 downto 0);
    signal segment_int : STD_LOGIC_VECTOR(0 to 6);
    signal anode_int : STD_LOGIC_VECTOR(3 downto 0);

begin

    synch_l : Synch
    port map(
        D => BTNL,
        CLK => CLK,
        Q => synch2debounce1
    );
    
    synch_r : Synch
    port map(
        D => BTNR,
        CLK => CLK,
        Q => synch2debounce2
    );
    
    debounce_l : Debounce
    port map(
        D => synch2debounce1,
        CLK => CLK,
        PULSE => pulse_1ms,
        Q => debounce21shot1
    );
    
    debounce_r : Debounce
    port map(
        D => synch2debounce2,
        CLK => CLK,
        PULSE => pulse_1ms,
        Q => debounce21shot2
    );
    
    oneShot_l : OneShot
    port map(
        D => debounce21shot1,
        CLK => CLK,
        Q => oneShot2cntrlFSM1
    );
    
    oneShot_r : OneShot
    port map(
        D => debounce21shot2,
        CLK => CLK,
        Q => oneShot2cntrlFSM2
    );
    
    pulseGenerator_1 : PulseGenerator_1ms
    port map(
        CLK => CLK,
        PULSE => pulse_1ms
    );
    
    pulseGenerator_125 : PulseGenerator_125ms
    port map(
        CLK => CLK,
        PULSE => pulse_125ms
    );
    
    dFSM : DisplayFSM
    port map(
        MOVELEFT => dMoveLeft,
        MOVERIGHT => dMoveRight,
        P1RTS => p1Rts_int,
        P1POINT => p1Point_int,
        P2RTS => p2Rts_int,
        P2POINT => p2Point_int,
        CLK => CLK,
        RESET => BTND,
        POS => pos_int(15 downto 0)
    );
    
    LED(15 downto 0) <= pos_int(15 downto 0);
    
    cFSM : ControlFSM
    port map(
        BTNU => BTNU,
        BTNL => oneShot2cntrlFSM1,
        BTNR => oneShot2cntrlFSM2,
        POS => pos_int(15 downto 0),
        CLK => CLK,
        RESET => BTND,
        MOVELEFT => moveLeft_int,
        MOVERIGHT => moveRight_int,
        P1RTS => p1Rts_int,
        P1POINT => p1Point_int,
        P2RTS => p2Rts_int,
        P2POINT => p2Point_int
    );
    
    dMoveLeft <= moveLeft_int and pulse_125ms;
    dMoveRight <= moveRight_int and pulse_125ms;
    
    sb : ScoreBoard
    port map(
        P1POINT => p1Point_int,
        P2POINT => p2Point_int,
        CLK => CLK,
        RESET => BTND,
        P1SCORE => displayWord(15 downto 8),
        P2SCORE => displayWord(7 downto 0)
    );
    
    wordTo4DigitDisplay : WordTo4DigitDisplayDriver
    port map(
        WORD => displayWord(15 downto 0),
        PULSE => pulse_1ms,
        CLK => CLK,
        SEGMENT => segment_int(0 to 6),
        ANODE => anode_int(3 downto 0)
    );
    
    SEGMENT(0 to 6) <= not segment_int(0 to 6);
    ANODE(3 downto 0) <= not anode_int(3 downto 0);
    
end architecture;
