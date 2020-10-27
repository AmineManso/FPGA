library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
------------------------------------------------
entity Register_D is
	    Port ( E   : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           CE  : in  STD_LOGIC;
        Sortie_D : out  STD_LOGIC);
end Register_D;
------------------------------------------------
architecture Behavioral of Register_D is
	---------------------------------
	signal save : std_logic:= '0';-- save: variable de sauvegarde 
											--       de l'état précédent.
	---------------------------------
begin
	process(clk, CE, save)
		begin
			if (CE = '0') then Sortie_D <= save;  -- 
			elsif(rising_edge(clk) and CE = '1') then
					save <= E;
					Sortie_D <= E;
			end if;
	end process;
end Behavioral;

-----------------------------------------



