library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
----------------------------------------
entity LAR is
port( Din :   in std_logic_vector(7 downto 0);
		clk, Ce, reset : in std_logic;	
		
		P1, P2, P3, SortieLAR : out std_logic_vector(7 downto 0) -- SortieLAR = dou (de la FIFO)
		);
end LAR;
--------------------------------------------
architecture Behavioral of LAR is
	--------------------------------------------------------------------Début package.
	component registreX8 is---------------------Registre à décalage 8 bits.
	port(	E : in std_logic_vector(7 downto 0);
			clk : in std_logic;
			clkEnable : in std_logic;
			set : in std_logic;
			reset: in std_logic;
			S : out std_logic_vector(7 downto 0)
			);
	end component;
	
	component registreX1 is---------------------Registre à décalage 1 bits.
		port(	E : in std_logic;
				clk : in std_logic;
				clkEnable : in std_logic;
				set : in std_logic;
				reset: in std_logic;
				
				S : out std_logic
				);
		end component;
			
		component MemoireFifo IS------------------------FIFO.
		  PORT (
			 clk : IN STD_LOGIC;
			 rst : IN STD_LOGIC;
			 din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			 wr_en : IN STD_LOGIC;
			 rd_en : IN STD_LOGIC;
			 prog_full_thresh : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			
			 dout : 			OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			 full : 			OUT STD_LOGIC;
			 empty : 		OUT STD_LOGIC;
			 prog_full : 	OUT STD_LOGIC
		  );
		END component;
------------------------------------------------------------------------Fin  package.
signal signal_clkEnable: std_logic:= '1';   ----Signal pour valider les horloges des Registres Décalage 1 bit. 
signal S1, S2, S3:std_logic_vector(7 downto 0):= (others => '0');--Signaux affectés aux Pixels de Sortie du filtre.
signal SCe1, SCe2, SCe3 : std_logic:= '0';-- Signaux de validation des Horloges des Registres à décalage 8 bits.
signal signal_prog_full_thresh:std_logic_vector(3 downto 0):= "1100";--"1011";-- Signal de seuil
signal signal_prog_full:std_logic:= '0';--
-------
signal signal_full, signal_empty : std_logic := '0';
----------------------------------------------------------
begin
--	signal_clkEnable <= '1';
--	signal_prog_full_thresh <=  "1100";  --"1100"; -- valeur 12: utiliser dans LAR. 																												-- Choix experimental pour avoir la sortie prog_full = 1, 
																  -- valeur 11: utiliser dans LAR3x3 (eviter un decalage).
	u1:registreX8 port map(Din, clk, Ce, '0', reset, S1);  	
		P1 <= S1;
	u12:registreX1 port map(Ce, clk, signal_clkEnable, '0', reset, SCe1);
	
	u2:registreX8 port map(S1, clk, SCe1, '0', reset, S2); P2 <= S2;
	u22:registreX1 port map(SCe1, clk, signal_clkEnable, '0', reset, SCe2);
	
	u3:registreX8 port map(S2, clk, SCe2, '0', reset, S3); 
		P3 <= S3;
	u32:registreX1 port map(SCe2, clk, signal_clkEnable , '0', reset, SCe3);
	
--	signal_prog_full <= s_prog_full;
	u4: MemoireFifo PORT MAP ( clk, reset, S3,SCe3, signal_prog_full, signal_prog_full_thresh, 
--										SortieLAR, s_full, s_empty, s_data_count, s_prog_full );
										SortieLAR, signal_full, signal_empty, signal_prog_full );


end Behavioral;

------------------------------------------------------------ back up du programme
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
------------------------------------------
--entity LAR is
--port( Din : 			  in std_logic_vector(7 downto 0);
--		clk, Ce, reset : in std_logic;
--		
--		prog_full : inout std_logic;
--		full : 		OUT STD_LOGIC;
--		empty : 		OUT STD_LOGIC;
--		data_count :OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
--		P1, P2, P3, SortieLAR : out std_logic_vector(7 downto 0) -- SortieLAR = dou (de la FIFO)
--		);
--end LAR;
----------------------------------------------
--architecture Behavioral of LAR is
--	--------------------------------------------------------------------Début package.
--	component registreX8 is---------------------Registre à décalage 8 bits.
--	port(	E : in std_logic_vector(7 downto 0);
--			clk : in std_logic;
--			clkEnable : in std_logic;
--			set : in std_logic;
--			reset: in std_logic;
--			S : out std_logic_vector(7 downto 0)
--			);
--	end component;
--	
--	component registreX1 is---------------------Registre à décalage 1 bits.
--		port(	E : in std_logic;
--				clk : in std_logic;
--				clkEnable : in std_logic;
--				set : in std_logic;
--				reset: in std_logic;
--				
--				S : out std_logic
--				);
--		end component;
--			
--component MemoireFifo IS------------------------FIFO.
--  PORT (
--    clk : IN STD_LOGIC;
--    rst : IN STD_LOGIC;
--    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
--    wr_en : IN STD_LOGIC;
--    rd_en : IN STD_LOGIC;
--    prog_full_thresh : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
--   
--	 dout : 			OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
--    full : 			OUT STD_LOGIC;
--    empty : 		OUT STD_LOGIC;
--    data_count : 	OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
--    prog_full : 	OUT STD_LOGIC
--  );
--END component;
--------------------------------------------------------------------------Fin  package.
--signal signal_clkEnable: std_logic:= '1';   ----Signal pour valider les horloges des Registres Décalage 1 bit. 
--signal S1, S2, S3:std_logic_vector(7 downto 0):= (others => '0');--Signaux affectés aux Pixels de Sortie du filtre.
--signal SCe1, SCe2, SCe3 : std_logic:= '0';-- Signaux de validation des Horloges des Registres à décalage 8 bits.
--signal signal_prog_full_thresh:std_logic_vector(3 downto 0):= "1100";--"1011";-- Signal de seuil
--signal signal_prog_full:std_logic:= '0';--
--
------------------------------------------------------------
--begin
----	signal_clkEnable <= '1';
----	signal_prog_full_thresh <=  "1100";  --"1100"; -- valeur 12: utiliser dans LAR. 																												-- Choix experimental pour avoir la sortie prog_full = 1, 
--																  -- valeur 11: utiliser dans LAR3x3 (eviter un decalage).
--	u1:registreX8 port map(Din, clk, Ce, '0', reset, S1);  	
--		P1 <= S1;
--	u12:registreX1 port map(Ce, clk, signal_clkEnable, '0', reset, SCe1);
--	
--	u2:registreX8 port map(S1, clk, SCe1, '0', reset, S2); P2 <= S2;
--	u22:registreX1 port map(SCe1, clk, signal_clkEnable, '0', reset, SCe2);
--	
--	u3:registreX8 port map(S2, clk, SCe2, '0', reset, S3); 
--		P3 <= S3;
--	u32:registreX1 port map(SCe2, clk, signal_clkEnable , '0', reset, SCe3);
--	
--	signal_prog_full <= prog_full;
--	u4: MemoireFifo PORT MAP ( clk, reset, S3,SCe3, signal_prog_full, signal_prog_full_thresh, SortieLAR,
--										full, empty, data_count, prog_full );
--	
--
--end Behavioral;

