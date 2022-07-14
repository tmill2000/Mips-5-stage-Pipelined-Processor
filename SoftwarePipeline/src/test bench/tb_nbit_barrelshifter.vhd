--Noah Peake
--tb_nbit_barrelshifter.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_nbit_barrelshifter is
  generic(gCLK_HPER   : time := 10 ns);
end tb_nbit_barrelshifter;

architecture mixed of tb_nbit_barrelshifter is

  constant cCLK_PER : time := gCLK_HPER * 2;

  component nbit_barrelshifter 
    generic(N : integer := 32);
    port(i_S_LR : in std_logic;
         i_S_LA : in std_logic;
         i_amt : in std_logic_vector(4 downto 0);
         i_D : in std_logic_vector(N-1 downto 0);
         o_O : out std_logic_vector(N-1 downto 0));
  end component;

signal s_S_LR : std_logic := '0';
signal s_S_LA : std_logic := '0';
signal s_amt : std_logic_vector(4 downto 0) := "00000";
signal s_D : std_logic_vector(31 downto 0) := x"00000000";
signal s_O : std_logic_vector(31 downto 0) := x"00000000";

begin

DUT0: nbit_barrelshifter
  port map(i_S_LR => s_S_LR,
           i_S_LA => s_S_LA,
           i_amt => s_amt,
           i_D => s_D,
           o_O => s_O);

--P_CLK: process
--  begin
--    i_CLK <= '0';
--    wait for gCLK_HPER;
--    i_CLK <= '1';
--    wait for gCLK_HPER;
-- end process;

 -- Testbench process  
  P_TB: process
  begin
    wait for gCLK_HPER/2;
--LOGIC
  --Shift left 2
  s_S_LR <= '0';
  s_S_LA <= '0';
  s_amt <= "00010";
  s_D <= x"000FFFFF";
 wait for gCLK_HPER*2;

  --Shift left 16
  s_S_LR <= '0';
  s_S_LA <= '0';
  s_amt <= "10000";
  s_D <= x"000FFFFF";
 wait for gCLK_HPER*2;

  --Shift left 12
  s_S_LR <= '0';
  s_S_LA <= '0';
  s_amt <= "01100";
  s_D <= x"000FFFFF";
 wait for gCLK_HPER*2;

  --Shift left 8
  s_S_LR <= '0';
  s_S_LA <= '0';
  s_amt <= "01000";
  s_D <= x"000FFFFF";
 wait for gCLK_HPER*2;

  --Shift left 14
  s_S_LR <= '0';
  s_S_LA <= '0';
  s_amt <= "01110";
  s_D <= x"000FFFFF";
 wait for gCLK_HPER*2;

  --Shift right 2
  s_S_LR <= '1';
  s_S_LA <= '0';
  s_amt <= "00010";
  s_D <= x"FFFFF000";
 wait for gCLK_HPER*2;

  --Shift right 16
  s_S_LR <= '1';
  s_S_LA <= '0';
  s_amt <= "10000";
  s_D <= x"FFFFF000";
 wait for gCLK_HPER*2;
 
  --Shift right 12
  s_S_LR <= '1';
  s_S_LA <= '0';
  s_amt <= "01100";
  s_D <= x"FFFFF000";
 wait for gCLK_HPER*2;

  --Shift right 8
  s_S_LR <= '1';
  s_S_LA <= '0';
  s_amt <= "01000";
  s_D <= x"0FFFFFFF";
 wait for gCLK_HPER*2;

  --Shift right 14
  s_S_LR <= '1';
  s_S_LA <= '0';
  s_amt <= "01110";
  s_D <= x"F0FFFFFF";
 wait for gCLK_HPER*2;

--ARITHMETIC
  --Shift right 2
  s_S_LR <= '1';
  s_S_LA <= '1';
  s_amt <= "00010";
  s_D <= x"FFFFF000";
 wait for gCLK_HPER*2;

  --Shift right 16
  s_S_LR <= '1';
  s_S_LA <= '1';
  s_amt <= "10000";
  s_D <= x"FFFFF000";
 wait for gCLK_HPER*2;
 
  --Shift right 12
  s_S_LR <= '1';
  s_S_LA <= '1';
  s_amt <= "01100";
  s_D <= x"FFFFF000";
 wait for gCLK_HPER*2;

  --Shift right 10
  s_S_LR <= '1';
  s_S_LA <= '1';
  s_amt <= "01000";
  s_D <= x"FFFFF000";
 wait for gCLK_HPER*2;

  --Shift right 8
  s_S_LR <= '1';
  s_S_LA <= '1';
  s_amt <= "01000";
  s_D <= x"0FFFFFFF";
 wait for gCLK_HPER*2;

  --Shift right 14
  s_S_LR <= '1';
  s_S_LA <= '1';
  s_amt <= "01110";
  s_D <= x"F0FFFFFF";
 wait for gCLK_HPER*2;

end process;
end mixed;
