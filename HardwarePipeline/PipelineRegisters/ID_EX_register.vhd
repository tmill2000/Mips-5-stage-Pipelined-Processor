--Noah Peake
--ID_EX_register.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity ID_EX_register is
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
       o_jal          : out std_logic;
       o_ovfl         : out std_logic;
       o_Halt         : out std_logic;
       o_repl_qb      : out std_logic_vector(7 downto 0);
       o_readrs       : out std_logic_vector(31 downto 0);
       o_readrt       : out std_logic_vector(31 downto 0);
       o_ext          : out std_logic_vector(31 downto 0)
       o_upc          : in std_logic_vector(31 downto 0);
       o_imem         : in std_logic_vector(31 downto 0);
);

end ID_EX_register;

architecture structural of ID_EX_register is

component N_Bit_Register is
  generic(N : integer := 32);
    port(i_CLK        : in std_logic;     -- Clock input
         i_RST        : in std_logic;     -- Reset input
         i_WE         : in std_logic;     -- Write enable input
         i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
         o_Q          : out std_logic_vector(N-1 downto 0));  -- Data value output

end component;

begin

  RegDstreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_RegDst,
             o_Q => o_RegDst);

  mem_readreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_mem_read,
             o_Q => o_mem_read);

  MemtoRegreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_MemtoReg,
             o_Q => o_MemtoReg);

  MemWrreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_MemWr,
             o_Q => o_MemWr);

  ALUControlreg: N_Bit_Register
    generic map(N => 4)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_ALUControl,
             o_Q => o_ALUControl);

  ALUSrcreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_ALUSrc,
             o_Q => o_ALUSrc);

  LRreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_s_LR,
             o_Q => o_s_LR);

  LAreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_s_LA,
             o_Q => o_s_LA);

  amtreg: N_Bit_Register
    generic map(N => 5)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_s_amt,
             o_Q => o_s_amt);

  RegWrreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_s_RegWr,
             o_Q => o_s_RegWr);

  signed_extreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_signed_ext,
             o_Q => o_signed_ext);

  jalreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_jal,
             o_Q => o_jal);

  ovflreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_ovfl,
             o_Q => o_ovfl);

  Haltreg: N_Bit_Register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_Halt,
             o_Q => o_Halt);

  repl_qbreg: N_Bit_Register
    generic map(N => 8)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_repl_qb,
             o_Q => o_repl_qb);

  readrsreg: N_Bit_Register
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_readrs,
             o_Q => o_readrs);

  readrtreg: N_Bit_Register
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_readrt,
             o_Q => o_readrt);

  extreg: N_Bit_Register
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_ext,
             o_Q => o_ext);

  PCReg: N_Bit_Register
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_upc,
             o_Q => o_upc);
  ImemReg: N_Bit_Register
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_imem,
             o_Q => o_imem);

end structural;

