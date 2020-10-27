library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
-----------------------------------------------------------------------
entity Counter is
		port( E  : in std_logic;
			  clk : in std_logic;
				CE : in std_logic;
			  ras : in std_logic;
				
		Sortie_C : out std_logic  );
end Counter;
-----------------------------------------------------------------------
architecture Behavioral of Counter is
	---------------------------------
	signal cmp : std_logic_vector(3 downto 0) :=(others => '0');--cmp:compteur.
	signal save : std_logic := '0';--savel: variable qui sauvegarde l'�tat pr�c�dent. 
	constant max : integer:= 8; -- constante qui sert � d�terminer le seuil ducompteur.
	---------------------------------
begin	
		process(clk, CE, ras,  cmp, E)
		begin 	
			if (ras = '1') then   ----- �tat de r�initialisation. 
				Sortie_C <= '0';
				cmp <= (others => '0');
			elsif(rising_edge(clk)) then	
				if( E = not(save))then--Bloc de remise � z�ro si on change d'�tat de l'entr�e.  
					  Sortie_C <= '0';
					  cmp <=  (others => '0');
					  save <= E;							  
				elsif (CE = '1' ) then--Bloc de comptage.
				Sortie_C <= '0';	
				cmp <= cmp + 1; 
				end if;		
				
				if( cmp = max) then--Bloc de reinitialisation apr�s atteindre le seuil du compteur. 
						Sortie_C <= '1';
						cmp <= (others => '0');	
				end if;
				if(CE = '0')then Sortie_C <= 'Z';--Bloc de suret�, pour �viter d'avoir la valeur "U",
				end if;									--  lors de la simulation
			end if;	
		end process;
end Behavioral;
-------------------------------------