-- edge detector with a full tact output

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detect is
    port(
        reset: in std_logic;
        clk: in std_logic;
        x_in: in std_logic;
        edge: out std_logic 
    );
end edge_detect;

architecture Behavioral of edge_detect is
    signal x_prev : std_logic; 
begin
    process(reset,clk) is
    begin
        if(reset='1') then
            x_prev <= '0';
        elsif (rising_edge(clk)) then
            x_prev <= x_in;
        end if;
    end process;
    
    process(reset,clk) is
    begin
        if(reset='1') then
            edge <= '0';
        elsif (rising_edge(clk)) then
            if(x_prev = '0' and x_in = '1') then
                edge <= '1';
            else
                edge <= '0';
            end if;
        end if;
    end process;

end Behavioral;
