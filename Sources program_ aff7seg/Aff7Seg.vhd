----------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity seven_segment_display_VHDL is
    Port ( clock_100Mhz : in STD_LOGIC;-- 100Mhz clock on Basys 3 FPGA board
           reset : in STD_LOGIC; -- reset
			  upCounter, downCounter: in std_logic;
				Right, Left : in std_logic;
				Mode : in std_logic;
		  
           Anode_Activate : out STD_LOGIC_VECTOR (3 downto 0);-- 4 Anode signals
           LED_out : out STD_LOGIC_VECTOR (6 downto 0));-- Cathode patterns of 7-segment display
end seven_segment_display_VHDL;
----------------------------------------------------------------------------------------
architecture Behavioral of seven_segment_display_VHDL is
	-----------------------------------------------------------
	signal half_second_counter: STD_LOGIC_VECTOR (27 downto 0);	
	-- counter for generating 0.5-second clock enable
	signal half_second_enable: std_logic;
	-- one second enable for counting numbers
	signal displayed_number: STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
	-- counting decimal number to be displayed on 4-digit 7-segment display
	signal LED_BCD: STD_LOGIC_VECTOR (3 downto 0);
	signal refresh_counter: STD_LOGIC_VECTOR (19 downto 0);
	-- creating 10.5ms refresh period
	signal LED_activating_counter: std_logic_vector(1 downto 0);
	signal v10, v11, v20, v21 : std_logic:= '0';
	signal displayed_number_inter_R, displayed_number_inter_L : std_logic_vector(3 downto 0):= (others=>'0');
	-- intermediate signals, used in cirrcular translation
----------------------------------------------------------------------------------------------
-- the other 2-bit for creating 4 LED-activating signals
-- count         0    ->  1  ->  2  ->  3
-- activates    LED1    LED2   LED3   LED4
-- and repeat
begin

------------------------------ PROCESS 1 ----------------------------------------
-- VHDL code for BCD to 7-segment decoder
-- Cathode patterns of the 7-segment LED display 
process(LED_BCD)
begin
      case LED_BCD is
			 when "0000" => LED_out <= "1000000"; -- "0"  -- LED_out <= "g f e d c b a"   
			 when "0001" => LED_out <= "1111001"; -- "1" 
			 when "0010" => LED_out <= "0100100"; -- "2" 
			 when "0011" => LED_out <= "0110000"; -- "3" 
			 when "0100" => LED_out <= "0011001"; -- "4" 
			 when "0101" => LED_out <= "0010010"; -- "5" 
			 when "0110" => LED_out <= "0000010"; -- "6" 
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
----------------------------------PROCESS 2--------- Controle des anodes, donc controle et synchronisation des afficheurs
-- 7-segment display controller
-- generate refresh period of 10.5ms
process(clock_100Mhz,reset)
begin 
    if(reset='1') then
        refresh_counter <= (others => '0');
    elsif(rising_edge(clock_100Mhz)) then
        refresh_counter <= refresh_counter + 1;
    end if;
end process;
-------------------------------------------------------------------------------
 LED_activating_counter <= refresh_counter(19 downto 18);
 ---------------------------------PROCESS 3------------------------------------------
-- 4-to-1 MUX to generate anode activating signals for 4 LEDs 
process(LED_activating_counter,displayed_number) -- (LED_activating_counter)
begin
    case LED_activating_counter is
    when "00" =>
        Anode_Activate <= "0111"; 
        -- activate LED1 and Deactivate LED2, LED3, LED4
        LED_BCD <= displayed_number(15 downto 12);
        -- the first hex digit of the 16-bit number
    when "01" =>
        Anode_Activate <= "1011"; 
        -- activate LED2 and Deactivate LED1, LED3, LED4
        LED_BCD <= displayed_number(11 downto 8);
        -- the second hex digit of the 16-bit number
    when "10" =>
        Anode_Activate <= "1101"; 
        -- activate LED3 and Deactivate LED2, LED1, LED4
        LED_BCD <= displayed_number(7 downto 4);
        -- the third hex digit of the 16-bit number
    when "11" =>
        Anode_Activate <= "1110"; 
        -- activate LED4 and Deactivate LED2, LED3, LED1
        LED_BCD <= displayed_number(3 downto 0);
        -- the fourth hex digit of the 16-bit number  
	 when others => Anode_Activate <= "ZZZZ";	
	 
    end case;
end process;
---------------------------------------------------------------------------

-- Counting the number to be displayed on 4-digit 7-segment Display 
--------------------------------PROCESS 4----------------------------------- Diviseur d'horloge:
process(clock_100Mhz, reset)
begin
        if(reset='1') then
            half_second_counter <= (others => '0');
        elsif(rising_edge(clock_100Mhz)) then
            if(half_second_counter >= x"2FAF080") then ---- 0.5 seconde = x"2FAF080" / 1 seconde = x"5F5E100".
                half_second_counter <= (others => '0');
            else
                half_second_counter <= half_second_counter + "0000001";
            end if;
        end if;
end process;
---------------------------------------------------------------------------
half_second_enable <= '1' when half_second_counter=x"2FAF080" else '0'; 						
------------------------------ PROCESS 5 -----------------------------------
-------process qui s'incrémente automatiquement tout les 0.5 secondes---------
process(clock_100Mhz, reset,half_second_enable)--, Mode)
begin
  if(reset = '1' ) then 	displayed_number <= (others => '0');
  elsif(rising_edge(clock_100Mhz) and half_second_enable='1') then 
		displayed_number <=  displayed_number + '1';
  end if;
end process;

--*******************************************************************************************************************************************
--*************////////  POUR POUVOIR UTILISER L'UN DES 3 PROCESS (PROCESS 5 OU 6 OU 7) => ON DOIT COMMENTER LES 2 AUTRES////////////////////
--*******************************************************************************************************************************************
------------------------------------ PROCESS 6 ---------------------------------------------------
--------------------process qui gere l'affichage jusqu'a 9999:  marche---------------------------
--process(clock_100Mhz, reset, half_second_enable)
--begin
--  if(reset = '1' ) then 	displayed_number <= (others => '0');
--  elsif(rising_edge(clock_100Mhz) and half_second_enable='1') then 
--		displayed_number <=  displayed_number + '1';
--
--		if(displayed_number(3 downto 0)> x"9") then displayed_number <=  displayed_number+ x"0006";       --displayed_number <=  displayed_number(3 downto 0) + x"6";
--		elsif(displayed_number(7 downto 4)> x"9") then displayed_number <=  displayed_number + x"0057";
--		elsif(displayed_number(11 downto 8)> x"9") then displayed_number <=  displayed_number + x"0667";
--		elsif(displayed_number > x"9999") then displayed_number <=  x"0000";
--	   end if;
--  end if;
--end process;
--------------------------------------------------------------------------------------------------
-------------------------------------- PROCESS 7 ---------------------------------------------------------
--process(clock_100Mhz, reset,half_second_enable, upCounter, downCounter, Mode)
--begin
--	if((clock_100Mhz'event and clock_100Mhz='1')) then	 -- frot montant de clk pour generer le décalage
--		---- CREATION DE DECALAGES : 
--      v10 <= upCounter;		
--		v20 <= downCounter;
--		v11 <= Right;     	
--		v21 <= Left;
--                ------------------------------------------------   Initialisation:
--				if(reset='1') then  displayed_number <= (others => '0');
--				end if;
--                ------------------------------------------------  Up / down :mouvements
--				if(v10='0' and upCounter='1')then  -- Front montant de v10.
--						 displayed_number <= displayed_number + x"0001"; -- Comptage. 
--				end if;
--				if(v20='1' and downCounter='0') then -- falling edge de downCounter 
--						displayed_number <= displayed_number - x"0001"; -- Décomptage 		
--				end if;
--                ------------------------------------------------ Right Left: mouvements
--              if( v11 = '0' and Right = '1') then		
--                     displayed_number_inter_R <= displayed_number(3 downto 0) ;
--                     displayed_number(3 downto 0) <= displayed_number(7 downto 4) ;
--                     displayed_number(7 downto 4) <= displayed_number(11 downto 8) ;
--                     displayed_number(11 downto 8) <= displayed_number(15 downto 12) ;
--                     displayed_number(15 downto 12) <= displayed_number_inter_R;
--              end if;
--              if(v21 ='1' and Left = '0') then
--                     displayed_number_inter_L <= displayed_number(15 downto 12) ;
--                 	    displayed_number(15 downto 12) <= displayed_number(11 downto 8) ;
--                     displayed_number(11 downto 8) <= displayed_number(7 downto 4) ;
--                     displayed_number(7 downto 4) <= displayed_number(3 downto 0) ;
--                     displayed_number(3 downto 0) <= displayed_number_inter_L;		
--              end if;
--	end if;
--end process;
-----------------------------------------------------------------------------------------
------------------------------
end Behavioral;
------------------------------

