--Noah Peake
--nbit_barrelshifter.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity nbit_barrelshifter is
    generic(N : integer := 32);
    port(i_S_LR : in std_logic; --Left/Right select: 0 Left/ 1 Right
         i_S_LA : in std_logic; --Logical/Arithmetic select: 0 Log/1 Arith
         i_amt : in std_logic_vector(4 downto 0); --0 bit is no change 1 bit is change (decided per round)
 	 i_D : in std_logic_vector(N-1 downto 0);
	 o_O : out std_logic_vector(N-1 downto 0));
end nbit_barrelshifter;

architecture mixed of nbit_barrelshifter is

  component mux2t1_structural is
    port(i_S                  : in std_logic;
         i_D0                 : in std_logic;
         i_D1                 : in std_logic;
         o_O                  : out std_logic);
  end component;
  
  component reverse is 
    generic(N : integer := 32);
    port(i_A : in std_logic_vector(N-1 downto 0);
         i_S : in std_logic;
         o_rev : out std_logic_vector(N-1 downto 0));
  end component;

--type arr is array (0 to 5) of std_logic_vector(31 downto 0);
--signal s_interm : arr;
signal s_interm0 : std_logic_vector(31 downto 0);
signal s_interm1 : std_logic_vector(31 downto 0);
signal s_interm2 : std_logic_vector(31 downto 0);
signal s_interm3 : std_logic_vector(31 downto 0);
signal s_interm4 : std_logic_vector(31 downto 0);
signal s_interm5 : std_logic_vector(31 downto 0);
signal s_sign : std_logic;

begin
--Choose between left and right 
  g_rev: reverse
    port map(i_A => i_D,
             i_S => i_S_LR,
             o_rev => s_interm0);
--Arithmetic bit to use if needed
   g_arith: mux2t1_structural
    port map(i_S => i_S_LA,
             i_D0 => '0',
             i_D1 => i_D(31),
             o_O => s_sign);
--Round 1 (1 bit)
  g_mux0: for i in 1 to 31 generate
    muxi: mux2t1_structural
      port map(i_S => i_amt(0),
               i_D0 => s_interm0(i),
               i_D1 => s_interm0(i-1), --bit shifts to previous
               o_O => s_interm1(i));
  end generate g_mux0; 
  g_mux0_2: mux2t1_structural 
     port map(i_S => i_amt(0),
              i_D0 => s_interm0(0), 
              i_D1 => s_sign,
              o_O => s_interm1(0));
--Round 2 (2 bit)
  g_mux1: for i in 2 to 31 generate
    muxi: mux2t1_structural
      port map(i_S => i_amt(1),
               i_D0 => s_interm1(i),
               i_D1 => s_interm1(i-2), --bit shifts to previous
               o_O => s_interm2(i));
  end generate g_mux1;
  g_mux1_2: for i in 0 to 1 generate
    muxi: mux2t1_structural
     port map(i_S => i_amt(1),
              i_D0 => s_interm1(i),
              i_D1 => s_sign, 
              o_O => s_interm2(i));
  end generate g_mux1_2;
--Round 3 (4 bit)
  g_mux2: for i in 4 to 31 generate
    muxi: mux2t1_structural
      port map(i_S => i_amt(2),
               i_D0 => s_interm2(i),
               i_D1 => s_interm2(i-4), --bit shifts to previous
               o_O => s_interm3(i));
  end generate g_mux2;  
  g_mux2_2: for i in 0 to 3 generate 
     muxi: mux2t1_structural
     port map(i_S => i_amt(2),
              i_D0 => s_interm2(i),
              i_D1 => s_sign, 
              o_O => s_interm3(i));
  end generate g_mux2_2;
--Round 4 (8 bit)
  g_mux3: for i in 8 to 31 generate
    muxi: mux2t1_structural
      port map(i_S => i_amt(3),
               i_D0 => s_interm3(i),
               i_D1 => s_interm3(i-8), --bit shifts to previous
               o_O => s_interm4(i));
  end generate g_mux3;  
  g_mux3_2: for i in 0 to 7 generate  
     muxi: mux2t1_structural
     port map(i_S => i_amt(3),
              i_D0 => s_interm3(i),
              i_D1 => s_sign, 
              o_O => s_interm4(i));
  end generate g_mux3_2;
--Round 5 (16 bit)
  g_mux4: for i in 16 to 31 generate
    muxi: mux2t1_structural
      port map(i_S => i_amt(4),
               i_D0 => s_interm4(i),
               i_D1 => s_interm4(i-16), --bit shifts to previous
               o_O => s_interm5(i));
  end generate g_mux4;

  g_mux4_2: for i in 0 to 15 generate 
     muxi: mux2t1_structural
     port map(i_S => i_amt(4),
              i_D0 => s_interm4(i),
              i_D1 => s_sign, 
              o_O => s_interm5(i));
  end generate g_mux4_2;

--Reverse back if needed
  g_revb: reverse
    port map(i_A => s_interm5,
             i_S => i_S_LR,
             o_rev => o_O); 

end mixed;
