-- test bench for 4bit counter

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity counter_tb is
end counter_tb;

architecture Behavioral of counter_tb is
    signal reset: std_logic := '1';
    signal clk: std_logic := '0';
    signal en: std_logic := '0';
    signal load: std_logic := '0';
    signal d_in: std_logic_vector (3 downto 0) := (others => '0');
    signal q_out: std_logic_vector (3 downto 0);
    
    constant T_clk: time := 20ns;

begin

     CLK_GEN: clk <= not clk after T_clk/2; 
     
     DUT: entity work.counter
        port map (
            reset => reset,
            clk   => clk,
            d_in  => d_in,
            en  => en,
            load  => load,
            q_out => q_out
        );

    STIMULUS: process is
        --reset
        begin
        wait for 4*T_clk;
        reset <= '0';
        wait for 2*T_clk;
        
        --enable
        en <= '1';
        wait for 5*T_clk;
        en <= '0';
        wait for 5*T_clk;
        
        --sinhroni upis
        en <= '1';
        wait for 5*T_clk;
        d_in <= "0100";
        load <= '1';
        wait for T_clk;
        
        --brojanje i vracanje na 0
        load <='0';
        wait for 20*T_clk;
        
        wait;
    end process STIMULUS;
    
end Behavioral;
