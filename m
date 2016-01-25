From: Eric Biggers <ebiggers3@gmail.com>
Subject: Out-of-bounds array index in acpi_ds_create_operand()
Date: Sun, 24 Jan 2016 19:33:08 -0600
Message-ID: <20160125013308.GA1908@zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, devel@acpica.org, lenb@kernel.org, rafael.j.wysocki@intel.com, lv.zheng@intel.com, robert.moore@intel.com
List-Id: linux-acpi@vger.kernel.org

Hi,

When booting Linux 4.5-rc1 with UBSAN enabled, I see the following report of
undefined behavior:

[    0.675383] ================================================================================
[    0.675387] UBSAN: Undefined behaviour in drivers/acpi/acpica/dsutils.c:641:16
[    0.675390] index -1 is out of range for type 'acpi_operand_object *[9]'
[    0.675393] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc1 #126
[    0.675394] Hardware name: Dell Inc. Inspiron 15-7568/0M5YMV, BIOS 01.00.00 08/07/2015
[    0.675395]  ffffffffffffffff 0000000072577c57 ffff88026896b900 ffffffff8159dc2b
[    0.675398]  ffff88026896b930 0000000072577c57 ffff88026896b928 ffff88026896b918
[    0.675400]  ffffffff816034ed ffffffff8275e260 ffff88026896b970 ffffffff81603c65
[    0.675402] Call Trace:
[    0.675406]  [<ffffffff8159dc2b>] dump_stack+0x57/0x8c
[    0.675409]  [<ffffffff816034ed>] ubsan_epilogue+0xd/0x40
[    0.675411]  [<ffffffff81603c65>] __ubsan_handle_out_of_bounds+0x75/0xa0
[    0.675414]  [<ffffffff816a0cf7>] acpi_ds_create_operand+0x253/0x307
[    0.675416]  [<ffffffff816a0ee2>] acpi_ds_create_operands+0x137/0x19c
[    0.675419]  [<ffffffff816c3b74>] ? acpi_ut_update_object_reference+0x13f/0x1d5
[    0.675420]  [<ffffffff8169d264>] acpi_ds_exec_end_control_op+0x174/0x31b
[    0.675422]  [<ffffffff816a1787>] acpi_ds_exec_end_op+0x2a3/0x56a
[    0.675425]  [<ffffffff816baa27>] acpi_ps_parse_loop+0x731/0x797
[    0.675427]  [<ffffffff816bbae3>] acpi_ps_parse_aml+0xa7/0x2d2
[    0.675430]  [<ffffffff816bc6b8>] acpi_ps_execute_method+0x1e3/0x21d
[    0.675431]  [<ffffffff816b4631>] acpi_ns_evaluate+0x228/0x2b8
[    0.675433]  [<ffffffff816c403e>] acpi_ut_evaluate_object+0x6b/0x1b1
[    0.675435]  [<ffffffff816c603e>] ? acpi_ut_delete_object_desc+0x58/0x5b
[    0.675448]  [<ffffffff81691214>] ? param_set_event_clearing+0x95/0x95
[    0.675450]  [<ffffffff816beaf7>] acpi_rs_get_method_data+0x29/0x5f
[    0.675452]  [<ffffffff816bf0ac>] acpi_walk_resources+0x79/0xce
[    0.675454]  [<ffffffff81690d9a>] ec_parse_device+0x64/0xd2
[    0.675456]  [<ffffffff816b8abf>] acpi_ns_get_device_callback+0x180/0x1a3
[    0.675459]  [<ffffffff816b82ad>] acpi_ns_walk_namespace+0x11a/0x1d6
[    0.675461]  [<ffffffff816b893f>] ? acpi_evaluate_object_typed+0xf3/0xf3
[    0.675464]  [<ffffffff82c53490>] ? acpi_sleep_proc_init+0x28/0x28
[    0.675466]  [<ffffffff816b8688>] acpi_get_devices+0x65/0x8f
[    0.675467]  [<ffffffff81690d36>] ? acpi_ec_event_processor+0xbd/0xbd
[    0.675470]  [<ffffffff82c53fbc>] acpi_ec_ecdt_probe+0x157/0x269
[    0.675471]  [<ffffffff82c5352a>] acpi_init+0x9a/0x2d0
[    0.675474]  [<ffffffff815b9ebe>] ? kasprintf+0x4e/0x70
[    0.675476]  [<ffffffff810003f8>] do_one_initcall+0xc8/0x270
[    0.675478]  [<ffffffff82c17abe>] ? initcall_blacklist+0x12e/0x12e
[    0.675481]  [<ffffffff82c1872b>] kernel_init_freeable+0x248/0x2de
[    0.675483]  [<ffffffff81c4fa40>] ? rest_init+0x80/0x80
[    0.675485]  [<ffffffff81c4fa49>] kernel_init+0x9/0xe0
[    0.675487]  [<ffffffff81c5841f>] ret_from_fork+0x3f/0x70
[    0.675489]  [<ffffffff81c4fa40>] ? rest_init+0x80/0x80
[    0.675490] ================================================================================

The offending statement is the following, where num_operands was apparently 0,
resulting in an index of -1 into the 'operands' array:

	acpi_db_display_argument_object(walk_state->
					operands[walk_state->
						 num_operands -
						 1],
					walk_state);
