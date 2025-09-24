library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity twocounters is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           count1_o : out STD_LOGIC_VECTOR (7 downto 0);
           count2_o : out STD_LOGIC_VECTOR (7 downto 0));
end twocounters;

architecture Behavioral of twocounters is
	signal count1 : STD_LOGIC_VECTOR (7 downto 0);
	signal count2 : STD_LOGIC_VECTOR (7 downto 0);
	type FSM_STATE is (S0,S1,S2);
	signal state: FSM_STATE;
	signal state1: FSM_STATE;
begin

    FSM: process(clk,rst,count1,count2) 
    begin
	    if rst = '0'then
			state <= S0;
		elsif clk 'event and clk = '1' then
			state1 <= state;
		    case state is
		        when S0 => 
					if count1 = "0000"&"1000" then
						state1 <= state;
					    state <= S2;
					end if;
				when S1 =>
					if count2 = "0101"&"0000" then
						state1 <= state;
					    state <= S2;
					end if;
				when S2 =>
					case state1 is
						when S0 => 
								state <= S1;
						when S1 =>
								state <= S0;
						when others => 
							null;
					end case;
				when others => 
					null;
            end case;
		end if;
	end process FSM;
	
	counter1: process(clk,rst,state)
	begin
		if rst = '0' then
			count1 <= "0000"&"0000";
		elsif clk 'event and clk = '1' then
			case state is
		        when S0 => 
					count1 <= count1 + '1';
				when S1 =>
					count1 <="0000"&"0000";
				when S2 =>
					count1 <="0000"&"0000";
				when others => 
					null;
            end case;
		end if;
	end process counter1;
	
	counter2: process(clk,rst,state)
	begin
		if rst = '0' then
			count2 <= "1111"&"1101"; 
		elsif clk 'event and clk = '1' then
			case state is
		        when S0 => 
					count2 <= "1111"&"1101";
				when S1 =>
					count2 <= count2 - '1';
				when S2 => 
					count2 <= "1111"&"1101";
				when others => 
					null;
            end case;
		end if;
	end process counter2;
	
	count1_o <= count1;
	count2_o <= count2;

	
end Behavioral;
