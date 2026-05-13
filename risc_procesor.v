//====================== RISC PROCESSOR TOP MODULE ======================
module risc_processor(
    input clk,
    input rst,
    input [2:0] opcode,
    input [1:0] rs1,
    input [1:0] rs2,
    input [1:0] rd,
    output [3:0] result
);

wire reg_write;
wire [2:0] alu_sel;

wire [3:0] read_data1;
wire [3:0] read_data2;

wire [3:0] alu_result;

wire zero;


// CONTROL UNIT
control_unit CU(
    .opcode(opcode),
    .reg_write(reg_write),
    .alu_sel(alu_sel)
);


// REGISTER FILE
register_file RF(
    .clk(clk),
    .rst(rst),
    .reg_write(reg_write),
    .read_reg1(rs1),
    .read_reg2(rs2),
    .write_reg(rd),
    .write_data(alu_result),
    .read_data1(read_data1),
    .read_data2(read_data2)
);


// ALU
alu ALU(
    .A(read_data1),
    .B(read_data2),
    .ALU_Sel(alu_sel),
    .ALU_Out(alu_result),
    .Zero(zero)
);

assign result = alu_result;

endmodule
