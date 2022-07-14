--Noah Peake
--tb_ID_EX_register.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_ID_EX_register is
  generic(gCLK_HPER   : time := 10 ns);
end tb_ID_EX_register;

architecture mixed of tb_ID_EX_register is

constant cCLK_PER  : time := gCLK_HPER * 2;

component ID_EX_register is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;
       i_RegDst       : in std_logic;
       i_mem_read     : in std_logic;
       i_MemtoReg     : in std_logic;
       i_MemWr        : in std_logic;
       i_ALUControl   : in std_logic_vector(3 downto 0);
       i_ALUSrc       : in std_logic;
       i_s_LR         : in std_logic;
       i_s_LA         : in std_logic;
       i_s_amt        : in std_logic_vector(4 downto 0);
       i_s_RegWr      : in std_logic;
       i_signed_ext   : in std_logic;
       i_jal          : in std_logic;
       i_ovfl         : in std_logic;
       i_Halt         : in std_logic;
       i_repl_qb      : in std_logic_vector(7 downto 0);
       i_readrs       : in std_logic_vector(31 downto 0);
       i_readrt       : in std_logic_vector(31 downto 0);
       i_ext          : in std_logic_vector(31 downto 0);
       i_upc          : in std_logic_vector(31 downto 0);
       i_imem         : in std_logic_vector(31 downto 0);

       o_RegDst       : out std_logic;
       o_mem_read     : out std_logic;
       o_MemtoReg     : out std_logic;
       o_MemWr        : out std_logic;
       o_ALUControl   : out std_logic_vector(3 downto 0);
       o_ALUSrc       : out std_logic;
       o_s_LR         : out std_logic;
       o_s_LA         : out std_logic;
       o_s_amt        : out std_logic_vector(4 downto 0);
       o_s_RegWr      : out std_logic;
       o_signed_ext   : out std_logic;
       o_jal          : out std_logic;
       o_ovfl         : out std_logic;
       o_Halt         : out std_logic;
       o_repl_qb      : out std_logic_vector(7 downto 0);
       o_readrs       : out std_logic_vector(31 downto 0);
       o_readrt       : out std_logic_vector(31 downto 0);
       o_ext          : out std_logic_vector(31 downto 0);
       o_upc          : out std_logic_vector(31 downto 0);
       o_imem         : out std_logic_vector(31 downto 0)
);

end component;

signal  s_CLK          : std_logic;
signal  s_RST          : std_logic := '0';
signal  s_RegDst       : std_logic := '0';
signal  s_mem_read     : std_logic := '0';
signal  s_MemtoReg     : std_logic := '0';
signal  s_MemWr        : std_logic := '0';
signal  s_ALUControl   : std_logic_vector(3 downto 0) := "0000";
signal  s_ALUSrc       : std_logic := '0';
signal  s_s_LR         : std_logic := '0';
signal  s_s_LA         : std_logic := '0';
signal  s_s_amt        : std_logic_vector(4 downto 0) := "00000";
signal  s_s_RegWr      : std_logic := '0';
signal  s_signed_ext   : std_logic := '0';
signal  s_jal          : std_logic := '0';
signal  s_ovfl         : std_logic := '0';
signal  s_Halt         : std_logic := '0';
signal  s_repl_qb      : std_logic_vector(7 downto 0) := "00000000";
signal  s_readrs       : std_logic_vector(31 downto 0) := x"00000000";
signal  s_readrt       : std_logic_vector(31 downto 0) := x"00000000";
signal  s_ext          : std_logic_vector(31 downto 0) := x"00000000";
signal  s_upc          : std_logic_vector(31 downto 0) := x"00000000";
signal  s_imem         : std_logic_vector(31 downto 0) := x"00000000";

signal  so_RegDst       : std_logic;
signal  so_mem_read     : std_logic;
signal  so_MemtoReg     : std_logic;
signal  so_MemWr        : std_logic;
signal  so_ALUControl   : std_logic_vector(3 downto 0);
signal  so_ALUSrc       : std_logic;
signal  so_s_LR         : std_logic;
signal  so_s_LA         : std_logic;
signal  so_s_amt        : std_logic_vector(4 downto 0);
signal  so_s_RegWr      : std_logic;
signal  so_signed_ext   : std_logic;
signal  so_jal          : std_logic;
signal  so_ovfl         : std_logic;
signal  so_Halt         : std_logic;
signal  so_repl_qb      : std_logic_vector(7 downto 0);
signal  so_readrs       : std_logic_vector(31 downto 0);
signal  so_readrt       : std_logic_vector(31 downto 0);
signal  so_ext          : std_logic_vector(31 downto 0);
signal  so_upc          : std_logic_vector(31 downto 0);
signal  so_imem         : std_logic_vector(31 downto 0);

begin
DUT0: ID_EX_register
  port map(i_CLK        => s_CLK,        
           i_RST        => s_RST,        
           i_RegDst     => s_RegDst,     
           i_mem_read   => s_mem_read,   
           i_MemtoReg   => s_MemtoReg,   
           i_MemWr      => s_MemWr,      
           i_ALUControl => s_ALUControl, 
           i_ALUSrc     => s_ALUSrc,     
           i_s_LR       => s_s_LR,       
           i_s_LA       => s_s_LA,       
           i_s_amt      => s_s_amt,      
           i_s_RegWr    => s_s_RegWr,    
           i_signed_ext => s_signed_ext, 
           i_jal        => s_jal,        
           i_ovfl       => s_ovfl,       
           i_Halt       => s_Halt,       
           i_repl_qb    => s_repl_qb,    
           i_readrs     => s_readrs,     
           i_readrt     => s_readrt,     
           i_ext        => s_ext,        
           i_upc        => s_upc,        
           i_imem       => s_imem,       
           o_RegDst     => so_RegDst,    
           o_mem_read   => so_mem_read,  
           o_MemtoReg   => so_MemtoReg,  
           o_MemWr      => so_MemWr,     
           o_ALUControl => so_ALUControl,
           o_ALUSrc     => so_ALUSrc,    
           o_s_LR       => so_s_LR,      
           o_s_LA       => so_s_LA,      
           o_s_amt      => so_s_amt,     
           o_s_RegWr    => so_s_RegWr,   
           o_signed_ext => so_signed_ext,
           o_jal        => so_jal,       
           o_ovfl       => so_ovfl,      
           o_Halt       => so_Halt,      
           o_repl_qb    => so_repl_qb,   
           o_readrs     => so_readrs,    
           o_readrt     => so_readrt,    
           o_ext        => so_ext,       
           o_upc        => so_upc,       
           o_imem       => so_imem);       

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
s_RST        <= '1';  
s_RegDst     <= '0';  
s_mem_read   <= '0';  
s_MemtoReg   <= '0';  
s_MemWr      <= '0';  
s_ALUControl <= "0000"; 
s_ALUSrc     <= '0'; 
s_s_LR       <= '0'; 
s_s_LA       <= '0'; 
s_s_amt      <= "00000"; 
s_s_RegWr    <= '0'; 
s_signed_ext <= '0'; 
s_jal        <= '0'; 
s_ovfl       <= '0'; 
s_Halt       <= '0'; 
s_repl_qb    <= "00000000"; 
s_readrs     <= x"00000000"; 
s_readrt     <= x"00000000"; 
s_ext        <= x"00000000"; 
s_upc        <= x"00000000"; 
s_imem       <= x"00000000"; 
wait for gCLK_HPER*2;

--Input tests
s_RST        <= '0';  
s_RegDst     <= '1';  
s_mem_read   <= '1';  
s_MemtoReg   <= '0';  
s_MemWr      <= '1';  
s_ALUControl <= "0110"; 
s_ALUSrc     <= '1'; 
s_s_LR       <= '0'; 
s_s_LA       <= '1'; 
s_s_amt      <= "00110"; 
s_s_RegWr    <= '1'; 
s_signed_ext <= '0'; 
s_jal        <= '0'; 
s_ovfl       <= '1'; 
s_Halt       <= '0'; 
s_repl_qb    <= "00101100"; 
s_readrs     <= x"01110000"; 
s_readrt     <= x"00001101"; 
s_ext        <= x"01110000"; 
s_upc        <= x"01001101"; 
s_imem       <= x"10111010"; 
wait for gCLK_HPER*2;


s_RST        <= '0';  
s_RegDst     <= '1';  
s_mem_read   <= '0';  
s_MemtoReg   <= '1';  
s_MemWr      <= '0';  
s_ALUControl <= "1001"; 
s_ALUSrc     <= '1'; 
s_s_LR       <= '1'; 
s_s_LA       <= '0'; 
s_s_amt      <= "10101"; 
s_s_RegWr    <= '1'; 
s_signed_ext <= '1'; 
s_jal        <= '1'; 
s_ovfl       <= '0'; 
s_Halt       <= '0'; 
s_repl_qb    <= "00111000"; 
s_readrs     <= x"00011110"; 
s_readrt     <= x"01101100"; 
s_ext        <= x"00111010"; 
s_upc        <= x"00110110"; 
s_imem       <= x"01011010"; 
wait for gCLK_HPER*2;

end process;
end mixed;
