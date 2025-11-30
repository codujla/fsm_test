-- 8-bit shift register

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_reg is
    port(
        reset: in std_logic;
        clk: in std_logic;
        d_in: in std_logic_vector(7 downto 0);
        s_in: in std_logic;
        load: in std_logic;
        q_out: out std_logic_vector(7 downto 0)
        );
end shift_reg;

architecture Behavioral of shift_reg is
    signal q_reg: std_logic_vector (7 downto 0);
    
begin
    process (reset,clk) is
    begin
        if (reset = '1') then
            q_reg <= (others => '0');
        elsif (rising_edge (clk)) then
            if (load = '1') then
                q_reg <= d_in;
            else
                q_reg <= s_in & q_reg (7 downto 1);
            end if;
        end if;
    end process;
    
    q_out <= q_reg;
end Behavioral;
