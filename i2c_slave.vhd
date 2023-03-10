------------------------------------------------------------------------
--                     		   program description
-- project name 	: I2C Slave design
-- file name 		: i2c_slave.vhd
-- Design by 		: Innofeels
-------------------------------------------------------------------------------
-- Simulation  		: Modelsim 10.0b
-- Synthesis		: QuartusII 21.1
-- Target      		: CycloneIV
-- Revision Date	: 2023/0308
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity i2c_slave is
port(
	rst_n  				: in std_logic;
	clk					: in std_logic;

	sclk  				: in std_logic;
	sdata				: inout std_logic;

	ireg00_data			: in std_logic_vector(7 downto 0);
	ireg01_data			: in std_logic_vector(7 downto 0);
	ireg02_data			: in std_logic_vector(7 downto 0);
	ireg03_data			: in std_logic_vector(7 downto 0);
	ireg04_data			: in std_logic_vector(7 downto 0);
	ireg05_data			: in std_logic_vector(7 downto 0);
	ireg06_data			: in std_logic_vector(7 downto 0);
	ireg07_data			: in std_logic_vector(7 downto 0);

	reg_updated			: out std_logic;
	oreg00_data			: out std_logic_vector(7 downto 0);
	oreg01_data			: out std_logic_vector(7 downto 0);
	oreg02_data			: out std_logic_vector(7 downto 0);
	oreg03_data			: out std_logic_vector(7 downto 0);
	oreg04_data			: out std_logic_vector(7 downto 0);
	oreg05_data			: out std_logic_vector(7 downto 0);
	oreg06_data			: out std_logic_vector(7 downto 0);
	oreg07_data			: out std_logic_vector(7 downto 0)

	);
end i2c_slave;

architecture rtl of i2c_slave is

constant WAIT_TIME 				: integer range 0 to 2047 := 16;
constant EDN_TIME 				: integer range 0 to 2047 := 2047;

type state is (idle_st, ready_st, start_st, device_st, device_ack, device_ack_w, addr_st, addr_ack, addr_ack_w,
				det_state, dwrite_st, dwrite_ack, dwrite_ack_w, ready_read, start_read, dread_st, dread_ack, dread_ack_w, dread_st_w, end_st);
signal i2c_state 				: state;

signal dev_reg					:  std_logic_vector(7 downto 0);
signal data_reg					:  std_logic_vector(7 downto 0);

signal state_cnt 				: integer range 0 to 7;
signal wait_cnt 				: integer range 0 to 2047;		

signal watch_cnt 				: integer range 0 to 4095;		
signal watch_flag 				: std_logic;

signal sdata_oen 				: std_logic;

signal sdata_out 				: std_logic;
signal sdata_in 				: std_logic;

signal ack_flag 				: std_logic;
signal dummy_write 				: std_logic;

signal sclk_dff					: std_logic_vector(7 downto 0);
signal sdata_dff				: std_logic_vector(7 downto 0);

signal dev_addr 				: std_logic_vector(7 downto 0);
signal reg_addr 				: std_logic_vector(7 downto 0);

signal read_done				: std_logic;
signal write_done				: std_logic;
signal data_out					: std_logic_vector(7 downto 0);

signal read_flag				: std_logic;
signal reg_rden_d				: std_logic;

begin

-- Clock Frequency is 50 Mhz(20 ns)

sdata <= sdata_out when sdata_oen = '1' else 'Z';
sdata_in <= sdata;

write_pro : process(rst_n, clk)
begin
	if rst_n = '0' then
		i2c_state 			<= idle_st;
		sdata_oen 			<= '0';
		sdata_out 			<= '0';
		state_cnt 			<= 7;
		dev_addr 			<= (others => '0');
		reg_addr 			<= (others => '0');
		data_out 			<= (others => '0');
		ack_flag 			<= '0';
		sdata_dff 			<= x"FF";
		sclk_dff 			<= x"FF";
		wait_cnt 			<= 0;
		write_done 			<= '0';
		read_done 			<= '0';
		dummy_write 		<= '1';
		dev_reg 			<= (others => '0');
		read_flag			<= '0';
	elsif clk'event and clk = '1' then
		sclk_dff 		<= sclk_dff(6 downto 0) & sclk;
		sdata_dff 		<= sdata_dff(6 downto 0) & sdata_in;
		if watch_flag = '0' then
			-- Write Operation
			case i2c_state is 
				when idle_st =>
					sdata_oen 			<= '0';
					sdata_out 			<= 'Z';
					if sclk_dff = x"FF" then
						if sdata_dff = x"FE" then
							i2c_state 			<= ready_st;
						else
							i2c_state 			<= idle_st;
						end if;
					end if;
					dummy_write 		<= '1';
				when ready_st =>
					sdata_oen 			<= '0';
					sdata_out 			<= 'Z';
					if sdata_dff = x"00" then
						if sclk_dff = x"FE" then
							i2c_state 			<= device_st;
							wait_cnt 			<= 0;
						else
							if wait_cnt = 2047 then
								wait_cnt <= 0;
								i2c_state <= idle_st;
							else
								wait_cnt <= wait_cnt + 1;
							end if; 
						end if;
					end if;
				when device_st =>
					if sclk_dff = x"7F" then
						sdata_oen 			<= '0';
						sdata_out 			<= 'Z';
						if state_cnt = 0 then
							state_cnt 			<= 7;
							i2c_state 			<= device_ack;
						else
							state_cnt 			<= state_cnt - 1;
						end if;						
						dev_addr(state_cnt) <= sdata_in;
						dev_reg(state_cnt)  <= sdata_in;
					end if;
				when device_ack =>
					if sclk_dff = x"FE" then
						wait_cnt 			<= 1;
					else
						if wait_cnt = WAIT_TIME then
							wait_cnt 			<= 0;
							if dev_reg(7 downto 2) = "010111" then
								sdata_oen 			<= '1';
								sdata_out 			<= '0';
								i2c_state 			<= device_ack_w;
								read_flag			<= '1';
							else
								sdata_oen 			<= '0';
								sdata_out 			<= 'Z';
								read_flag			<= '0';
								i2c_state 			<= end_st;
							end if;
						elsif wait_cnt > 0 then
							wait_cnt 			<= wait_cnt + 1;
						end if;
					end if;
				when device_ack_w =>
					if sclk_dff = x"FE" then
						wait_cnt 			<= 1;
					else
						if wait_cnt = WAIT_TIME then
							wait_cnt 			<= 0;
							if dev_reg(0) = '0' then
								sdata_oen 			<= '0';
								sdata_out 			<= 'Z';
								i2c_state 			<= addr_st;
							else
								state_cnt 			<= 6;
								sdata_out 			<= data_reg(state_cnt);
								sdata_oen 			<= '1';
								i2c_state 			<= dread_st;
							end if;
						elsif wait_cnt > 0 then
							wait_cnt 			<= wait_cnt + 1;
							sdata_oen 			<= '0';
							sdata_out 			<= 'Z';
						end if;
					end if;
					write_done 			<= '0';
					read_done 			<= '0';
				when addr_st =>
					if sclk_dff = x"7F" then
						sdata_oen 			<= '0';
						sdata_out 			<= 'Z';
						if state_cnt = 0 then
							state_cnt 			<= 7;
							i2c_state 			<= addr_ack;
						else
							state_cnt 			<= state_cnt - 1;
						end if;						
						reg_addr(state_cnt)  <= sdata_in;
					end if;
				when addr_ack =>
					if sclk_dff = x"FE" then
						wait_cnt 			<= 1;
					else
						if wait_cnt = WAIT_TIME then
							wait_cnt 			<= 0;
							sdata_oen 			<= '1';
							sdata_out 			<= '0';
							i2c_state 			<= addr_ack_w;
						elsif wait_cnt > 0 then
							wait_cnt 			<= wait_cnt + 1;
						end if;
					end if;
				when addr_ack_w =>
					if sclk_dff = x"FE" then
						wait_cnt 			<= 1;
					else
						if wait_cnt = WAIT_TIME then
							wait_cnt 			<= 0;
							i2c_state 			<= dwrite_st;
							sdata_oen 			<= '0';
							sdata_out 			<= 'Z';
						elsif wait_cnt > 0 then
							wait_cnt 			<= wait_cnt + 1;
							sdata_oen 			<= '0';
							sdata_out 			<= 'Z';
						end if;
						read_flag			<= '0';
					end if;
					write_done 			<= '0';
					read_done 			<= '0';
				when dwrite_st =>
					if sclk_dff = x"7F" then
						sdata_oen 			<= '0';
						sdata_out 			<= 'Z';
						if state_cnt = 0 then
							state_cnt 			<= 7;
							i2c_state 			<= dwrite_ack;
							write_done 			<= '1';
						else
							state_cnt 			<= state_cnt - 1;
						end if;
						data_out(state_cnt) <= sdata_in;
					elsif sclk_dff = x"FF" then
						sdata_oen 			<= '0';
						sdata_out 			<= 'Z';
						if sdata_dff = x"FE" then
							i2c_state 			<= ready_st;
							state_cnt 				<= 7;
						end if;
					end if;
				when dwrite_ack =>
					if sclk_dff = x"FE" then
						wait_cnt 			<= 1;
					else
						if wait_cnt = WAIT_TIME then
							wait_cnt 			<= 0;
							sdata_oen 			<= '1';
							sdata_out 			<= '0';
							i2c_state 			<= dwrite_ack_w;
						elsif wait_cnt > 0 then
							wait_cnt 			<= wait_cnt + 1;
						end if;
					end if;
					write_done <= '0';
				when dwrite_ack_w =>
					if sclk_dff = x"FE" then
						wait_cnt 			<= 1;
					else
						if wait_cnt = WAIT_TIME then
							wait_cnt 			<= 0;
							sdata_oen 			<= '0';
							sdata_out 			<= 'Z';
							i2c_state 			<= end_st;
						elsif wait_cnt > 0 then
							wait_cnt 			<= wait_cnt + 1;
						end if;
					end if;
				when dread_st =>
					if sclk_dff = x"FE" then
						wait_cnt 		<= 1;
					else
						if wait_cnt = WAIT_TIME then
							wait_cnt 			<= 0;
							if state_cnt = 0 then
								state_cnt 			<= 7;
								i2c_state 			<= dread_ack;
								read_done 			<= '1';
							else
								state_cnt 			<= state_cnt - 1;
							end if;
							sdata_out 			<= data_reg(state_cnt);
							sdata_oen 			<= '1';
						elsif wait_cnt > 0 then
							wait_cnt 			<= wait_cnt + 1;
						end if;
					end if;
				when dread_ack =>
					if sclk_dff = x"FE" then
						wait_cnt 			<= 1;
					else
						if wait_cnt = WAIT_TIME then
							wait_cnt 			<= 0;
							sdata_oen 			<= '0';
							sdata_out 			<= 'Z';
							i2c_state 			<= dread_ack_w;
						elsif wait_cnt > 0 then
							wait_cnt 			<= wait_cnt + 1;
						end if;
					end if;
				when dread_ack_w =>
					if sclk_dff = x"7F" then
	--					if sdata_dff = "11" then
							i2c_state 			<= end_st;
	--					end if;
					end if;
					sdata_oen 			<= '0';
					sdata_out 			<= 'Z';
					read_done 			<= '0';
				when end_st =>
					if sclk_dff = x"FF" then
						if sdata_dff = x"7F" then
							i2c_state 			<= idle_st;
						end if;
						if wait_cnt = EDN_TIME then
							i2c_state 			<= idle_st;
							wait_cnt			<= 0;
						else
							wait_cnt 			<= wait_cnt + 1;
						end if;
					else
						if wait_cnt = EDN_TIME then
							i2c_state 			<= idle_st;
							wait_cnt			<= 0;
						else
							wait_cnt 			<= wait_cnt + 1;
						end if;
					end if;
				when others => null;
			end case;
		else
			i2c_state 			<= idle_st;
			sdata_oen 			<= '0';
			sdata_out 			<= '0';
			state_cnt 			<= 7;
			dev_addr 			<= (others => '0');
			reg_addr 			<= (others => '0');
			data_out 			<= (others => '0');
			ack_flag 			<= '0';
			sdata_dff 			<= x"FF";
			sclk_dff 			<= x"FF";
			wait_cnt 			<= 0;
			write_done 			<= '0';
			read_done 			<= '0';
			dummy_write 		<= '1';
			dev_reg 			<= (others => '0');
			read_flag			<= '0';
		end if;
	end if;
end process;

watch_pro : process(rst_n, clk)
begin
	if rst_n = '0' then
		watch_cnt		<= 0;
		watch_flag		<= '0';
	elsif clk'event and clk = '1' then
		if i2c_state = idle_st then
			watch_cnt		<= 0;
			watch_flag		<= '0';
		elsif sclk_dff = x"7F" or sclk_dff = x"FE" then
			watch_cnt		<= 0;
			watch_flag		<= '0';
		else
			if watch_cnt = 4095 then
				watch_cnt		<= 0;
				watch_flag		<= '1';
			else
				watch_cnt 		<= watch_cnt + 1;
				watch_flag		<= '0';
			end if;
		end if;
	end if;
end process;

reg_pro : process(rst_n, clk)
begin
	if rst_n = '0' then
		oreg00_data			<= x"F0"; -- ID
		oreg01_data			<= x"01"; -- MCU Control
		oreg02_data			<= x"03"; -- Reset & Global 
		oreg03_data			<= x"34"; -- Lazer Control
		oreg04_data			<= x"00"; -- Lazer Pattern Select
		oreg05_data			<= x"05"; -- Pattern Select   
		oreg06_data			<= x"00"; -- red signal (7 downto 0)   
		oreg07_data			<= x"30"; -- red signal (9 downto 8)   
		data_reg			<= (others => '0');
		reg_rden_d			<= '0';
		reg_updated			<= '0';

	elsif clk'event and clk = '1' then
		if read_flag = '1' then
			case reg_addr is
				when x"00" => data_reg <= ireg00_data;
				when x"01" => data_reg <= ireg01_data;
				when x"02" => data_reg <= ireg02_data;
				when x"03" => data_reg <= ireg03_data;
				when x"04" => data_reg <= ireg04_data;
				when x"05" => data_reg <= ireg05_data;
				when x"06" => data_reg <= ireg06_data;
				when others => data_reg <= ireg07_data;
			end case;
		elsif write_done = '1' then
			case reg_addr is
				when x"00" => oreg00_data <= data_out;
				when x"01" => oreg01_data <= data_out;
				when x"02" => oreg02_data <= data_out;
				when x"03" => oreg03_data <= data_out;
				when x"04" => oreg04_data <= data_out;
				when x"05" => oreg05_data <= data_out;
				when x"06" => oreg06_data <= data_out;
				when others => oreg07_data <= data_out;
			end case;
		end if;
		reg_rden_d			<= write_done;
		reg_updated			<= reg_rden_d;

	end if;
end process;

end rtl;
