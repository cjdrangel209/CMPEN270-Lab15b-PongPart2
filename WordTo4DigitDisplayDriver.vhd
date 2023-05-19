----------------------------------------------------------------------------
-- Entity:        WordTo4DigitDisplayDriver
-- Written By:    Cory Drangel
-- Date Created:  12 Oct 22
-- Description:   VHDL model of a word to 4-digit 7-segment display driver
--
-- Revision History (date, initials, description):
--  10/12/2022      -CJD    -added declaration and instantiation for Hexto7SegDecoder
--                          -added declaration and instantiation for Mux4to1_4bit
--                          -added declaration and instantiation for Decoder2to4_ALO
--                          -added declaration and instantiation for Counter_2bit
--
-- Dependencies:
--   (none)
----------------------------------------------------------------------------
library IEEE;
use     IEEE.STD_LOGIC_1164.ALL;

----------------------------------------------------------------------------
entity WordTo4DigitDisplayDriver is
    port (
        WORD    : in  STD_LOGIC_VECTOR(15 downto 0);
        PULSE   : in  STD_LOGIC;
        CLK     : in  STD_LOGIC;
        SEGMENT : out STD_LOGIC_VECTOR(0 to 6);
		ANODE   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;
----------------------------------------------------------------------------

architecture Structural of WordTo4DigitDisplayDriver is

    component HexTo7SegDecoder is
    port(
        HEX     : in  STD_LOGIC_VECTOR(3 downto 0);
        SEGMENT : out STD_LOGIC_VECTOR(0 to 6)
    );
    end component;
    
    component Mux4to1_4bit is
    port (
        D0  : in  STD_LOGIC_VECTOR(3 downto 0);
        D1  : in  STD_LOGIC_VECTOR(3 downto 0);
        D2  : in  STD_LOGIC_VECTOR(3 downto 0);
        D3  : in  STD_LOGIC_VECTOR(3 downto 0);
        SEL : in  STD_LOGIC_VECTOR(1 downto 0);
        Y   : out STD_LOGIC_VECTOR(3 downto 0)
    );
    end component;
    
    component Decoder2to4_ALO is
    port (
        A : in  STD_LOGIC_VECTOR(1 downto 0);
        Y : out STD_LOGIC_VECTOR(3 downto 0)
    );
    end component;
    
    component Counter_2bit is
    port (
        EN   : in  STD_LOGIC;
        CLK  : in  STD_LOGIC;
        CLR  : in  STD_LOGIC;
        ROLL : out STD_LOGIC;
        Q    : out STD_LOGIC_VECTOR(1 downto 0)
    );
    end component;
    
    --internal signals--
    signal curDigit : STD_LOGIC_VECTOR(3 downto 0);
    signal digitSelect : STD_LOGIC_VECTOR(1 downto 0);
    signal seg_int : STD_LOGIC_VECTOR(0 to 6);
    signal anode_int : STD_LOGIC_VECTOR(3 downto 0);    

begin

    hexdecoder : HexTo7SegDecoder
    port map (
        HEX => curDigit(3 downto 0),
        SEGMENT => seg_int(0 to 6)
    );
    
    SEGMENT(0 to 6) <= not seg_int(0 to 6);
    
    mux4to1 : Mux4to1_4bit
    port map (
        D0 => WORD(3 downto 0),
        D1 => WORD(7 downto 4),
        D2 => WORD(11 downto 8),
        D3 => WORD(15 downto 12),
        SEL => digitSelect(1 downto 0),
        Y => curDigit(3 downto 0)
    );
    
    decoder2t04 : Decoder2to4_ALO
    port map (
        A => digitSelect(1 downto 0),
        Y => anode_int(3 downto 0)
    );
    
    ANODE(3 downto 0) <= not anode_int(3 downto 0);
    
    counter2bit : Counter_2bit
    port map(
        EN => PULSE,
        CLK => CLK,
        CLR => '0',
        ROLL => open,
        Q => digitSelect(1 downto 0)
    );

end architecture;
