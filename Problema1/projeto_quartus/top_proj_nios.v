module top_proj_nios(
	input clk,
	input [3:0] buttons,
	output en,
	output rw,
	output rs,
	output [7:0] db
);


		proj_qsys_jogo u0 (
		.buttons_export (buttons), // buttons.export
		.clk_clk        (clk),        //     clk.clk
		.db_export      (db),      //      db.export
		.en_export      (en),      //      en.export
		.rs_export      (rs),      //      rs.export
		.rw_export      (rw)       //      rw.export
	);


endmodule
