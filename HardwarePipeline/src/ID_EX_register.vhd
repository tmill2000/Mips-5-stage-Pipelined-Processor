--Noah Peake
--ID_EX_register.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity ID_EX_register is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;
       i_WE	    : in std_logic;
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

end ID_EX_register;

architecture structural of ID_EX_register is


    signal so_RegDst     : std_logic_vector(0 downto 0);
    signal so_mem_read   : std_logic_vector(0 downto 0);
    signal so_MemtoReg   : std_logic_vector(0 downto 0);
    signal so_MemWr      : std_logic_vector(0 downto 0);
    signal so_ALUSrc     : std_logic_vector(0 downto 0);
    signal so_s_LR       : std_logic_vector(0 downto 0);
    signal so_s_LA       : std_logic_vector(0 downto 0);
    signal so_s_RegWr    : std_logic_vector(0 downto 0);
    
    signal so_jal        : std_logic_vector(0 downto 0);
    signal so_ovfl       : std_logic_vector(0 downto 0);
    signal so_Halt       : std_logic_vector(0 downto 0);

    signal si_RegDst     : std_logic_vector(0 downto 0);
    signal si_mem_read   : std_logic_vector(0 downto 0);
    signal si_MemtoReg   : std_logic_vector(0 downto 0);
    signal si_MemWr      : std_logic_vector(0 downto 0);
    signal si_ALUSrc     : std_logic_vector(0 downto 0);
    signal si_s_LR       : std_logic_vector(0 downto 0);
    signal si_s_LA       : std_logic_vector(0 downto 0);
    signal si_s_RegWr    : std_logic_vector(0 downto 0);
    
    signal si_jal        : std_logic_vector(0 downto 0);
    signal si_ovfl       : std_logic_vector(0 downto 0);
    signal si_Halt       : std_logic_vector(0 downto 0);

component n_bit_register is
  generic(N : integer := 32);
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_WE         : in std_logic;     -- Write enable input
         i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
         o_Q          : out std_logic_vector(N-1 downto 0));  -- Data value output

end component;

begin

 si_RegDst(0)     <= i_RegDst; 
 si_mem_read(0)    <= i_mem_read;
 si_MemtoReg(0)    <= i_MemtoReg;
 si_MemWr(0)       <= i_MemWr;
 si_ALUSrc(0)      <= i_ALUSrc;
 si_s_LR(0)        <= i_s_LR;
 si_s_LA(0)        <= i_s_LA;
 si_s_RegWr(0)     <= i_s_RegWr;
 si_jal(0)         <= i_jal;
 si_ovfl(0)        <= i_ovfl;
 si_Halt(0)        <= i_Halt;

  RegDstreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => si_RegDst,
             o_Q => so_RegDst);

  mem_readreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => si_mem_read,
             o_Q => so_mem_read);

  MemtoRegreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => si_MemtoReg,
             o_Q => so_MemtoReg);

  MemWrreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => si_MemWr,
             o_Q => so_MemWr);

  ALUControlreg: n_bit_register
    generic map(N => 4)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => i_ALUControl,
             o_Q => o_ALUControl);

  ALUSrcreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => si_ALUSrc,
             o_Q => so_ALUSrc);

  LRreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => si_s_LR,
             o_Q => so_s_LR);

  LAreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => si_s_LA,
             o_Q => so_s_LA);

  amtreg: n_bit_register
    generic map(N => 5)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => i_s_amt,
             o_Q => o_s_amt);

  RegWrreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => si_s_RegWr,
             o_Q => so_s_RegWr);

  jalreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => si_jal,
             o_Q => so_jal);

  ovflreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => si_ovfl,
             o_Q => so_ovfl);

  Haltreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => si_Halt,
             o_Q => so_Halt);

  repl_qbreg: n_bit_register
    generic map(N => 8)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => i_repl_qb,
             o_Q => o_repl_qb);

  readrsreg: n_bit_register
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => i_readrs,
             o_Q => o_readrs);

  readrtreg: n_bit_register
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => i_readrt,
             o_Q => o_readrt);

  extreg: n_bit_register
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => i_ext,
             o_Q => o_ext);

  PCReg: n_bit_register
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => i_upc,
             o_Q => o_upc);

  ImemReg: n_bit_register
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => i_imem,
             o_Q => o_imem);

  RegWRAddressReg: n_bit_register
    generic map(N => 5)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => i_WE,
             i_D => i_RegWRAddress,
             o_Q => o_RegWRAddress);

 o_RegDst     <= so_RegDst(0);      
 o_mem_read   <= so_mem_read(0);    
 o_MemtoReg   <= so_MemtoReg(0);    
 o_MemWr      <= so_MemWr(0);       
 o_ALUSrc     <= so_ALUSrc(0);      
 o_s_LR       <= so_s_LR(0);        
 o_s_LA       <= so_s_LA(0);        
 o_s_RegWr    <= so_s_RegWr(0);     
 o_jal        <= so_jal(0);         
 o_ovfl       <= so_ovfl(0);        
 o_Halt       <= so_Halt(0);        

end structural;

