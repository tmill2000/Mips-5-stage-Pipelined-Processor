library ieee;
use ieee.std_logic_1164.all;

entity forwarding_unit is

port(
    IF_ID_instruction: in std_logic_vector(31 downto 0);
    ID_EX_instruction : in std_logic_vector(31 downto 0);
    EX_MEM_instruction : in std_logic_vector(31 downto 0);
    MEM_WB_instruction : in std_logic_vector(31 downto 0);
    EX_MEM_RegWr: in std_logic;
    MEM_WB_RegWr: in std_logic;
    EX_MEM_RegWrAddress: in std_logic_vector(4 downto 0);
    MEM_WB_RegWrAddress: in std_logic_vector(4 downto 0);
    ID_EX_RegWrAddress: in std_logic_vector(4 downto 0);
    Branch: in std_logic;

	
    RS_mux_select : out std_logic_vector(1 downto 0); --forward B
    RT_mux_select : out std_logic_vector(1 downto 0); --forward A
    Equal_mux_select_RS: out std_logic_vector(1 downto 0);
    Equal_mux_select_RT: out std_logic_vector(1 downto 0)
);
end forwarding_unit;


architecture structure of forwarding_unit is

    signal ID_EX_RS  : std_logic_vector(4 downto 0);
    signal ID_EX_RT  : std_logic_vector(4 downto 0);
    signal IF_ID_RS  : std_logic_vector(4 downto 0);
    signal IF_ID_RT  : std_logic_vector(4 downto 0);


    


begin
    ID_EX_RS <= ID_EX_instruction(25 downto 21);
    ID_EX_RT <= ID_EX_instruction(20 downto 16);
    IF_ID_RS <= IF_ID_instruction(25 downto 21);
    IF_ID_RT <= IF_ID_instruction(20 downto 16);

process ( ID_EX_RS, ID_EX_RT, EX_MEM_RegWr, MEM_WB_RegWR, MEM_WB_RegWrAddress, EX_MEM_RegWrAddress, IF_ID_RS, IF_ID_RT, Branch) is
    begin

    RS_mux_select <= "00";
    RT_mux_select <= "00";
    Equal_mux_select_RT <= "00";
    Equal_mux_select_RS <= "00";

    --R Format
    --ALU FORWARDING
    if(EX_MEM_RegWr = '1'  and (EX_MEM_RegWrAddress /= "00000")  and EX_MEM_RegWrAddress = ID_EX_RS) then
        RS_mux_select <= "10";
    elsif( MEM_WB_RegWr = '1'  and (MEM_WB_RegWrAddress /= "00000") and not(EX_MEM_RegWr = '1' and (EX_MEM_RegWrAddress /= "00000") and (EX_MEM_RegWrAddress = ID_EX_RS))  and MEM_WB_RegWrAddress = ID_EX_RS ) then
        RS_mux_select <= "01";
    end if;

    if(EX_MEM_RegWr = '1'  and (EX_MEM_RegWrAddress /= "00000") and EX_MEM_RegWrAddress = ID_EX_RT) then
        RT_mux_select <= "10";
    elsif(MEM_WB_RegWr = '1'  and  (MEM_WB_RegWrAddress /= "00000") and not(EX_MEM_RegWr ='1' and (EX_MEM_RegWrAddress /= "00000") and (EX_MEM_RegWrAddress = ID_EX_RT))  and MEM_WB_RegWrAddress = ID_EX_RT) then
        RT_mux_select <= "01";
    end if;

    --BRANCH FORWARDING
    if(Branch = '1' and ID_EX_RegWrAddress = IF_ID_RS) then
	Equal_mux_select_RS <= "10";
    elsif(Branch = '1' and EX_MEM_RegWrAddress = IF_ID_RS) then
	Equal_mux_select_RS <= "01";
    end if;

    if(Branch = '1' and (ID_EX_RegWrAddress = IF_ID_RT)) then
	Equal_mux_select_RT <= "10";
    elsif(Branch = '1' and (EX_MEM_RegWrAddress = IF_ID_RT)) then
	Equal_mux_select_RT <= "01";
    end if;
		

    

   

    
    

    end process;


end structure;
