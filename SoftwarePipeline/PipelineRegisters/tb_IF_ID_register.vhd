--Noah Peake
--tb_IF_ID_register.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_IF_ID_register is
  generic(gCLK_HPER   : time := 10 ns);
end tb_IF_ID_register;

architecture mixed of tb_IF_ID_register is

constant cCLK_PER  : time := gCLK_HPER * 2;

component IF_ID_register is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;
       i_upc        : in std_logic_vector(31 downto 0);
       i_imem       : in std_logic_vector(31 downto 0);
       o_upc        : out std_logic_vector(31 downto 0);
       o_imem       : out std_logic_vector(31 downto 0));

end component;
signal s_CLK        : std_logic; 
signal s_RST        : std_logic := '0';
signal s_upc        : std_logic_vector(31 downto 0) := x"00000000";
signal s_imem       : std_logic_vector(31 downto 0) := x"00000000";
signal so_upc        : std_logic_vector(31 downto 0);
signal so_imem       : std_logic_vector(31 downto 0);

begin

DUT0: IF_ID_register
  port map(i_CLK  =>  s_CLK,  
           i_RST  =>  s_RST, 
           i_upc  =>  s_upc, 
           i_imem =>  s_imem,
           o_upc  =>  so_upc, 
           o_imem =>  so_imem);

P_LK: process
  begin
    s_CLK <= '0';
    wait for gCLK_HPER;
    s_CLK <= '1';
    wait for gCLK_HPER;
  end process;

p_testcase: process
begin
wait for gCLK_HPER*2;

 --Reset
 s_RST <= '1';
 s_upc <= x"00000000"; 
 s_imem <= x"00000000";
 wait for gCLK_HPER*2;

 --Input register tests
 s_RST <= '0';
 s_upc <= x"00100101"; 
 s_imem <= x"00011111";
 wait for gCLK_HPER*2;

 s_RST <= '0';
 s_upc <= x"11001101"; 
 s_imem <= x"01010100";
 wait for gCLK_HPER*2;

end process;
end mixed;
