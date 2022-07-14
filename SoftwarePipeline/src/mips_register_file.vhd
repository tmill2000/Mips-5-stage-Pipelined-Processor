-------------------------------------------------------------------------
-- Tyler Miller
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mips_register_file.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit Register
--
--
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mips_register_file is
  generic(N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE	    : in std_logic;
       i_rs	    : in std_logic_vector(4 downto 0);
       i_rd         : in std_logic_vector(4 downto 0);
       i_rt         : in std_logic_vector(4 downto 0);
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q1         : out std_logic_vector(N-1 downto 0);  -- Data value output
       o_Q2         : out std_logic_vector(N-1 downto 0));  -- Data value output
end mips_register_file;

architecture mixed of mips_register_file is

component N_Bit_Register is
generic(N : integer := 32);
 port(
       i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic; 
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));
end component;

component five_bit_decoder is
  port(
       i_S		            : in std_logic_vector(4 downto 0);
       o_O		            : out std_logic_vector(31 downto 0));
end component;

component mux_32_bit is 
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

component andg2 is
	port(
		i_A	: in std_logic;
		i_B	: in std_logic;
		o_F	: out std_logic
	);
end component;


signal s_Decode : std_logic_vector(31 downto 0);
type ARR is array (31 downto 0) of std_logic_vector(31 downto 0);
signal s_Reg : ARR;
signal s_and : std_logic_vector(31 downto 0);


begin


G_decoder : five_bit_decoder port map(
	i_S => i_rd,
	o_O => s_Decode

);

G_AND: for i in 0 to N-1 generate
G_ANDI: andg2 port map(
	i_A => s_Decode(i),
	i_B => i_WE,
	o_F => s_and(i) 
);
end generate G_AND;


Reg0: N_Bit_Register port map(
	i_CLK => i_CLK,
	i_RST => '1',
	i_WE =>  s_and(0),
	i_D => i_D,
	o_Q => s_Reg(0)
	);


G_32Bit_Reg: for i in 1 to N-1 generate
	RegI: N_Bit_Register port map(
	i_CLK => i_CLK,
	i_RST => i_RST,
	i_WE =>  s_and(i),
	i_D => i_D,
	o_Q => s_Reg(i)
	);
end generate G_32Bit_Reg;


G_OutMux1 : mux_32_bit port map(
        i_S	   => i_rs,	             
	i_D0       => s_Reg(0),                 
	i_D1       => s_Reg(1),                  
	i_D2       => s_Reg(2),                 
	i_D3       => s_Reg(3),                  
	i_D4       => s_Reg(4),                 
	i_D5       => s_Reg(5),                 
	i_D6       => s_Reg(6),                
	i_D7       => s_Reg(7),              
	i_D8       => s_Reg(8),               
	i_D9       => s_Reg(9),                  
	i_D10      => s_Reg(10),                 
	i_D11      => s_Reg(11),                  
	i_D12      => s_Reg(12),                  
	i_D13      => s_Reg(13),                  
	i_D14      => s_Reg(14),                  
	i_D15      => s_Reg(15),                 
	i_D16      => s_Reg(16),                 
	i_D17      => s_Reg(17),                 
	i_D18      => s_Reg(18),                
	i_D19      => s_Reg(19),                 
	i_D20      => s_Reg(20),                 
	i_D21      => s_Reg(21),                 
	i_D22      => s_Reg(22),                 
	i_D23      => s_Reg(23),                 
	i_D24      => s_Reg(24),               
	i_D25      => s_Reg(25),                
	i_D26      => s_Reg(26),                
	i_D27      => s_Reg(27),                
	i_D28      => s_Reg(28),                
	i_D29      => s_Reg(29),                
	i_D30      => s_Reg(30),                
	i_D31      => s_Reg(31),                
	o_O	   => o_Q1             

);


G_OutMux2 : mux_32_bit port map(
        i_S	   => i_rt,	             
	i_D0       => s_Reg(0),                 
	i_D1       => s_Reg(1),                  
	i_D2       => s_Reg(2),                 
	i_D3       => s_Reg(3),                  
	i_D4       => s_Reg(4),                  
	i_D5       => s_Reg(5),                 
	i_D6       => s_Reg(6),                
	i_D7       => s_Reg(7),              
	i_D8       => s_Reg(8),               
	i_D9       => s_Reg(9),                  
	i_D10      => s_Reg(10),                  
	i_D11      => s_Reg(11),                  
	i_D12      => s_Reg(12),                  
	i_D13      => s_Reg(13),                  
	i_D14      => s_Reg(14),                  
	i_D15      => s_Reg(15),                 
	i_D16      => s_Reg(16),                 
	i_D17      => s_Reg(17),                 
	i_D18      => s_Reg(18),                
	i_D19      => s_Reg(19),                 
	i_D20      => s_Reg(20),                 
	i_D21      => s_Reg(21),                 
	i_D22      => s_Reg(22),                 
	i_D23      => s_Reg(23),                 
	i_D24      => s_Reg(24),               
	i_D25      => s_Reg(25),                
	i_D26      => s_Reg(26),                
	i_D27      => s_Reg(27),                
	i_D28      => s_Reg(28),                
	i_D29      => s_Reg(29),                
	i_D30      => s_Reg(30),                
	i_D31      => s_Reg(31),               
	o_O	   => o_Q2             
);
 end mixed;
