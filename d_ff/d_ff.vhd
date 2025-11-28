--D FLIP-FLOP w/ASYNC RESET

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_ff is
    port(
        d: in std_logic;
        clk: in std_logic;
        rd: in std_logic;
        q: out std_logic 
        );
end d_ff;

architecture beh of d_ff is
begin
    process (rd ,clk) is
    begin
        if (rd = '0') then
            q <= '0';
        elsif (rising_edge(clk)) then
            q <= d;
        end if;
    end process;
end beh;
