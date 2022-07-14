-------------------------------------------------------------------------
-- Tyler Miller
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_mux_32_bit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a simple VHDL testbench for the n bit register
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mux_32_bit is
  generic(gCLK_HPER   : time := 50 ns);
end tb_mux_32_bit;

architecture behavior of tb_mux_32_bit is
  
  -- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;


  component mux_32_bit
    port(
        i_S		             : in std_logic_vector(4 downto 0);
	i_D0                         : in std_logic_vector(31 downto 0);
	i_D1                         : in std_logic_vector(31 downto 0);
	i_D2                         : in std_logic_vector(31 downto 0);
	i_D3                         : in std_logic_vector(31 downto 0);
	i_D4                         : in std_logic_vector(31 downto 0);
	i_D5                         : in std_logic_vector(31 downto 0);
	i_D6                         : in std_logic_vector(31 downto 0);
	i_D7                         : in std_logic_vector(31 downto 0);
	i_D8                         : in std_logic_vector(31 downto 0);
	i_D9                         : in std_logic_vector(31 downto 0);
	i_D10                        : in std_logic_vector(31 downto 0);
	i_D11                        : in std_logic_vector(31 downto 0);
	i_D12                        : in std_logic_vector(31 downto 0);
	i_D13                        : in std_logic_vector(31 downto 0);
	i_D14                        : in std_logic_vector(31 downto 0);
	i_D15                        : in std_logic_vector(31 downto 0);
	i_D16                        : in std_logic_vector(31 downto 0);
	i_D17                        : in std_logic_vector(31 downto 0);
	i_D18                        : in std_logic_vector(31 downto 0);
	i_D19                        : in std_logic_vector(31 downto 0);
	i_D20                        : in std_logic_vector(31 downto 0);
	i_D21                        : in std_logic_vector(31 downto 0);
	i_D22                        : in std_logic_vector(31 downto 0);
	i_D23                        : in std_logic_vector(31 downto 0);
	i_D24                        : in std_logic_vector(31 downto 0);
	i_D25                        : in std_logic_vector(31 downto 0);
	i_D26                        : in std_logic_vector(31 downto 0);
	i_D27                        : in std_logic_vector(31 downto 0);
	i_D28                        : in std_logic_vector(31 downto 0);
	i_D29                        : in std_logic_vector(31 downto 0);
	i_D30                        : in std_logic_vector(31 downto 0);
	i_D31                        : in std_logic_vector(31 downto 0);
	o_O		             : out std_logic_vector(31 downto 0));
  end component;

  -- Temporary signals to connect to the dff component.
  


        signal i_S 			     : std_logic_vector(4 downto 0) := "00000";
	signal i_D0 			     : std_logic_vector(31 downto 0) := x"00000000";
	signal i_D1                          : std_logic_vector(31 downto 0) := x"00000000";
	signal i_D2                          : std_logic_vector(31 downto 0) := x"00000000";
	signal i_D3                          : std_logic_vector(31 downto 0) := x"00000000";
	signal i_D4                          : std_logic_vector(31 downto 0) := x"00000000";
	signal i_D5                          : std_logic_vector(31 downto 0) := x"00000000";
	signal i_D6                          : std_logic_vector(31 downto 0) := x"00000000";
	signal i_D7                          : std_logic_vector(31 downto 0) := x"00000000"; 
	signal i_D8                          : std_logic_vector(31 downto 0) := x"00000000";
	signal i_D9                          : std_logic_vector(31 downto 0) := x"00000000";
	signal i_D10                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D11                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D12                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D13                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D14                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D15                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D16                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D17                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D18                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D19                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D20                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D21                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D22                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D23                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D24                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D25                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D26                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D27                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D28                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D29                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D30                         : std_logic_vector(31 downto 0):= x"00000000";
	signal i_D31                         : std_logic_vector(31 downto 0):= x"00000000";
	signal o_O		             : std_logic_vector(31 downto 0);

begin

  DUT: mux_32_bit
  port map(
        i_S => i_S,
	i_D0 => i_D0,
	i_D1 => i_D1,
	i_D2 => i_D2,
	i_D3 => i_D3,
	i_D4 => i_D4,
	i_D5 => i_D5,
	i_D6 => i_D6,
	i_D7 => i_D7,
	i_D8 => i_D8,
	i_D9 => i_D9,
	i_D10 => i_D10,
	i_D11 => i_D11,
	i_D12 => i_D12,
	i_D13 => i_D13,
	i_D14 => i_D14,
	i_D15 => i_D15,
	i_D16 => i_D16,
	i_D17 => i_D17,
	i_D18 => i_D18,
	i_D19 => i_D19,
	i_D20 => i_D20,
	i_D21 => i_D21,
	i_D22 => i_D22,
	i_D23 => i_D23,
	i_D24 => i_D24,
	i_D25 => i_D25,
	i_D26 => i_D26,
	i_D27 => i_D27,
	i_D28 => i_D28,
	i_D29 => i_D29,
	i_D30 => i_D30,
	i_D31 => i_D31,
        o_O => o_O);
  
  -- Testbench process  
  P_TB: process
  begin
    wait for gCLK_HPER/2;
    -- Reset the FF
    i_S <= "00000";
    i_D0 <= x"FFFF0000";
    wait for cCLK_PER;

    i_S <= "00001";
    i_D1 <= x"F000000F";
    wait for cCLK_PER;

    i_S <= "00010";
    i_D2 <= x"10000001";
    wait for cCLK_PER;

    i_S <= "00011";
    i_D3 <= x"FFFFFFFF";
    wait for cCLK_PER;

    i_S <= "00100";
    i_D4 <= x"00000004";
    wait for cCLK_PER;

    i_S <= "00101";
    i_D5 <= x"00000008";
    wait for cCLK_PER;

    i_S <= "00110";
    i_D6 <= x"80000008";
    wait for cCLK_PER;

    i_S <= "00111";
    i_D7 <= x"70000070";
    wait for cCLK_PER;

    i_S <= "11101";
    i_D29 <= x"00000008";
    wait for cCLK_PER;
 
    i_S <= "11110";
    i_D30 <= x"00000011";
    wait for cCLK_PER;

    i_S <= "11111";
    i_D31 <= x"FFFFFFFF";
    wait for cCLK_PER;

    wait;
  end process;
  
end behavior;