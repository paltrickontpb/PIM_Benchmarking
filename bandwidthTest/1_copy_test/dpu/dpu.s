	.text
	.file	"dpu.c"
                                        // Start of file scope inline assembly
	.section	.data.my_barrier,"aw",@progbits
	.type	my_barrier,@object
	.globl	my_barrier
	.p2align	2
my_barrier:
	.byte	255
	.byte	1
	.byte	1
	.byte	__atomic_bit_barrier_my_barrier
	.size	my_barrier, 4
	.text

                                        // End of file scope inline assembly
	.file	1 "/home/protox" "upmem-sdk/bin/../share/upmem/include/stdlib/stdint.h"
	.file	2 "/home/protox/upmem/PIM_Benchmarking/bandwidthTest/1_copy_test/dpu" "dpu.c"
	.file	3 "/home/protox" "upmem-sdk/bin/../share/upmem/include/syslib/perfcounter.h"
	.section	.text.main,"ax",@progbits
	.globl	main                            // -- Begin function main
	.type	main,@function
main:                                   // @main
.Lfunc_begin0:
	.loc	2 22 0                          // dpu.c:22:0
	.cfi_sections .debug_frame
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset -72
	.cfi_offset 23, -8
	.cfi_offset 22, -4
	sd r22, 64, d22
	add r22, r22, 72
	sw r22, -72, 0
.Ltmp0:
	.loc	2 23 14 prologue_end            // dpu.c:23:14
	sd r22, -64, 0
	.loc	2 26 31                         // dpu.c:26:31
	call r23, me
	.loc	2 26 18 is_stmt 0               // dpu.c:26:18
	sw r22, -56, r0
.Ltmp1:
	.loc	2 29 9 is_stmt 1                // dpu.c:29:9
	lw r0, r22, -56
.Ltmp2:
	.loc	2 29 9 is_stmt 0                // dpu.c:29:9
	jneq r0, 0, .LBB0_2
	jump .LBB0_1
.LBB0_1:
.Ltmp3:
	.loc	2 30 9 is_stmt 1                // dpu.c:30:9
	call r23, mem_reset
	move r1, 1
	.loc	2 31 9                          // dpu.c:31:9
	move r0, r1
	call r23, perfcounter_config
	.loc	2 32 5                          // dpu.c:32:5
	jump .LBB0_2
.Ltmp4:
.LBB0_2:
	.loc	2 35 5                          // dpu.c:35:5
	move r0, my_barrier
	call r23, barrier_wait
.Ltmp5:
	.loc	2 38 20                         // dpu.c:38:20
	lw r0, r22, -56
	.loc	2 38 30 is_stmt 0               // dpu.c:38:30
	lsl r0, r0, 6
	.loc	2 38 20                         // dpu.c:38:20
	move.u d0, r0
	.loc	2 38 18                         // dpu.c:38:18
	sd r22, -32, d0
	.loc	2 38 9                          // dpu.c:38:9
	jump .LBB0_3
.LBB0_3:                                // =>This Loop Header: Depth=1
                                        //     Child Loop BB0_5 Depth 2
.Ltmp6:
	.loc	2 38 56                         // dpu.c:38:56
	ld d0, r22, -32
	.loc	2 38 59                         // dpu.c:38:59
	lw r3, r22, -56
	move r2, 64
	.loc	2 38 72                         // dpu.c:38:72
	lsl_add r2, r2, r3, 6
	.loc	2 38 58                         // dpu.c:38:58
	move.u d2, r2
.Ltmp7:
	.loc	2 38 5                          // dpu.c:38:5
	sub zero, r1, r3
	subc zero, r0, r2, geu, .LBB0_10
	jump .LBB0_4
.LBB0_4:                                //   in Loop: Header=BB0_3 Depth=1
.Ltmp8:
	.loc	2 40 27 is_stmt 1               // dpu.c:40:27
	lw r1, r22, -32
	.loc	2 40 20 is_stmt 0               // dpu.c:40:20
	move r0, buffer
	lsl_add r0, r0, r1, 3
	.loc	2 40 38                         // dpu.c:40:38
	lw r2, r22, -56
	.loc	2 40 32                         // dpu.c:40:32
	move r1, cache
	lsl_add r1, r1, r2, 8
	move r2, 256
	.loc	2 40 9                          // dpu.c:40:9
	call r23, mram_read
	.loc	2 43 22 is_stmt 1               // dpu.c:43:22
	call r23, perfcounter_get
	.loc	2 43 20 is_stmt 0               // dpu.c:43:20
	sd r22, -48, d0
.Ltmp9:
	.loc	2 44 22 is_stmt 1               // dpu.c:44:22
	sw r22, -24, 0
	.loc	2 44 13 is_stmt 0               // dpu.c:44:13
	jump .LBB0_5
.LBB0_5:                                //   Parent Loop BB0_3 Depth=1
                                        // =>  This Inner Loop Header: Depth=2
.Ltmp10:
	.loc	2 44 27                         // dpu.c:44:27
	lw r0, r22, -24
.Ltmp11:
	.loc	2 44 9                          // dpu.c:44:9
	jgtu r0, 31, .LBB0_8
	jump .LBB0_6
.LBB0_6:                                //   in Loop: Header=BB0_5 Depth=2
.Ltmp12:
	.loc	2 44 56                         // dpu.c:44:56
	lw r1, r22, -56
	.loc	2 44 50                         // dpu.c:44:50
	move r0, cache
	lsl_add r0, r0, r1, 8
	.loc	2 44 68                         // dpu.c:44:68
	lw r1, r22, -24
	.loc	2 44 50                         // dpu.c:44:50
	lsl_add r0, r0, r1, 3
	ld d0, r0, 0
	.loc	2 44 48                         // dpu.c:44:48
	//sd r22, -64, d0
	.loc	2 44 46                         // dpu.c:44:46
	jump .LBB0_7
.LBB0_7:                                //   in Loop: Header=BB0_5 Depth=2
	.loc	2 44 42                         // dpu.c:44:42
	lw r0, r22, -24
	add r0, r0, 1
	sw r22, -24, r0
	.loc	2 44 9                          // dpu.c:44:9
	jump .LBB0_5
.Ltmp13:
.LBB0_8:                                //   in Loop: Header=BB0_3 Depth=1
	.loc	2 45 20 is_stmt 1               // dpu.c:45:20
	call r23, perfcounter_get
	.loc	2 45 18 is_stmt 0               // dpu.c:45:18
	sd r22, -40, d0
	.loc	2 46 19 is_stmt 1               // dpu.c:46:19
	ld d0, r22, -40
	.loc	2 46 30 is_stmt 0               // dpu.c:46:30
	ld d2, r22, -48
	.loc	2 46 28                         // dpu.c:46:28
	sub r3, r1, r3
	subc r2, r0, r2
	.loc	2 46 16                         // dpu.c:46:16
	ld d0, zero, cycles
	add r1, r1, r3
	addc r0, r0, r2
	sd zero, cycles, d0
	.loc	2 48 5 is_stmt 1                // dpu.c:48:5
	jump .LBB0_9
.Ltmp14:
.LBB0_9:                                //   in Loop: Header=BB0_3 Depth=1
	.loc	2 38 99                         // dpu.c:38:99
	ld d0, r22, -32
	add r1, r1, 32
	addc r0, r0, 0
	sd r22, -32, d0
	.loc	2 38 5 is_stmt 0                // dpu.c:38:5
	jump .LBB0_3
.Ltmp15:
.LBB0_10:
	.loc	2 49 5 is_stmt 1                // dpu.c:49:5
	move r0, my_barrier
	call r23, barrier_wait
	.loc	2 50 52                         // dpu.c:50:52
	ld d2, zero, cycles
	.loc	2 50 5 is_stmt 0                // dpu.c:50:5
	move r0, r22
	sd r0, -16, d2
	move r0, .L.str
	call r23, printf
	move r0, 0
	.loc	2 51 5 is_stmt 1                // dpu.c:51:5
	ld d22, r22, -8
	jump r23
.Ltmp16:
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.main
	.long	.Lfunc_begin0
	.byte	72
	.section	.text.main,"ax",@progbits
                                        // -- End function
	.section	.text.mram_read,"ax",@progbits
	.type	mram_read,@function             // -- Begin function mram_read
mram_read:                              // @mram_read
.Lfunc_begin1:
	.file	4 "/home/protox" "upmem-sdk/bin/../share/upmem/include/syslib/mram.h"
	.loc	4 34 0                          // upmem-sdk/bin/../share/upmem/include/syslib/mram.h:34:0
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset 0
	sw r22, 0, r0
	sw r22, 4, r1
	sw r22, 8, r2
.Ltmp17:
	.loc	4 35 24 prologue_end            // upmem-sdk/bin/../share/upmem/include/syslib/mram.h:35:24
	lw r0, r22, 4
	.loc	4 35 28 is_stmt 0               // upmem-sdk/bin/../share/upmem/include/syslib/mram.h:35:28
	lw r1, r22, 0
	.loc	4 35 34                         // upmem-sdk/bin/../share/upmem/include/syslib/mram.h:35:34
	lw r3, r22, 8
	move r2, -1
	.loc	4 35 24                         // upmem-sdk/bin/../share/upmem/include/syslib/mram.h:35:24
	lsr_add r2, r2, r3, 3
	lsl_add r0, r0, r2, 24
	ldma r0, r1, 0
	.loc	4 36 1 is_stmt 1                // upmem-sdk/bin/../share/upmem/include/syslib/mram.h:36:1
	jump r23
.Ltmp18:
.Lfunc_end1:
	.size	mram_read, .Lfunc_end1-mram_read
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.mram_read
	.long	.Lfunc_begin1
	.byte	12
	.section	.text.mram_read,"ax",@progbits
                                        // -- End function
	.section	.text.me,"ax",@progbits
	.type	me,@function                    // -- Begin function me
me:                                     // @me
.Lfunc_begin2:
	.file	5 "/home/protox" "upmem-sdk/bin/../share/upmem/include/syslib/defs.h"
	.loc	5 34 0                          // upmem-sdk/bin/../share/upmem/include/syslib/defs.h:34:0
	.cfi_startproc
// %bb.0:
	.cfi_def_cfa_offset 0
	.loc	5 35 12 prologue_end            // upmem-sdk/bin/../share/upmem/include/syslib/defs.h:35:12
	move r0, id
	.loc	5 35 5 is_stmt 0                // upmem-sdk/bin/../share/upmem/include/syslib/defs.h:35:5
	jump r23
.Ltmp19:
.Lfunc_end2:
	.size	me, .Lfunc_end2-me
	.cfi_endproc
	.section	.stack_sizes,"o",@progbits,.text.me
	.long	.Lfunc_begin2
	.byte	0
	.section	.text.me,"ax",@progbits
                                        // -- End function
	.type	buffer,@object                  // @buffer
	.section	.mram,"aw",@progbits
	.globl	buffer
	.p2align	3
buffer:
	.zero	5632
	.size	buffer, 5632

	.type	cache,@object                   // @cache
	.section	.bss.cache,"aw",@nobits
	.globl	cache
	.p2align	3
cache:
	.zero	256
	.size	cache, 256

	.type	cycles,@object                  // @cycles
	.section	.dpu_host,"aw",@progbits
	.globl	cycles
	.p2align	3
cycles:
	.quad	0                               // 0x0
	.size	cycles, 8

	.type	.L.str,@object                  // @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"Total Number of Cycles Required: %lu"
	.size	.L.str, 37

	.type	__atomic_bit_barrier_my_barrier,@object // @__atomic_bit_barrier_my_barrier
	.section	.atomic,"aw",@progbits
	.globl	__atomic_bit_barrier_my_barrier
__atomic_bit_barrier_my_barrier:
	.byte	0                               // 0x0
	.size	__atomic_bit_barrier_my_barrier, 1

	.file	6 "/home/protox" "upmem-sdk/bin/../share/upmem/include/syslib/sysdef.h"
	.section	.debug_abbrev,"",@progbits
	.byte	1                               // Abbreviation Code
	.byte	17                              // DW_TAG_compile_unit
	.byte	1                               // DW_CHILDREN_yes
	.byte	37                              // DW_AT_producer
	.byte	14                              // DW_FORM_strp
	.byte	19                              // DW_AT_language
	.byte	5                               // DW_FORM_data2
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	16                              // DW_AT_stmt_list
	.byte	23                              // DW_FORM_sec_offset
	.byte	27                              // DW_AT_comp_dir
	.byte	14                              // DW_FORM_strp
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	85                              // DW_AT_ranges
	.byte	23                              // DW_FORM_sec_offset
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	2                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.ascii	"\210\001"                      // DW_AT_alignment
	.byte	15                              // DW_FORM_udata
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	3                               // Abbreviation Code
	.byte	1                               // DW_TAG_array_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	4                               // Abbreviation Code
	.byte	33                              // DW_TAG_subrange_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	55                              // DW_AT_count
	.byte	5                               // DW_FORM_data2
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	5                               // Abbreviation Code
	.byte	22                              // DW_TAG_typedef
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	6                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	7                               // Abbreviation Code
	.byte	36                              // DW_TAG_base_type
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	62                              // DW_AT_encoding
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	8                               // Abbreviation Code
	.byte	33                              // DW_TAG_subrange_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	55                              // DW_AT_count
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	9                               // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	10                              // Abbreviation Code
	.byte	4                               // DW_TAG_enumeration_type
	.byte	1                               // DW_CHILDREN_yes
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	11                              // DW_AT_byte_size
	.byte	11                              // DW_FORM_data1
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	11                              // Abbreviation Code
	.byte	40                              // DW_TAG_enumerator
	.byte	0                               // DW_CHILDREN_no
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	28                              // DW_AT_const_value
	.byte	15                              // DW_FORM_udata
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	12                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	63                              // DW_AT_external
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	13                              // Abbreviation Code
	.byte	52                              // DW_TAG_variable
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	14                              // Abbreviation Code
	.byte	11                              // DW_TAG_lexical_block
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	15                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	1                               // DW_CHILDREN_yes
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	39                              // DW_AT_prototyped
	.byte	25                              // DW_FORM_flag_present
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	16                              // Abbreviation Code
	.byte	5                               // DW_TAG_formal_parameter
	.byte	0                               // DW_CHILDREN_no
	.byte	2                               // DW_AT_location
	.byte	24                              // DW_FORM_exprloc
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	17                              // Abbreviation Code
	.byte	46                              // DW_TAG_subprogram
	.byte	0                               // DW_CHILDREN_no
	.byte	17                              // DW_AT_low_pc
	.byte	1                               // DW_FORM_addr
	.byte	18                              // DW_AT_high_pc
	.byte	6                               // DW_FORM_data4
	.byte	64                              // DW_AT_frame_base
	.byte	24                              // DW_FORM_exprloc
	.byte	3                               // DW_AT_name
	.byte	14                              // DW_FORM_strp
	.byte	58                              // DW_AT_decl_file
	.byte	11                              // DW_FORM_data1
	.byte	59                              // DW_AT_decl_line
	.byte	11                              // DW_FORM_data1
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	18                              // Abbreviation Code
	.byte	15                              // DW_TAG_pointer_type
	.byte	0                               // DW_CHILDREN_no
	.byte	73                              // DW_AT_type
	.byte	19                              // DW_FORM_ref4
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	19                              // Abbreviation Code
	.byte	38                              // DW_TAG_const_type
	.byte	0                               // DW_CHILDREN_no
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	20                              // Abbreviation Code
	.byte	15                              // DW_TAG_pointer_type
	.byte	0                               // DW_CHILDREN_no
	.byte	0                               // EOM(1)
	.byte	0                               // EOM(2)
	.byte	0                               // EOM(3)
	.section	.debug_info,"",@progbits
.Lcu_begin0:
	.long	.Ldebug_info_end0-.Ldebug_info_start0 // Length of Unit
.Ldebug_info_start0:
	.short	4                               // DWARF version number
	.long	.debug_abbrev                   // Offset Into Abbrev. Section
	.byte	4                               // Address Size (in bytes)
	.byte	1                               // Abbrev [1] 0xb:0x1d7 DW_TAG_compile_unit
	.long	.Linfo_string0                  // DW_AT_producer
	.short	12                              // DW_AT_language
	.long	.Linfo_string1                  // DW_AT_name
	.long	.Lline_table_start0             // DW_AT_stmt_list
	.long	.Linfo_string2                  // DW_AT_comp_dir
	.long	0                               // DW_AT_low_pc
	.long	.Ldebug_ranges0                 // DW_AT_ranges
	.byte	2                               // Abbrev [2] 0x26:0x12 DW_TAG_variable
	.long	.Linfo_string3                  // DW_AT_name
	.long	56                              // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	14                              // DW_AT_decl_line
	.byte	8                               // DW_AT_alignment
	.byte	5                               // DW_AT_location
	.byte	3
	.long	buffer
	.byte	3                               // Abbrev [3] 0x38:0xd DW_TAG_array_type
	.long	69                              // DW_AT_type
	.byte	4                               // Abbrev [4] 0x3d:0x7 DW_TAG_subrange_type
	.long	87                              // DW_AT_type
	.short	704                             // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	5                               // Abbrev [5] 0x45:0xb DW_TAG_typedef
	.long	80                              // DW_AT_type
	.long	.Linfo_string5                  // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	53                              // DW_AT_decl_line
	.byte	6                               // Abbrev [6] 0x50:0x7 DW_TAG_base_type
	.long	.Linfo_string4                  // DW_AT_name
	.byte	7                               // DW_AT_encoding
	.byte	8                               // DW_AT_byte_size
	.byte	7                               // Abbrev [7] 0x57:0x7 DW_TAG_base_type
	.long	.Linfo_string6                  // DW_AT_name
	.byte	8                               // DW_AT_byte_size
	.byte	7                               // DW_AT_encoding
	.byte	2                               // Abbrev [2] 0x5e:0x12 DW_TAG_variable
	.long	.Linfo_string7                  // DW_AT_name
	.long	69                              // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	15                              // DW_AT_decl_line
	.byte	8                               // DW_AT_alignment
	.byte	5                               // DW_AT_location
	.byte	3
	.long	cycles
	.byte	2                               // Abbrev [2] 0x70:0x12 DW_TAG_variable
	.long	.Linfo_string8                  // DW_AT_name
	.long	130                             // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	17                              // DW_AT_decl_line
	.byte	8                               // DW_AT_alignment
	.byte	5                               // DW_AT_location
	.byte	3
	.long	cache
	.byte	3                               // Abbrev [3] 0x82:0x12 DW_TAG_array_type
	.long	69                              // DW_AT_type
	.byte	8                               // Abbrev [8] 0x87:0x6 DW_TAG_subrange_type
	.long	87                              // DW_AT_type
	.byte	1                               // DW_AT_count
	.byte	8                               // Abbrev [8] 0x8d:0x6 DW_TAG_subrange_type
	.long	87                              // DW_AT_type
	.byte	32                              // DW_AT_count
	.byte	0                               // End Of Children Mark
	.byte	9                               // Abbrev [9] 0x94:0x11 DW_TAG_variable
	.long	.Linfo_string9                  // DW_AT_name
	.long	165                             // DW_AT_type
                                        // DW_AT_external
	.byte	2                               // DW_AT_decl_file
	.byte	20                              // DW_AT_decl_line
	.byte	5                               // DW_AT_location
	.byte	3
	.long	__atomic_bit_barrier_my_barrier
	.byte	5                               // Abbrev [5] 0xa5:0xb DW_TAG_typedef
	.long	176                             // DW_AT_type
	.long	.Linfo_string11                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	40                              // DW_AT_decl_line
	.byte	6                               // Abbrev [6] 0xb0:0x7 DW_TAG_base_type
	.long	.Linfo_string10                 // DW_AT_name
	.byte	8                               // DW_AT_encoding
	.byte	1                               // DW_AT_byte_size
	.byte	10                              // Abbrev [10] 0xb7:0x25 DW_TAG_enumeration_type
	.long	220                             // DW_AT_type
	.long	.Linfo_string17                 // DW_AT_name
	.byte	4                               // DW_AT_byte_size
	.byte	3                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.byte	11                              // Abbrev [11] 0xc3:0x6 DW_TAG_enumerator
	.long	.Linfo_string13                 // DW_AT_name
	.byte	0                               // DW_AT_const_value
	.byte	11                              // Abbrev [11] 0xc9:0x6 DW_TAG_enumerator
	.long	.Linfo_string14                 // DW_AT_name
	.byte	1                               // DW_AT_const_value
	.byte	11                              // Abbrev [11] 0xcf:0x6 DW_TAG_enumerator
	.long	.Linfo_string15                 // DW_AT_name
	.byte	2                               // DW_AT_const_value
	.byte	11                              // Abbrev [11] 0xd5:0x6 DW_TAG_enumerator
	.long	.Linfo_string16                 // DW_AT_name
	.byte	3                               // DW_AT_const_value
	.byte	0                               // End Of Children Mark
	.byte	6                               // Abbrev [6] 0xdc:0x7 DW_TAG_base_type
	.long	.Linfo_string12                 // DW_AT_name
	.byte	7                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	12                              // Abbrev [12] 0xe3:0x7e DW_TAG_subprogram
	.long	.Lfunc_begin0                   // DW_AT_low_pc
	.long	.Lfunc_end0-.Lfunc_begin0       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
	.long	.Linfo_string18                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	22                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.long	434                             // DW_AT_type
                                        // DW_AT_external
	.byte	13                              // Abbrev [13] 0xf8:0xe DW_TAG_variable
	.byte	2                               // DW_AT_location
	.byte	145
	.byte	64
	.long	.Linfo_string23                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	23                              // DW_AT_decl_line
	.long	69                              // DW_AT_type
	.byte	13                              // Abbrev [13] 0x106:0xe DW_TAG_variable
	.byte	2                               // DW_AT_location
	.byte	145
	.byte	72
	.long	.Linfo_string24                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	26                              // DW_AT_decl_line
	.long	220                             // DW_AT_type
	.byte	13                              // Abbrev [13] 0x114:0xe DW_TAG_variable
	.byte	2                               // DW_AT_location
	.byte	145
	.byte	80
	.long	.Linfo_string25                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	452                             // DW_AT_type
	.byte	13                              // Abbrev [13] 0x122:0xe DW_TAG_variable
	.byte	2                               // DW_AT_location
	.byte	145
	.byte	88
	.long	.Linfo_string27                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	452                             // DW_AT_type
	.byte	14                              // Abbrev [14] 0x130:0x30 DW_TAG_lexical_block
	.long	.Ltmp5                          // DW_AT_low_pc
	.long	.Ltmp15-.Ltmp5                  // DW_AT_high_pc
	.byte	13                              // Abbrev [13] 0x139:0xe DW_TAG_variable
	.byte	2                               // DW_AT_location
	.byte	145
	.byte	96
	.long	.Linfo_string28                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	38                              // DW_AT_decl_line
	.long	69                              // DW_AT_type
	.byte	14                              // Abbrev [14] 0x147:0x18 DW_TAG_lexical_block
	.long	.Ltmp9                          // DW_AT_low_pc
	.long	.Ltmp13-.Ltmp9                  // DW_AT_high_pc
	.byte	13                              // Abbrev [13] 0x150:0xe DW_TAG_variable
	.byte	2                               // DW_AT_location
	.byte	145
	.byte	104
	.long	.Linfo_string29                 // DW_AT_name
	.byte	2                               // DW_AT_decl_file
	.byte	44                              // DW_AT_decl_line
	.long	463                             // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	0                               // End Of Children Mark
	.byte	15                              // Abbrev [15] 0x161:0x3c DW_TAG_subprogram
	.long	.Lfunc_begin1                   // DW_AT_low_pc
	.long	.Lfunc_end1-.Lfunc_begin1       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
	.long	.Linfo_string20                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
                                        // DW_AT_prototyped
	.byte	16                              // Abbrev [16] 0x172:0xe DW_TAG_formal_parameter
	.byte	2                               // DW_AT_location
	.byte	145
	.byte	0
	.long	.Linfo_string31                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	474                             // DW_AT_type
	.byte	16                              // Abbrev [16] 0x180:0xe DW_TAG_formal_parameter
	.byte	2                               // DW_AT_location
	.byte	145
	.byte	4
	.long	.Linfo_string32                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	480                             // DW_AT_type
	.byte	16                              // Abbrev [16] 0x18e:0xe DW_TAG_formal_parameter
	.byte	2                               // DW_AT_location
	.byte	145
	.byte	8
	.long	.Linfo_string33                 // DW_AT_name
	.byte	4                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	220                             // DW_AT_type
	.byte	0                               // End Of Children Mark
	.byte	17                              // Abbrev [17] 0x19d:0x15 DW_TAG_subprogram
	.long	.Lfunc_begin2                   // DW_AT_low_pc
	.long	.Lfunc_end2-.Lfunc_begin2       // DW_AT_high_pc
	.byte	1                               // DW_AT_frame_base
	.byte	102
	.long	.Linfo_string21                 // DW_AT_name
	.byte	5                               // DW_AT_decl_file
	.byte	33                              // DW_AT_decl_line
	.long	441                             // DW_AT_type
	.byte	6                               // Abbrev [6] 0x1b2:0x7 DW_TAG_base_type
	.long	.Linfo_string19                 // DW_AT_name
	.byte	5                               // DW_AT_encoding
	.byte	4                               // DW_AT_byte_size
	.byte	5                               // Abbrev [5] 0x1b9:0xb DW_TAG_typedef
	.long	220                             // DW_AT_type
	.long	.Linfo_string22                 // DW_AT_name
	.byte	6                               // DW_AT_decl_file
	.byte	27                              // DW_AT_decl_line
	.byte	5                               // Abbrev [5] 0x1c4:0xb DW_TAG_typedef
	.long	69                              // DW_AT_type
	.long	.Linfo_string26                 // DW_AT_name
	.byte	3                               // DW_AT_decl_file
	.byte	22                              // DW_AT_decl_line
	.byte	5                               // Abbrev [5] 0x1cf:0xb DW_TAG_typedef
	.long	220                             // DW_AT_type
	.long	.Linfo_string30                 // DW_AT_name
	.byte	1                               // DW_AT_decl_file
	.byte	48                              // DW_AT_decl_line
	.byte	18                              // Abbrev [18] 0x1da:0x5 DW_TAG_pointer_type
	.long	479                             // DW_AT_type
	.byte	19                              // Abbrev [19] 0x1df:0x1 DW_TAG_const_type
	.byte	20                              // Abbrev [20] 0x1e0:0x1 DW_TAG_pointer_type
	.byte	0                               // End Of Children Mark
.Ldebug_info_end0:
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.long	.Lfunc_begin0
	.long	.Lfunc_end0
	.long	.Lfunc_begin1
	.long	.Lfunc_end1
	.long	.Lfunc_begin2
	.long	.Lfunc_end2
	.long	0
	.long	0
	.section	.debug_str,"MS",@progbits,1
.Linfo_string0:
	.asciz	"clang version 12.0.0 (https://github.com/upmem/llvm-project.git d36425841d9a4d1420b7aa155675f6ae8bcf9f08)" // string offset=0
.Linfo_string1:
	.asciz	"dpu.c"                         // string offset=106
.Linfo_string2:
	.asciz	"/home/protox/upmem/PIM_Benchmarking/bandwidthTest/1_copy_test/dpu" // string offset=112
.Linfo_string3:
	.asciz	"buffer"                        // string offset=178
.Linfo_string4:
	.asciz	"long unsigned int"             // string offset=185
.Linfo_string5:
	.asciz	"uint64_t"                      // string offset=203
.Linfo_string6:
	.asciz	"__ARRAY_SIZE_TYPE__"           // string offset=212
.Linfo_string7:
	.asciz	"cycles"                        // string offset=232
.Linfo_string8:
	.asciz	"cache"                         // string offset=239
.Linfo_string9:
	.asciz	"__atomic_bit_barrier_my_barrier" // string offset=245
.Linfo_string10:
	.asciz	"unsigned char"                 // string offset=277
.Linfo_string11:
	.asciz	"uint8_t"                       // string offset=291
.Linfo_string12:
	.asciz	"unsigned int"                  // string offset=299
.Linfo_string13:
	.asciz	"COUNT_SAME"                    // string offset=312
.Linfo_string14:
	.asciz	"COUNT_CYCLES"                  // string offset=323
.Linfo_string15:
	.asciz	"COUNT_INSTRUCTIONS"            // string offset=336
.Linfo_string16:
	.asciz	"COUNT_NOTHING"                 // string offset=355
.Linfo_string17:
	.asciz	"_perfcounter_config_t"         // string offset=369
.Linfo_string18:
	.asciz	"main"                          // string offset=391
.Linfo_string19:
	.asciz	"int"                           // string offset=396
.Linfo_string20:
	.asciz	"mram_read"                     // string offset=400
.Linfo_string21:
	.asciz	"me"                            // string offset=410
.Linfo_string22:
	.asciz	"sysname_t"                     // string offset=413
.Linfo_string23:
	.asciz	"a"                             // string offset=423
.Linfo_string24:
	.asciz	"tasklet_id"                    // string offset=425
.Linfo_string25:
	.asciz	"start_time"                    // string offset=436
.Linfo_string26:
	.asciz	"perfcounter_t"                 // string offset=447
.Linfo_string27:
	.asciz	"end_time"                      // string offset=461
.Linfo_string28:
	.asciz	"i"                             // string offset=470
.Linfo_string29:
	.asciz	"j"                             // string offset=472
.Linfo_string30:
	.asciz	"uint32_t"                      // string offset=474
.Linfo_string31:
	.asciz	"from"                          // string offset=483
.Linfo_string32:
	.asciz	"to"                            // string offset=488
.Linfo_string33:
	.asciz	"nb_of_bytes"                   // string offset=491
	.addrsig
	.addrsig_sym mem_reset
	.addrsig_sym perfcounter_config
	.addrsig_sym barrier_wait
	.addrsig_sym mram_read
	.addrsig_sym perfcounter_get
	.addrsig_sym printf
	.addrsig_sym me
	.addrsig_sym my_barrier
	.addrsig_sym buffer
	.addrsig_sym cache
	.addrsig_sym cycles
	.section	.debug_line,"",@progbits
.Lline_table_start0:
