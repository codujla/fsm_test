--test bench for edge detector

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detect_tb is
end edge_detect_tb;

architecture Behavioral of edge_detect_tb is

    signal reset: std_logic := '0';
    signal clk: std_logic := '0';
    signal x_in: std_logic := '0';
    signal edge: std_logic;
    
    constant T_clk: time := 20ns;
    
begin
    CLK_GEN: clk <= not clk after T_clk/2;

    DUT: entity work.edge_detect 
                        port map (
                                reset=>reset, 
                                clk=>clk, 
                                x_in=>x_in, 
                                edge=>edge
                                );
    
    STIMULUS: process is
        begin
            reset <= '1';
            x_in <='0';
            wait for 2*T_clk ;
            reset <= '0';
            wait for 2*T_clk ;
            x_in <= '0';
            wait for 5*T_clk ;
            x_in <= '1';
            wait for 2*T_clk ;
            x_in <= '0';
            wait for 2*T_clk ;
            x_in <= '1';
            wait for 3*T_clk ;
            reset <= '1';
            wait;
        end process STIMULUS;

end Behavioral;
