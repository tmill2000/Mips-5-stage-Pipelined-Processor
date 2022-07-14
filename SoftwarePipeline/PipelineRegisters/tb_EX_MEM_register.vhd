--Noah Peake
--tb_EX_MEM_register.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_EX_MEM_register is
  generic(gCLK_HPER   : time := 10 ns);
end tb_EX_MEM_register;

architecture mixed of tb_EX_MEM_register is

constant cCLK_PER  : time := gCLK_HPER * 2;

component EX_MEM_register is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;
       i_RegDst       : in std_logic;
       i_mem_read     : in std_logic;
       i_MemtoReg     : in std_logic;
       i_MemWr        : in std_logic;
       i_s_RegWr      : in std_logic;
       i_jal          : in std_logic;
       i_Halt         : in std_logic;
       i_ALUOut       : in std_logic_vector(31 downto 0);
       i_readrt       : in std_logic_vector(31 downto 0);
       i_upc          : in std_logic_vector(31 downto 0);
       i_imem         : in std_logic_vector(31 downto 0);

       o_RegDst       : out std_logic;
       o_mem_read     : out std_logic;
       o_MemtoReg     : out std_logic;
       o_MemWr        : out std_logic;
       o_s_RegWr      : out std_logic;
       o_jal          : out std_logic;
       o_Halt         : out std_logic;
       o_ALUOut       : out std_logic_vector(31 downto 0);
       o_readrt       : out std_logic_vector(31 downto 0);
       o_upc          : out std_logic_vector(31 downto 0);
       o_imem         : out std_logic_vector(31 downto 0));

end component;

signal s_CLK          : std_logic;
signal s_RST          : std_logic := '0';
signal s_RegDst       : std_logic := '0';
signal s_mem_read     : std_logic := '0';
signal s_MemtoReg     : std_logic := '0';
signal s_MemWr        : std_logic := '0';
signal s_s_RegWr      : std_logic := '0';
signal s_jal          : std_logic := '0';
signal s_Halt         : std_logic := '0';
signal s_ALUOut       : std_logic_vector(31 downto 0) := x"00000000";
signal s_readrt       : std_logic_vector(31 downto 0) := x"00000000";
signal s_upc          : std_logic_vector(31 downto 0) := x"00000000";
signal s_imem         : std_logic_vector(31 downto 0) := x"00000000";                                                    
signal so_RegDst       : std_logic := '0';
signal so_mem_read     : std_logic := '0';
signal so_MemtoReg     : std_logic := '0';
signal so_MemWr        : std_logic := '0';
signal so_s_RegWr      : std_logic := '0';
signal so_jal          : std_logic := '0';
signal so_Halt         : std_logic := '0';
signal so_ALUOut       : std_logic_vector(31 downto 0);
signal so_readrt       : std_logic_vector(31 downto 0);
signal so_upc          : std_logic_vector(31 downto 0);
signal so_imem         : std_logic_vector(31 downto 0);


begin
DUT0: EX_MEM_register
  port map(i_CLK       => s_CLK,
           i_RST       => s_RST,
           i_RegDst    => s_RegDst,  
           i_mem_read  => s_mem_read,
           i_MemtoReg  => s_MemtoReg,
           i_MemWr     => s_MemWr,   
           i_s_RegWr   => s_s_RegWr, 
           i_jal       => s_jal,     
           i_Halt      => s_Halt,    
           i_ALUOut    => s_ALUOut,  
           i_readrt    => s_readrt,  
           i_upc       => s_upc,     
           i_imem      => s_imem,    
           o_RegDst    => so_RegDst,  
           o_mem_read  => so_mem_read,
           o_MemtoReg  => so_MemtoReg,
           o_MemWr     => so_MemWr,   
           o_s_RegWr   => so_s_RegWr, 
           o_jal       => so_jal,     
           o_Halt      => so_Halt,    
           o_ALUOut    => so_ALUOut,  
           o_readrt    => so_readrt,  
           o_upc       => so_upc,     
           o_imem      => so_imem);

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
s_RST      <= '1'; 
s_RegDst   <= '0';
s_mem_read <= '0';
s_MemtoReg <= '0';
s_MemWr    <= '0';
s_s_RegWr  <= '0';
s_jal      <= '0';
s_Halt     <= '0';
s_ALUOut   <= x"00000000"; 
s_readrt   <= x"00000000"; 
s_upc      <= x"00000000"; 
s_imem     <= x"00000000"; 
wait for gCLK_HPER*2;

--Input tests
s_RST      <= '0'; 
s_RegDst   <= '1';
s_mem_read <= '0';
s_MemtoReg <= '1';
s_MemWr    <= '0';
s_s_RegWr  <= '1';
s_jal      <= '0';
s_Halt     <= '1';
s_ALUOut   <= x"00011000"; 
s_readrt   <= x"01000101"; 
s_upc      <= x"00101010"; 
s_imem     <= x"01110000"; 
wait for gCLK_HPER*2;

s_RST      <= '0'; 
s_RegDst   <= '0';
s_mem_read <= '1';
s_MemtoReg <= '0';
s_MemWr    <= '1';
s_s_RegWr  <= '0';
s_jal      <= '1';
s_Halt     <= '1';
s_ALUOut   <= x"11100000"; 
s_readrt   <= x"00011100"; 
s_upc      <= x"00000011"; 
s_imem     <= x"11101000"; 
wait for gCLK_HPER*2;

end process;
end mixed;
