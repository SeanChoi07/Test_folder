------------------------------------------------------------------------
--                     		   program description
-- project name 	: I2C Slave design
-- file name 		: i2c_slave.vhd
-- Design by 		: Innofeels
-------------------------------------------------------------------------------
-- Simulation  		: Modelsim 10.0b
-- Synthesis		: QuartusII 13.1
-- Target      		: CycloneIV
-- Revision Date	: 2016.04.16
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
	ireg08_data			: in std_logic_vector(7 downto 0);
	ireg09_data			: in std_logic_vector(7 downto 0);
	ireg10_data			: in std_logic_vector(7 downto 0);
	ireg11_data			: in std_logic_vector(7 downto 0);
	ireg12_data			: in std_logic_vector(7 downto 0);
	ireg13_data			: in std_logic_vector(7 downto 0);
	ireg14_data			: in std_logic_vector(7 downto 0);
	ireg15_data			: in std_logic_vector(7 downto 0);
	ireg16_data			: in std_logic_vector(7 downto 0);
	ireg17_data			: in std_logic_vector(7 downto 0);
	ireg18_data			: in std_logic_vector(7 downto 0);
	ireg19_data			: in std_logic_vector(7 downto 0);
	ireg20_data			: in std_logic_vector(7 downto 0);
	ireg21_data			: in std_logic_vector(7 downto 0);
	ireg22_data			: in std_logic_vector(7 downto 0);
	ireg23_data			: in std_logic_vector(7 downto 0);
	ireg24_data			: in std_logic_vector(7 downto 0);
	ireg25_data			: in std_logic_vector(7 downto 0);
	ireg26_data			: in std_logic_vector(7 downto 0);
	ireg27_data			: in std_logic_vector(7 downto 0);
	ireg28_data			: in std_logic_vector(7 downto 0);
	ireg29_data			: in std_logic_vector(7 downto 0);
	ireg30_data			: in std_logic_vector(7 downto 0);
	ireg31_data			: in std_logic_vector(7 downto 0);
	ireg32_data			: in std_logic_vector(7 downto 0);
	ireg33_data			: in std_logic_vector(7 downto 0);
	ireg34_data			: in std_logic_vector(7 downto 0);
	ireg35_data			: in std_logic_vector(7 downto 0);
	ireg36_data			: in std_logic_vector(7 downto 0);
	ireg37_data			: in std_logic_vector(7 downto 0);
	ireg38_data			: in std_logic_vector(7 downto 0);
	ireg39_data			: in std_logic_vector(7 downto 0);
	ireg40_data			: in std_logic_vector(7 downto 0);
	ireg41_data			: in std_logic_vector(7 downto 0);
	ireg42_data			: in std_logic_vector(7 downto 0);
	ireg43_data			: in std_logic_vector(7 downto 0);
    ireg44_data         : in std_logic_vector(7 downto 0);
    ireg45_data         : in std_logic_vector(7 downto 0);
    ireg46_data         : in std_logic_vector(7 downto 0);
    ireg47_data         : in std_logic_vector(7 downto 0);
    ireg48_data         : in std_logic_vector(7 downto 0);
    ireg49_data         : in std_logic_vector(7 downto 0);

	reg_updated			: out std_logic;
	oreg00_data			: out std_logic_vector(7 downto 0);
	oreg01_data			: out std_logic_vector(7 downto 0);
	oreg02_data			: out std_logic_vector(7 downto 0);
	oreg03_data			: out std_logic_vector(7 downto 0);
	oreg04_data			: out std_logic_vector(7 downto 0);
	oreg05_data			: out std_logic_vector(7 downto 0);
	oreg06_data			: out std_logic_vector(7 downto 0);
	oreg07_data			: out std_logic_vector(7 downto 0);
	oreg08_data			: out std_logic_vector(7 downto 0);
	oreg09_data			: out std_logic_vector(7 downto 0);
	oreg10_data			: out std_logic_vector(7 downto 0);
	oreg11_data			: out std_logic_vector(7 downto 0);
	oreg12_data			: out std_logic_vector(7 downto 0);
	oreg13_data			: out std_logic_vector(7 downto 0);
	oreg14_data			: out std_logic_vector(7 downto 0);
	oreg15_data			: out std_logic_vector(7 downto 0);
	oreg16_data			: out std_logic_vector(7 downto 0);
	oreg17_data			: out std_logic_vector(7 downto 0);
	oreg18_data			: out std_logic_vector(7 downto 0);
	oreg19_data			: out std_logic_vector(7 downto 0);
	oreg20_data			: out std_logic_vector(7 downto 0);
	oreg21_data			: out std_logic_vector(7 downto 0);
	oreg22_data			: out std_logic_vector(7 downto 0);
	oreg23_data			: out std_logic_vector(7 downto 0);
	oreg24_data			: out std_logic_vector(7 downto 0);
	oreg25_data			: out std_logic_vector(7 downto 0);
	oreg26_data			: out std_logic_vector(7 downto 0);
	oreg27_data			: out std_logic_vector(7 downto 0);
	oreg28_data			: out std_logic_vector(7 downto 0);
	oreg29_data			: out std_logic_vector(7 downto 0);
	oreg30_data			: out std_logic_vector(7 downto 0);
	oreg31_data			: out std_logic_vector(7 downto 0);
	oreg32_data			: out std_logic_vector(7 downto 0);
	oreg33_data			: out std_logic_vector(7 downto 0);
	oreg34_data			: out std_logic_vector(7 downto 0);
	oreg35_data			: out std_logic_vector(7 downto 0);
	oreg36_data			: out std_logic_vector(7 downto 0);
	oreg37_data			: out std_logic_vector(7 downto 0);
	oreg38_data			: out std_logic_vector(7 downto 0);
	oreg39_data			: out std_logic_vector(7 downto 0);
	oreg40_data			: out std_logic_vector(7 downto 0);
	oreg41_data			: out std_logic_vector(7 downto 0);
	oreg42_data			: out std_logic_vector(7 downto 0);
    oreg43_data         : out std_logic_vector(7 downto 0);
    oreg44_data         : out std_logic_vector(7 downto 0);
    oreg45_data         : out std_logic_vector(7 downto 0);
    oreg46_data         : out std_logic_vector(7 downto 0);
    oreg47_data         : out std_logic_vector(7 downto 0);
    oreg48_data         : out std_logic_vector(7 downto 0);
    oreg49_data         : out std_logic_vector(7 downto 0)

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
		oreg08_data			<= x"02"; -- green signal (7 downto 0)   
		oreg09_data			<= x"00"; -- green signal (9 downto 8)   
		oreg10_data			<= x"00"; -- blue signal (7 downto 0)   
		oreg11_data			<= x"D0"; -- blue signal (9 downto 8)   
		oreg12_data			<= x"02"; -- NCO Phase 0
		oreg13_data			<= x"05"; -- NCO Phase 1 
		oreg14_data			<= x"00"; -- NCO Phase 2 
		oreg15_data			<= x"30"; -- NCO Phase 3 
		oreg16_data			<= x"00"; -- NCO Phase 4 
		oreg17_data			<= x"0A"; -- NCO Phase 5  
		oreg18_data			<= x"00"; -- NCO Phase 6 
		oreg19_data			<= x"00"; -- NCO Phase 7
		oreg20_data			<= x"00"; -- NCO Update
		oreg21_data			<= x"00"; -- V & D Output Size
		oreg22_data			<= x"00"; -- Vsync Inversion 
--		oreg23_data			<= x"18"; -- Vsync Long Period    
--		oreg24_data			<= x"0E"; -- Vsync Short Period    
		oreg23_data			<= x"50"; -- Vsync Long Period    
		oreg24_data			<= x"14"; -- Vsync Short Period    
		oreg25_data			<= x"08"; -- DE Start Point(7 downto 0)
		oreg26_data			<= x"00"; -- DE Start Point(9 downto 8)
		oreg27_data			<= x"1C"; -- DE VALID NUM(7 downto 0)   
		oreg28_data			<= x"02"; -- DE VALID NUM(9 downto 8)   
		oreg29_data			<= x"00"; -- Sync Update  
		oreg30_data			<= x"00"; -- ADC Power Update   
		oreg31_data			<= x"01"; -- PIX FRONT Start Point(7 downto 0)       
		oreg32_data			<= x"00"; -- PIX FRONT Start Point(11 downto 8)     
		oreg33_data			<= x"01"; -- PIX END Start Point(7 downto 0)         
		oreg34_data			<= x"00"; -- PIX END Start Point(11 downto 8)  
		oreg35_data			<= x"80"; -- PIX VALID(7 downto 0)  
		oreg36_data			<= x"07"; -- PIX VALID(11 downto 8) 
		oreg37_data			<= x"00"; 
		oreg38_data			<= x"00"; 
		oreg39_data			<= x"00"; 
		oreg40_data			<= x"00"; 
		oreg41_data			<= x"00"; 
		oreg42_data			<= x"00"; 
		oreg43_data			<= x"00"; 
		oreg44_data			<= x"00"; 
		oreg45_data			<= x"0F"; 
		oreg46_data			<= x"00"; 
		oreg47_data			<= x"00"; 
		oreg48_data			<= x"00"; 
		oreg49_data			<= x"00"; 
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
				when x"07" => data_reg <= ireg07_data;
				when x"08" => data_reg <= ireg08_data;
				when x"09" => data_reg <= ireg09_data;
				when x"0a" => data_reg <= ireg10_data;
				when x"0b" => data_reg <= ireg11_data;
				when x"0c" => data_reg <= ireg12_data;
				when x"0d" => data_reg <= ireg13_data;
				when x"0e" => data_reg <= ireg14_data;
				when x"0f" => data_reg <= ireg15_data;
				when x"10" => data_reg <= ireg16_data;
				when x"11" => data_reg <= ireg17_data;
				when x"12" => data_reg <= ireg18_data;
				when x"13" => data_reg <= ireg19_data;
				when x"14" => data_reg <= ireg20_data;
				when x"15" => data_reg <= ireg21_data;
				when x"16" => data_reg <= ireg22_data;
				when x"17" => data_reg <= ireg23_data;
				when x"18" => data_reg <= ireg24_data;
				when x"19" => data_reg <= ireg25_data;
				when x"1a" => data_reg <= ireg26_data;
				when x"1b" => data_reg <= ireg27_data;
				when x"1c" => data_reg <= ireg28_data;
				when x"1d" => data_reg <= ireg29_data;
				when x"1e" => data_reg <= ireg30_data;
				when x"1f" => data_reg <= ireg31_data;
				when x"20" => data_reg <= ireg32_data;
				when x"21" => data_reg <= ireg33_data;
				when x"22" => data_reg <= ireg34_data;
				when x"23" => data_reg <= ireg35_data;
				when x"24" => data_reg <= ireg36_data;
				when x"25" => data_reg <= ireg37_data;
				when x"26" => data_reg <= ireg38_data;
				when x"27" => data_reg <= ireg39_data;
				when x"28" => data_reg <= ireg40_data;
				when x"29" => data_reg <= ireg41_data;
				when x"2a" => data_reg <= ireg42_data;
				when x"2b" => data_reg <= ireg43_data;
				when x"2c" => data_reg <= ireg44_data;
				when x"2d" => data_reg <= ireg45_data;
				when x"2e" => data_reg <= ireg46_data;
				when x"2f" => data_reg <= ireg47_data;
				when x"30" => data_reg <= ireg48_data;
				when x"31" => data_reg <= ireg49_data;
				when others => null;
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
				when x"07" => oreg07_data <= data_out;
				when x"08" => oreg08_data <= data_out;
				when x"09" => oreg09_data <= data_out;
				when x"0a" => oreg10_data <= data_out;
				when x"0b" => oreg11_data <= data_out;
				when x"0c" => oreg12_data <= data_out;
				when x"0d" => oreg13_data <= data_out;
				when x"0e" => oreg14_data <= data_out;
				when x"0f" => oreg15_data <= data_out;
				when x"10" => oreg16_data <= data_out;
				when x"11" => oreg17_data <= data_out;
				when x"12" => oreg18_data <= data_out;
				when x"13" => oreg19_data <= data_out;
				when x"14" => oreg20_data <= data_out;
				when x"15" => oreg21_data <= data_out;
				when x"16" => oreg22_data <= data_out;
				when x"17" => oreg23_data <= data_out;
				when x"18" => oreg24_data <= data_out;
				when x"19" => oreg25_data <= data_out;
				when x"1a" => oreg26_data <= data_out;
				when x"1b" => oreg27_data <= data_out;
				when x"1c" => oreg28_data <= data_out;
				when x"1d" => oreg29_data <= data_out;
				when x"1e" => oreg30_data <= data_out;
				when x"1f" => oreg31_data <= data_out;
				when x"20" => oreg32_data <= data_out;
				when x"21" => oreg33_data <= data_out;
				when x"22" => oreg34_data <= data_out;
				when x"23" => oreg35_data <= data_out;
				when x"24" => oreg36_data <= data_out;
				when x"25" => oreg37_data <= data_out;
				when x"26" => oreg38_data <= data_out;
				when x"27" => oreg39_data <= data_out;
				when x"28" => oreg40_data <= data_out;
				when x"29" => oreg41_data <= data_out;
				when x"2a" => oreg42_data <= data_out;
				when x"2b" => oreg43_data <= data_out;
				when x"2c" => oreg44_data <= data_out;
				when x"2d" => oreg45_data <= data_out;
				when x"2e" => oreg46_data <= data_out;
				when x"2f" => oreg47_data <= data_out;
				when x"30" => oreg48_data <= data_out;
				when x"31" => oreg49_data <= data_out;
				when others => null;
			end case;
		end if;
		reg_rden_d			<= write_done;
		reg_updated			<= reg_rden_d;

	end if;
end process;

end rtl;
