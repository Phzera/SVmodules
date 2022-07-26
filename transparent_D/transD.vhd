Library ieee;
USE ieee.std_logic_1164_all;

ENTITY transD IS
    PORT (
        clk : IN STD_LOGIC;
        d   : IN STD_LOGIC;
        q1  : BUFFER STD_LOGIC;
        q2  : BUFFER STD_LOGIC; // Using BUFFER STD_LOGIC allows set its value and read
    );
END transD;

ARCHITECTURE design OF transD IS 
BEGIN
    PROCESS (d, clk,q1) BEGIN// IF statuementes must be contained in a PROCESS 
        IF clk = '0' THEN // When clock is low, ignore data;
            q1 <= q1;
            q2 <= NOT q1;
        ELSIF clk = '1' THEN //When clock is high data passes;
            q1 <= d;
            q2 <= NOT d;
        END IF;
    END PROCESS;
    
END design;
