--TEST BENCH FOR D FLIP-FLOP w/ASYNC RESET

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff_tb is
end d_ff_tb;

architecture test of d_ff_tb is

-- Alternative to "entity work.d_ff" on line 31
--    component d_ff is
--        port(
--            d  : in std_logic;
--            clk : in std_logic;
--            rd : in std_logic;
--            q  : out std_logic
--        );
--    end component;

    signal d: std_logic := '0';
    signal clk: std_logic := '0';
    signal rd: std_logic := '0';
    signal q: std_logic;
    
    constant T_clk: time := 20ns;

begin
    clk_gen: clk <= not clk after T_clk/2;
    
    dut: entity work.d_ff 
        port map (
            d=>d,
            clk=>clk,
            rd=>rd,
            q=>q
        );
    
    stimulus: process is
    begin
        report("log log level up");
        wait for 4*T_clk;
        rd <= '1'; --reset off
        wait for 4*T_clk;
        d <= '1';
        wait for 4*T_clk;
        d <= '0';
        wait for 4*T_clk;
        d <= '1';
        wait for 4*T_clk;
        rd <= '0';
        wait for 10*T_clk;
        rd <= '1';
        wait for 10*T_clk;
        wait;
    end process stimulus;
end test;