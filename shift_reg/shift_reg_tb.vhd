-- test bench for shift register

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg_tb is
end shift_reg_tb;

architecture Behavioral of shift_reg_tb is
    
    -- DUT signals
    signal reset : std_logic := '0';
    signal clk   : std_logic := '0';
    signal d_in  : std_logic_vector(7 downto 0) := (others => '0');
    signal s_in  : std_logic := '0';
    signal load  : std_logic := '0';
    signal q_out : std_logic_vector(7 downto 0);
    
    constant T_clk: time := 20ns;

begin
    CLK_GEN: clk <= not clk after T_clk/2;  

--    CLK_GEN : process
--    begin
--        clk <= '0';
--        wait for T_clk/2;
--        clk <= '1';
--        wait for T_clk/2;
--    end process;
    
    DUT: entity work.shift_reg
        port map (
            reset => reset,
            clk   => clk,
            d_in  => d_in,
            s_in  => s_in,
            load  => load,
            q_out => q_out
        );
                        
    STIMULUS: process is
    begin
        -- reset
        reset <= '1';
        wait for T_clk*2;
        reset <= '0';
        wait for T_clk*2;

        -- load data in parallel
        d_in <= "10101010";
        load <= '1';
        wait for T_clk*2;
        load <= '0';

        --shift in 3 bits with value 1
        s_in <= '1';
        wait for 3*T_clk;
        s_in <= '0';
        
        wait;
    end process STIMULUS;
end Behavioral;
