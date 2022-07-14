-------------------------------------------------------------------------
-- Tyler Miller
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mips_data_path.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit Register
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mips_data_path is
  generic(N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE	    : in std_logic;
       i_rs	    : in std_logic_vector(4 downto 0);
       i_rd         : in std_logic_vector(4 downto 0);
       i_rt         : in std_logic_vector(4 downto 0); 
       nAdd_Sub     : in std_logic;
       ALUSrc       : in std_logic;
       immd         : in std_logic_vector(31 downto 0);   
       o_C	    : out std_logic;
       test_rs      : out std_logic_vector(N-1 downto 0);
       test_rt      : out std_logic_vector(N-1 downto 0);
       test_ALU_O   : out std_logic_vector(N-1 downto 0));  
end mips_data_path;

architecture mixed of mips_data_path is

component mips_register_file is
generic(N : integer := 32);
 port(
       i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;
       i_rs	    : in std_logic_vector(4 downto 0);
       i_rd         : in std_logic_vector(4 downto 0);
       i_rt         : in std_logic_vector(4 downto 0);
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q1         : out std_logic_vector(N-1 downto 0);  -- Data value output
       o_Q2         : out std_logic_vector(N-1 downto 0));  -- Data value output
end component;


component add_sub_N is
 generic( N : integer := 32);
        port(
	A             : in std_logic_vector(N-1 downto 0);
        B             : in std_logic_vector(N-1 downto 0);
        nAdd_Sub     : in std_logic;
        ALUSrc	      : in std_logic;
        immd          : in std_logic_vector(N-1 downto 0);
        o_S           : out std_logic_vector(N-1 downto 0);
        o_C	      : out std_logic);
end component;

signal o_RT: std_logic_vector(31 downto 0);
signal o_RS: std_logic_vector(31 downto 0);
signal o_Data: std_logic_vector(31 downto 0) := x"00000000";

begin



G_MIPS_FILE : mips_register_file port map(
	i_CLK => i_CLK,
	i_RST => i_RST,
	i_WE => i_WE,
	i_rs => i_rs,
	i_rd => i_rd,
	i_rt => i_rt,
	i_D => o_Data,
	o_Q1 => o_RS,
	o_Q2 => o_RT
);
test_rs <= o_RS;
test_rt <= o_RT;

G_ADDSUB: add_sub_N port map(
	A => o_RS,
	B => o_RT,
	nAdd_Sub => nAdd_Sub,
	ALUSrc => ALUSrc,
	immd => immd,
	o_S => o_Data,
	o_C => o_C

);

test_ALU_O <= o_Data;

 end mixed;
