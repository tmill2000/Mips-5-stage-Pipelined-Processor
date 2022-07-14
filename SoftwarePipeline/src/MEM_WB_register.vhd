--Noah Peake
--MEM_WB_register.vhd

library IEEE;
use IEEE.std_logic_1164.all;

entity MEM_WB_register is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;
       i_RegDst       : in std_logic;
       i_MemtoReg     : in std_logic;
       i_s_RegWr      : in std_logic;
       i_jal          : in std_logic;
       i_Halt         : in std_logic;
       i_ALUOut       : in std_logic_vector(31 downto 0);
       i_DmemOut      : in std_logic_vector(31 downto 0);
       i_upc          : in std_logic_vector(31 downto 0);
       i_imem         : in std_logic_vector(31 downto 0);

       o_RegDst       : out std_logic;
       o_MemtoReg     : out std_logic;
       o_s_RegWr      : out std_logic;
       o_jal          : out std_logic;
       o_Halt         : out std_logic;
       o_ALUOut       : out std_logic_vector(31 downto 0);
       o_DmemOut      : out std_logic_vector(31 downto 0);
       o_upc          : out std_logic_vector(31 downto 0);
       o_imem         : out std_logic_vector(31 downto 0)
);

end MEM_WB_register;

architecture structural of MEM_WB_register is

       signal so_RegDst       : std_logic_vector(0 downto 0);
       signal so_MemtoReg     : std_logic_vector(0 downto 0);
       signal so_s_RegWr      : std_logic_vector(0 downto 0);
       signal so_jal          : std_logic_vector(0 downto 0);
       signal so_Halt         : std_logic_vector(0 downto 0);

       signal si_RegDst       : std_logic_vector(0 downto 0);
       signal si_MemtoReg     : std_logic_vector(0 downto 0);
       signal si_s_RegWr      : std_logic_vector(0 downto 0);
       signal si_jal          : std_logic_vector(0 downto 0);
       signal si_Halt         : std_logic_vector(0 downto 0);

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
 si_MemtoReg(0)   <= i_MemtoReg;
 si_s_RegWr(0)    <= i_s_RegWr;
 si_jal(0)        <= i_jal;
 si_Halt(0)       <= i_Halt;


  RegDstreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => si_RegDst,
             o_Q => so_RegDst);

  MemtoRegreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => si_MemtoReg,
             o_Q => so_MemtoReg);

  RegWrreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => si_s_RegWr,
             o_Q => so_s_RegWr);

  jalreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => si_jal,
             o_Q => so_jal);

  Haltreg: n_bit_register
    generic map(N => 1)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => si_Halt,
             o_Q => so_Halt);

  ALUOutreg: n_bit_register
    generic map(N => 32)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_ALUOut,
             o_Q => o_ALUOut);

DmemOutreg: n_bit_register
    generic map(N => 32)
    port map(i_CLK => i_CLK,
             i_RST => i_RST,
             i_WE => '1',
             i_D => i_DmemOut,
             o_Q => o_DmemOut);

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

 o_RegDst    <= so_RegDst(0);
 o_MemtoReg  <= so_MemtoReg(0);
 o_s_RegWr   <= so_s_RegWr(0);
 o_jal       <= so_jal(0);
 o_Halt      <= so_Halt(0);


end structural;
