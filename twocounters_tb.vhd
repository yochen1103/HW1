library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_counters is
end tb_counters;

architecture Behavioral of tb_counters is

    component twocounters
        port (
            rst      : in  std_logic;
            clk      : in  std_logic;
            count1_o : out std_logic_vector(7 downto 0);
            count2_o : out std_logic_vector(7 downto 0)
        );
    end component;


    signal reset,clk: std_logic;
    signal count1_o,count2_o: std_logic_vector(7 downto 0);

begin

    dut: twocounters
        port map (
            clk      => clk,
            rst      => reset,
            count1_o => count1_o,
            count2_o => count2_o
        );


    clock_process: process
    begin
        
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        
    end process;


    stim_proc: process
    begin
        reset <= '0';
        wait for 20 ns;
        reset <= '1';
        wait;
    end process;
end Behavioral;

