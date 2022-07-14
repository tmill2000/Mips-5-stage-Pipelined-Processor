--Noah Peake
--tb_Pipeline_Registers.vhd
--NOTE: Please use the do file included with the submission for making the waveform easy to read

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
library std;
use std.env.all;
use std.textio.all;

entity tb_Pipeline_Registers is
  generic(gCLK_HPER   : time := 10 ns);
end tb_Pipeline_Registers;

architecture mixed of tb_Pipeline_Registers is

constant cCLK_PER  : time := gCLK_HPER * 2;

component IF_ID_register is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;
       i_WE         : in std_logic;
       i_upc        : in std_logic_vector(31 downto 0);
       i_imem       : in std_logic_vector(31 downto 0);
       o_upc        : out std_logic_vector(31 downto 0);
       o_imem       : out std_logic_vector(31 downto 0));

end component;

component ID_EX_register is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;
       i_WE         : in std_logic;
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
       i_jal          : in std_logic;
       i_ovfl         : in std_logic;
       i_Halt         : in std_logic;
       i_repl_qb      : in std_logic_vector(7 downto 0);
       i_readrs       : in std_logic_vector(31 downto 0);
       i_readrt       : in std_logic_vector(31 downto 0);
       i_ext          : in std_logic_vector(31 downto 0);
       i_upc          : in std_logic_vector(31 downto 0);
       i_imem         : in std_logic_vector(31 downto 0);
       i_RegWrAddress : in std_logic_vector(4 downto 0);

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
       o_jal          : out std_logic;
       o_ovfl         : out std_logic;
       o_Halt         : out std_logic;
       o_repl_qb      : out std_logic_vector(7 downto 0);
       o_readrs       : out std_logic_vector(31 downto 0);
       o_readrt       : out std_logic_vector(31 downto 0);
       o_ext          : out std_logic_vector(31 downto 0);
       o_upc          : out std_logic_vector(31 downto 0);
       o_imem         : out std_logic_vector(31 downto 0);
       o_RegWrAddress : out std_logic_vector(4 downto 0)
);

end component;

component EX_MEM_register is
  port(i_CLK          : in std_logic;     -- Clock input
       i_RST          : in std_logic;
       i_WE	          : in std_logic;
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
       i_RegWrAddress : in std_logic_vector(4 downto 0);

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
       o_imem         : out std_logic_vector(31 downto 0);
       o_RegWrAddress : out std_logic_vector(4 downto 0)
);

end component;

component MEM_WB_register is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;
       i_WE         : in std_logic;
       i_RegDst       : in std_logic;
       i_MemtoReg     : in std_logic;
       i_s_RegWr      : in std_logic;
       i_jal          : in std_logic;
       i_Halt         : in std_logic;
       i_ALUOut       : in std_logic_vector(31 downto 0);
       i_DmemOut      : in std_logic_vector(31 downto 0);
       i_upc          : in std_logic_vector(31 downto 0);
       i_imem         : in std_logic_vector(31 downto 0);
       i_RegWrAddress : in std_logic_vector(4 downto 0);

       o_RegDst       : out std_logic;
       o_MemtoReg     : out std_logic;
       o_s_RegWr      : out std_logic;
       o_jal          : out std_logic;
       o_Halt         : out std_logic;
       o_ALUOut       : out std_logic_vector(31 downto 0);
       o_DmemOut      : out std_logic_vector(31 downto 0);
       o_upc          : out std_logic_vector(31 downto 0);
       o_imem         : out std_logic_vector(31 downto 0);
       o_RegWrAddress : out std_logic_vector(4 downto 0)
);

end component;



component org2 is
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

--Common signal
signal s_CLK        : std_logic; 
--IF/ID signals
signal IF_RST        : std_logic := '0';
signal IF_org        : std_logic := '0';
signal IF_WE         : std_logic := '0';
signal IF_flush      : std_logic := '0';
signal s_upc        : std_logic_vector(31 downto 0) := x"XXXXXXXX";
signal s_imem       : std_logic_vector(31 downto 0) := x"XXXXXXXX";
signal IF_upc        : std_logic_vector(31 downto 0);
signal IF_imem       : std_logic_vector(31 downto 0);

--ID/EX signals
signal s_RegDst       : std_logic := 'X';
signal s_mem_read     : std_logic := 'X';
signal s_MemtoReg     : std_logic := 'X';
signal s_MemWr        : std_logic := 'X';
signal s_ALUControl   : std_logic_vector(3 downto 0) := "XXXX";
signal s_ALUSrc       : std_logic := 'X';
signal s_s_LR         : std_logic := 'X';
signal s_s_LA         : std_logic := 'X';
signal s_s_amt        : std_logic_vector(4 downto 0);
signal s_s_RegWr      : std_logic := 'X';
signal s_jal          : std_logic := 'X';
signal s_ovfl         : std_logic := 'X';
signal s_Halt         : std_logic := 'X';
signal s_repl_qb      : std_logic_vector(7 downto 0) := "XXXXXXXX";
signal s_readrs       : std_logic_vector(31 downto 0) := x"XXXXXXXX";
signal s_readrt       : std_logic_vector(31 downto 0) := x"XXXXXXXX";
signal s_ext          : std_logic_vector(31 downto 0) := x"XXXXXXXX";
signal s_RegWrAddress : std_logic_vector(4 downto 0) := "XXXXX";

signal ID_RST          : std_logic := '0';
signal ID_org          : std_logic := '0';
signal ID_WE           : std_logic := '0';
signal ID_flush        : std_logic := '0';
signal ID_RegDst       : std_logic;
signal ID_mem_read     : std_logic;
signal ID_MemtoReg     : std_logic;
signal ID_MemWr        : std_logic;
signal ID_ALUControl   : std_logic_vector(3 downto 0);
signal ID_ALUSrc       : std_logic;
signal ID_s_LR         : std_logic;
signal ID_s_LA         : std_logic;
signal ID_s_amt        : std_logic_vector(4 downto 0);
signal ID_s_RegWr      : std_logic;
signal ID_jal          : std_logic;
signal ID_ovfl         : std_logic;
signal ID_Halt         : std_logic;
signal ID_repl_qb      : std_logic_vector(7 downto 0);
signal ID_readrs       : std_logic_vector(31 downto 0);
signal ID_readrt       : std_logic_vector(31 downto 0);
signal ID_ext          : std_logic_vector(31 downto 0);
signal ID_upc          : std_logic_vector(31 downto 0);
signal ID_imem         : std_logic_vector(31 downto 0);
signal ID_RegWrAddress : std_logic_vector(4 downto 0);

--EX/MEM signals
signal EX_RST          : std_logic := '0';
signal EX_WE	          : std_logic := '0';
signal EX_org         : std_logic := '0';
signal EX_flush       : std_logic := '0';
signal s_ALUOut       : std_logic_vector(31 downto 0);
signal EX_RegDst       : std_logic;
signal EX_mem_read     : std_logic;
signal EX_MemtoReg     : std_logic;
signal EX_MemWr        : std_logic;
signal EX_s_RegWr      : std_logic;
signal EX_jal          : std_logic;
signal EX_Halt         : std_logic;
signal EX_ALUOut       : std_logic_vector(31 downto 0);
signal EX_readrt       : std_logic_vector(31 downto 0);
signal EX_upc          : std_logic_vector(31 downto 0);
signal EX_imem         : std_logic_vector(31 downto 0);
signal EX_RegWrAddress : std_logic_vector(4 downto 0);

--MEM/WB signals
signal MEM_RST          : std_logic := '0';
signal MEM_WE	        : std_logic := '0';
signal MEM_org          : std_logic := '0';
signal MEM_flush        : std_logic := '0';
signal s_DmemOut        : std_logic_vector(31 downto 0);
signal MEM_RegDst       : std_logic; 
signal MEM_MemtoReg     : std_logic;
signal MEM_s_RegWr      : std_logic;
signal MEM_jal          : std_logic;
signal MEM_Halt         : std_logic;
signal MEM_ALUOut       : std_logic_vector(31 downto 0); 
signal MEM_DmemOut      : std_logic_vector(31 downto 0);
signal MEM_upc          : std_logic_vector(31 downto 0);
signal MEM_imem         : std_logic_vector(31 downto 0);
signal MEM_RegWrAddress : std_logic_vector(4 downto 0);


begin

IForg: org2
  port map(i_A => IF_RST, 
           i_B => IF_flush,
           o_F => IF_org);

IDorg: org2
  port map(i_A => ID_RST, 
           i_B => ID_flush,
           o_F => ID_org);

EXorg: org2
  port map(i_A => EX_RST, 
           i_B => EX_flush,
           o_F => EX_org);
MEMorg: org2
  port map(i_A => MEM_RST, 
           i_B => MEM_flush,
           o_F => MEM_org);

DUT1: IF_ID_register
  port map(i_CLK  =>  s_CLK,  
           i_RST  =>  IF_org, 
           i_WE   =>  IF_WE,
           i_upc  =>  s_upc, 
           i_imem =>  s_imem,
           o_upc  =>  IF_upc, 
           o_imem =>  IF_imem);

DUT2: ID_EX_register
  port map(i_CLK        => s_CLK,
           i_RST        => ID_org,
           i_WE         => ID_WE,
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
           i_jal        => s_jal,        
           i_ovfl       => s_ovfl,       
           i_Halt       => s_Halt,       
           i_repl_qb    => s_repl_qb,    
           i_readrs     => s_readrs,     
           i_readrt     => s_readrt,     
           i_ext        => s_ext,        
           i_upc        => IF_upc,
           i_imem       => IF_imem,
           i_RegWrAddress => s_RegWrAddress,
           o_RegDst     => ID_RegDst,      
           o_mem_read   => ID_mem_read,    
           o_MemtoReg   => ID_MemtoReg,    
           o_MemWr      => ID_MemWr,       
           o_ALUControl => ID_ALUControl,  
           o_ALUSrc     => ID_ALUSrc,      
           o_s_LR       => ID_s_LR,        
           o_s_LA       => ID_s_LA,        
           o_s_amt      => ID_s_amt,       
           o_s_RegWr    => ID_s_RegWr,     
           o_jal        => ID_jal,         
           o_ovfl       => ID_ovfl,        
           o_Halt       => ID_Halt,        
           o_repl_qb    => ID_repl_qb,     
           o_readrs     => ID_readrs,      
           o_readrt     => ID_readrt,      
           o_ext        => ID_ext,         
           o_upc        => ID_upc,         
           o_imem       => ID_imem,
           o_RegWrAddress => ID_RegWrAddress);        

DUT3: EX_MEM_register
  port map(i_CLK         => s_CLK,
          i_RST          => EX_org,
          i_WE	         => EX_WE,
          i_RegDst       => ID_RegDst,
          i_mem_read     => ID_mem_read,
          i_MemtoReg     => ID_MemtoReg,
          i_MemWr        => ID_MemWr,
          i_s_RegWr      => ID_s_RegWr,
          i_jal          => ID_jal,
          i_Halt         => ID_Halt,
          i_ALUOut       => s_ALUOut,
          i_readrt       => ID_readrt,
          i_upc          => ID_upc,
          i_imem         => ID_imem,
          i_RegWrAddress => ID_RegWrAddress,
          o_RegDst       => EX_RegDst,
          o_mem_read     => EX_mem_read,
          o_MemtoReg     => EX_MemtoReg,
          o_MemWr        => EX_MemWr,
          o_s_RegWr      => EX_s_RegWr,
          o_jal          => EX_jal,
          o_Halt         => EX_Halt,
          o_ALUOut       => EX_ALUOut,
          o_readrt       => EX_readrt,
          o_upc          => EX_upc,
          o_imem         => EX_imem,
          o_RegWrAddress => EX_RegWrAddress);

DUT4: MEM_WB_register
  port map(i_CLK          => s_CLK, 
           i_RST          => MEM_org,
           i_WE           => MEM_WE,
           i_RegDst       => EX_RegDst,
           i_MemtoReg     => EX_mem_read,
           i_s_RegWr      => EX_s_RegWr,
           i_jal          => EX_jal,    
           i_Halt         => EX_Halt,
           i_ALUOut       => EX_ALUOut,
           i_DmemOut      => s_DmemOut,
           i_upc          => EX_upc,
           i_imem         => EX_imem,
           i_RegWrAddress => EX_RegWrAddress,
           o_RegDst       => MEM_RegDst,      
           o_MemtoReg     => MEM_MemtoReg,    
           o_s_RegWr      => MEM_s_RegWr,     
           o_jal          => MEM_jal,         
           o_Halt         => MEM_Halt,        
           o_ALUOut       => MEM_ALUOut,      
           o_DmemOut      => MEM_DmemOut,     
           o_upc          => MEM_upc,         
           o_imem         => MEM_imem,        
           o_RegWrAddress => MEM_RegWrAddress);

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
 --IF control
 IF_RST        <= '1';
 IF_WE         <= '0';  
 IF_flush      <= '0';
 --ID control
 ID_RST        <= '1';
 ID_WE         <= '0';  
 ID_flush      <= '0';
 --EX control
 EX_RST        <= '1';
 EX_WE         <= '0';  
 EX_flush      <= '0';
 --MEM control
 MEM_RST        <= '1';
 MEM_WE         <= '0'; 
 MEM_flush      <= '0';

 s_imem       <= x"00000000";
 wait for gCLK_HPER*2;

 --Input register tests
 --IF control
 IF_RST        <= '0';
 IF_WE         <= '1';  
 IF_flush      <= '0';
 --ID control
 ID_RST        <= '0';
 ID_WE         <= '1';  
 ID_flush      <= '0';
 --EX control
 EX_RST        <= '0';
 EX_WE         <= '1';  
 EX_flush      <= '0';
 --MEM control
 MEM_RST        <= '0';
 MEM_WE         <= '1';  
 MEM_flush      <= '0';

 s_imem       <= x"00011111";
 wait for gCLK_HPER*2;
 --WE off no write should happen(keep prev vals propigating)
 --IF control
 IF_RST        <= '0';
 IF_WE         <= '0';  
 IF_flush      <= '0';
 --ID control
 ID_RST        <= '0';
 ID_WE         <= '1';  
 ID_flush      <= '0';
 --EX control
 EX_RST        <= '0';
 EX_WE         <= '1';  
 EX_flush      <= '0';
 --MEM control
 MEM_RST        <= '0';
 MEM_WE         <= '1';  
 MEM_flush      <= '0';

 s_imem       <= x"01010100";
 wait for gCLK_HPER*2;
 --Write enable is back so sould get new vals
 --IF control
 IF_RST        <= '0';
 IF_WE         <= '1';  
 IF_flush      <= '0';
 --ID control
 ID_RST        <= '0';
 ID_WE         <= '1';  
 ID_flush      <= '0';
 --EX control
 EX_RST        <= '0';
 EX_WE         <= '1';  
 EX_flush      <= '0';
 --MEM control
 MEM_RST        <= '0';
 MEM_WE         <= '1';  
 MEM_flush      <= '0';

 s_imem       <= x"11011111";
 --Put in extra stall in order to show propigation before flushing all registers
 wait for gCLK_HPER*2;
 wait for gCLK_HPER*2;
 wait for gCLK_HPER*2;
 wait for gCLK_HPER*2;
 --Test flush signal should be like reset
 --IF control
 IF_RST        <= '0';
 IF_WE         <= '0';  
 IF_flush      <= '1';
 --ID control
 ID_RST        <= '0';
 ID_WE         <= '0';  
 ID_flush      <= '1';
 --EX control
 EX_RST        <= '0';
 EX_WE         <= '0';  
 EX_flush      <= '1';
 --MEM control
 MEM_RST        <= '0';
 MEM_WE         <= '0';  
 MEM_flush      <= '1';

 s_imem       <= x"01010100";
 wait for gCLK_HPER*2;
 --Put vals to test next flush
 --IF control
 IF_RST        <= '0';
 IF_WE         <= '1';  
 IF_flush      <= '0';
 --ID control
 ID_RST        <= '0';
 ID_WE         <= '1';  
 ID_flush      <= '0';
 --EX control
 EX_RST        <= '0';
 EX_WE         <= '1';  
 EX_flush      <= '0';
 --MEM control
 MEM_RST        <= '0';
 MEM_WE         <= '1';  
 MEM_flush      <= '0';

 s_imem       <= x"11111111";
 --Extra stalls to propigate values before flushing some registers
 wait for gCLK_HPER*2;
 wait for gCLK_HPER*2;
 wait for gCLK_HPER*2;
 wait for gCLK_HPER*2;
 --Test flush on some, stall other registers to keep instructions
 --IF control
 IF_RST        <= '0';
 IF_WE         <= '0';  
 IF_flush      <= '1';
 --ID control
 ID_RST        <= '0';
 ID_WE         <= '0';  
 ID_flush      <= '0';
 --EX control
 EX_RST        <= '0';
 EX_WE         <= '0';  
 EX_flush      <= '1';
 --MEM control
 MEM_RST        <= '0';
 MEM_WE         <= '0';  
 MEM_flush      <= '0';

 s_imem       <= x"01010100";
 wait for gCLK_HPER*2;

end process;
end mixed;
