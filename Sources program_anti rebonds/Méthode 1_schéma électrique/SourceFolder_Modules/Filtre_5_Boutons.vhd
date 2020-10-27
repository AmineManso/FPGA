library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--------------------------------------------------------
entity Filtre_5_Boutons is
	PORT( Din_x5 : in std_logic_vector(4 downto 0);
			clk, CE: in std_logic;
			
			Dout_x5 : out std_logic_vector(4 downto 0));
end Filtre_5_Boutons;
--------------------------------------------------------
architecture Behavioral of Filtre_5_Boutons is
	-------- Package:
	component Filtre is
		PORT( Din 		: in std_logic;
				clk, CE  : 	 in std_logic; 
				Cout     : out std_logic );
	end component;
	------ signal intermédiaire utilisé pour éviter l'erreur de connexion vers drivers multiples: 
	signal Dout_signal : std_logic_vector(4 downto 0):= (others => '0');
begin
	---------  les 5 boutons et leur 5 Filtres:
	uu0:	Filtre port map(Din_x5(0), clk, CE, Dout_signal(0));
	uu1:	Filtre port map(Din_x5(1), clk, CE, Dout_signal(1));
	uu2:	Filtre port map(Din_x5(2), clk, CE, Dout_signal(2));
	uu3:	Filtre port map(Din_x5(3), clk, CE, Dout_signal(3));
	uu4:	Filtre port map(Din_x5(4), clk, CE, Dout_signal(4));
	--------- Process qui élimine l'état "U" (Unknown) au début du Filtre_x5_Boutons.
	proc_init : process(CE, Dout_signal)
	begin
		if(CE = '0')then Dout_x5 <= (others=>'0'); 
		else 		Dout_x5 <= Dout_signal;
		end if;
	end process;
	------------
end Behavioral;

