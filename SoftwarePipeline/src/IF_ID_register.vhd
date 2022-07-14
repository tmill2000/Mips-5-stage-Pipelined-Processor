--Noah Peake
--IF_ID_register.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity IF_ID_register is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;
       i_upc        : in std_logic_vector(31 downto 0);
       i_imem       : in std_logic_vector(31 downto 0);
       o_upc        : out std_logic_vector(31 downto 0);          
       o_imem       : out std_logic_vector(31 downto 0));
end IF_ID_register;

architecture structural of IF_ID_register is

component n_bit_register is
  generic(N : integer := 32);
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_WE         : in std_logic;     -- Write enable input
         i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
         o_Q          : out std_logic_vector(N-1 downto 0));  -- Data value output

end component;

begin

  PCReg: n_bit_register
    port map(i_CLK => i_CLK, 
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_upc,
             o_Q => o_upc);
  ImemReg: n_bit_register
    port map(i_CLK => i_CLK, 
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_imem,
             o_Q => o_imem);

end structural;
