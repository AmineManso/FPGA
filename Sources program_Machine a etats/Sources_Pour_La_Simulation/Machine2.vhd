library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
--------------------------------------------
entity Machine is
	PORT( S1, S2 , clock_100Mhz, raz: in std_logic;
			S_monnaie : out std_logic; 
			LED_out : out std_logic_vector(6 downto 0); 
			Film : out std_logic);
end Machine;
--------------------------------------------

architecture Behavioral of Machine is
	------------------------------------
	type StateType is (state0, state1,state2); -- déclaration d'un nouveau type de variable.
	signal etat: StateType := state1; -- créer un variable de type "StateType" nouvellement créer, et l'initier. 
	signal cmp :std_logic_vector(3 downto 0) := (others => '0');
	---- diviseur d'horloge:
	signal count4: integer :=0;
	signal clk_1s, clk_fourth_sec : std_logic:= '0';
	
begin

---------------------------------------------------------Process 2 : machine d'état		
	process(clock_100Mhz, raz) 
		begin
			if raz = '1' then
				etat <= state0;
			elsif(rising_edge(clock_100Mhz))then 
				case etat is
					when state0 =>
							cmp	<= x"0";
							Film <= '0';
							S_monnaie <= '0';
							etat <= state1;
					when state1 => 
							if(S1 = '1' ) then 																							 -- on peut utilisé l'état haut de l'entrée Bouton poussoir car l'horloge est asser lante, et l'entré ne sera pas affecté par les rebonds(rebonds générés au niveau du bouton poussoir). 
									Film <= '0';
									S_monnaie <= '0';
									cmp <= cmp + '1' ;
									etat <= state2; 
							elsif(S2 = '1') then 																						 -- on ne peut pas utiliser "rising_edge(S2)", car S2, S1, ne sont pas des entrées horloge. 
									Film <= '0';
									S_monnaie <= '0';
									cmp <= cmp + x"2";
									etat <= state2;
							else etat <= state1;
							end if;
					when state2 => 
							if(cmp = x"5")then
									Film <= '1';
									S_monnaie <= '0';
									etat <= state0;	
							elsif(cmp > x"5")then
									Film <= '1';
									S_monnaie <= '1';
									etat <= state0;
							else 	etat <= state1;		
							end if;					
				end case;
			end if;
		end process;
-----------------------------------------------------------------
-----------------------------------------------------------------Process 3: Affichage du compteur cmp
	process(cmp)
	begin
			case cmp is
				 when "0000" => LED_out <= "1000000"; -- "0"  -- LED_out <= "g f e d c b a"   
				 when "0001" => LED_out <= "1111001"; -- "1" 
				 when "0010" => LED_out <= "0100100"; -- "2" 
				 when "0011" => LED_out <= "0110000"; -- "3" 
				 when "0100" => LED_out <= "0011001"; -- "4" 
				 when "0101" => LED_out <= "0010010"; -- "5" 
				 when "0110" => LED_out <= "0000010"; -- "6"  
---- On peut s'arréter au niveau du numéro "6", car c'est le dérnier chiffre qui poura étre affiché.
	
				 when "0111" => LED_out <= "1111000"; -- "7" 
				 when "1000" => LED_out <= "0000000"; -- "8"     
				 when "1001" => LED_out <= "0010000"; -- "9" 
				 when "1010" => LED_out <= "0001000"; -- "a"
				 when "1011" => LED_out <= "0000011"; -- "b"
				 when "1100" => LED_out <= "1000110"; -- "C"
				 when "1101" => LED_out <= "0100001"; -- "d"
				 when "1110" => LED_out <= "0000110"; -- "E"
				 when "1111" => LED_out <= "0001110"; -- "F"
				 when others => LED_out <= "ZZZZZZZ";
			end case;
	end process;
-------------------------------------------------------------------------------------------
end Behavioral;
--------------------------------------------------------------------------------------------------------------