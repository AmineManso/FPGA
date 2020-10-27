----------------------------------------------------------------introduction des biblioth�que        ---------  programme mache:
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.numeric_std.ALL;
--------------------------------------------------------------- cr�ation de l'entit�:
entity Filtre_ME is
PORT(	Din, clk : in std_logic;
		Dout 			 : out std_logic	);
end Filtre_ME;
--------------------------------------------------------------- 
architecture Behavioral of Filtre_ME is
	--------------------------------------------------------------
	type StateType is (state0, state1, state2, state3, state4);-- cr�ation d'un nouveau type
	------------------------------------------
	signal etat : StateType := state0; -- d�claration d'une variable du type "StateType".
	signal counter : integer :=0; 
	constant max : integer := 20	; -- Constante utilis�e d�finir le maximum de rebonds.

	------------------------------------------------------------------
	begin
--------------------------------------------------
	
	process(clk, Din)
	begin
		if(rising_edge(clk))then 
			case etat is
					when state0 =>   -------- �tat d'initialisation:
						Dout <= '0';
						counter <= 0;					
						etat <= state1;
					when state1 =>   --------�tat d'attente du premier niveau haut                         (front montant cause probleme car Din n'est pas une clock)
							if(Din = '1') then --if(rising_edge(Din)) then 
								Dout <= '1';
								etat <= state2;		
							else etat <= state1;	
							end if;	

					when state2 =>--------------- �tat qui g�n�re le premier retard (Delay)
							if(rising_edge(clk)) then 
								counter <= counter +1; 						
									if(counter < max)then etat <= state2;
									elsif(counter >= max) then
										etat <= state3;
										counter <= 0; 							
									end if;
							end if;
																				
					when state3 => -------------- etat d'aatente du premier niveau bas
							if( Din ='0') then  
								Dout <= '0';
								etat <= state4;
							else 
								Dout <= '1' ; --- ou on peut utiliser "Dout <= Din;"
								etat <= state3;
							end if;
					
					when state4 =>  --------------- �tat qui g�n�re le deuxo�me retard(Delay)
							if(rising_edge(clk)) then 
								counter <= counter +1;                           
									if(counter < max)then etat <= state4;
									elsif(counter >= max) then
										etat <= state0;
										counter <= 0;											
									end if;
							end if;								
			end case;
		end if;
	end process;

end Behavioral;
---------------------------------------------------------------------------