From: Adam Richter <adamrichter4@gmail.com>
Subject: acpi_ds_create_operate negative array index (caught by UBSAN)
Date: Sat, 17 Dec 2016 05:03:18 -0800
Message-ID: <CAGn-Tggfj73UxdDFppKteK3ZxPDkYkq7eB2rBmYZf5tuMv_TQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:34711 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbcLQNDU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Dec 2016 08:03:20 -0500
Received: by mail-ua0-f181.google.com with SMTP id y13so16030676uay.1
        for <linux-acpi@vger.kernel.org>; Sat, 17 Dec 2016 05:03:19 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have not researched this bug much, so please feel free to redirect
me to some bug tracking system or other bug reporting process.  I just
think I should report it in case it helps anyone identify the bug
quickly from Linux 4.9, x86-64;

UBSAN: Undefined behaviour in
/home/adam/linux-kernels/source/linux-4.9.0/drivers/acpi/acpica/dsutils.c:640:16
index -1 is out of range for type 'acpi_operand_object *[9]'

The area around line 64 is in acpi_ds_create_operand:

        if ((op_info->flags & AML_HAS_RETVAL) ||
            (arg->common.flags & ACPI_PARSEOP_IN_STACK)) {
            ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
                      "Argument previously created, already stacked\n"));

            acpi_db_display_argument_object(walk_state->
                            operands[walk_state->
                                 num_operands -
                                 1],
                            walk_state);

[...]

I am guessing that num_operands is zero, and that the code assumes
that this cannot happen if ACPI_PARSEOP_IN_STACK (just guessing from
the name of the flag).

The next message that I get after the stack trace isthis warming:

[Firmware Bug]: BIOS _OSI(Linux) query ignored

Anyhow, I have appended the call trace below.  I don't know that this
bug is actually causing me any problems, but I figure I should report
it.  If anyone would like me to do something else to gather more
information, please let me know.

I hope this bug report is helpful.

Adam Richter
----------------------------------------------------------------------------------------------------
[    1.477696] Call Trace:
[    1.480154]  [<ffffffff816a5577>] dump_stack+0xed/0x146
[    1.485379]  [<ffffffff811ac48b>] ? console_unlock+0x35b/0x8b0
[    1.491212]  [<ffffffff8171abbe>] ubsan_epilogue+0x12/0x3f
[    1.496697]  [<ffffffff8171b405>] __ubsan_handle_out_of_bounds+0x77/0x85
[    1.503399]  [<ffffffff8183527e>] ? acpi_ps_get_opcode_info+0x1a0/0x1b0
[    1.510011]  [<ffffffff81802cea>] acpi_ds_create_operand+0x466/0x5f9
[    1.516365]  [<ffffffff818420bc>] ? acpi_ut_trace_ptr+0x76/0x85
[    1.522284]  [<ffffffff818030aa>] acpi_ds_create_operands+0x22d/0x329
[    1.528723]  [<ffffffff818530c7>] ? acpi_db_single_step+0x451/0x460
[    1.534990]  [<ffffffff81803d34>] acpi_ds_exec_end_op+0x1ba/0xa58
[    1.541083]  [<ffffffff81803b7a>] ? acpi_ds_exec_begin_op+0x3dc/0x3dc
[    1.547520]  [<ffffffff81833fe5>] acpi_ps_parse_loop+0xc05/0xcc1
[    1.553528]  [<ffffffff81841db0>] ? acpi_ut_exit+0x7f/0x8c
[    1.559014]  [<ffffffff81835c67>] acpi_ps_parse_aml+0x24b/0x668
[    1.564934]  [<ffffffff8183715b>] acpi_ps_execute_method+0x305/0x3fa
[    1.571285]  [<ffffffff8182919e>] acpi_ns_evaluate+0x3e9/0x575
[    1.577117]  [<ffffffff8180c254>] acpi_ev_execute_reg_method+0x2e3/0x369
[    1.583819]  [<ffffffff8180c740>] acpi_ev_reg_run+0x9c/0xaf
[    1.589390]  [<ffffffff81830373>] acpi_ns_walk_namespace+0x1c4/0x37e
[    1.595745]  [<ffffffff8180c6a4>] ? acpi_ev_detach_region+0x3ca/0x3ca
[    1.602184]  [<ffffffff8180c815>] acpi_ev_execute_reg_methods+0xc2/0x288
[    1.608883]  [<ffffffff8180cd3e>] ? acpi_ev_io_space_region_setup+0xa8/0xa8
[    1.615841]  [<ffffffff8180b3e9>] ? acpi_ev_install_space_handler+0x3c9/0x3db
[    1.622977]  [<ffffffff818114c5>]
acpi_install_address_space_handler+0x107/0x149
[    1.630369]  [<ffffffff8180d0e3>] acpi_ev_pci_config_region_setup+0x3a5/0x58f
[    1.637502]  [<ffffffff8180cd3e>] ? acpi_ev_io_space_region_setup+0xa8/0xa8
[    1.644461]  [<ffffffff8180bb5d>] acpi_ev_address_space_dispatch+0x1ad/0x46f
[    1.651507]  [<ffffffff81816d1f>] acpi_ex_access_region+0x4e8/0x5ed
[    1.657773]  [<ffffffff818174b1>] acpi_ex_field_datum_io+0x22f/0x580
[    1.664125]  [<ffffffff81841ffa>] ? acpi_ut_trace+0x6e/0x7b
[    1.669698]  [<ffffffff81817c73>] acpi_ex_extract_from_field+0x1e2/0x440
[    1.676400]  [<ffffffff818160ff>] acpi_ex_read_data_from_field+0x4bf/0x53b
[    1.683271]  [<ffffffff8181e1ca>] acpi_ex_resolve_node_to_value+0x43b/0x591
[    1.690232]  [<ffffffff8181e7ad>] acpi_ex_resolve_to_value+0x48d/0x547
[    1.696757]  [<ffffffff818032cf>] acpi_ds_evaluate_name_path+0x129/0x206
[    1.703457]  [<ffffffff81803d14>] acpi_ds_exec_end_op+0x19a/0xa58
[    1.709551]  [<ffffffff81803b7a>] ? acpi_ds_exec_begin_op+0x3dc/0x3dc
[    1.715989]  [<ffffffff81833fe5>] acpi_ps_parse_loop+0xc05/0xcc1
[    1.721996]  [<ffffffff81841db0>] ? acpi_ut_exit+0x7f/0x8c
[    1.727481]  [<ffffffff81835c67>] acpi_ps_parse_aml+0x24b/0x668
[    1.733402]  [<ffffffff817fb2bb>] acpi_ds_execute_arguments+0x1c3/0x212
[    1.740016]  [<ffffffff817fba51>] acpi_ds_get_region_arguments+0x165/0x1de
[    1.746888]  [<ffffffff8182976a>] acpi_ns_init_one_object+0xe6/0x190
[    1.753241]  [<ffffffff81830373>] acpi_ns_walk_namespace+0x1c4/0x37e
[    1.759593]  [<ffffffff81829684>] ? acpi_ns_exec_module_code_list+0x35a/0x35a
[    1.766727]  [<ffffffff81829684>] ? acpi_ns_exec_module_code_list+0x35a/0x35a
[    1.773861]  [<ffffffff81830f1f>] acpi_walk_namespace+0x124/0x17e
[    1.779951]  [<ffffffff81829d38>] acpi_ns_initialize_objects+0x13b/0x256
[    1.786653]  [<ffffffff82d40587>] acpi_initialize_objects+0xaf/0x1da
[    1.793005]  [<ffffffff82d39fa1>] ? acpi_sleep_proc_init+0x57/0x57
[    1.799183]  [<ffffffff82d3a13f>] acpi_init+0x19e/0x62e
[    1.804410]  [<ffffffff8191533c>] ? add_device_randomness+0xac/0x170
[    1.810763]  [<ffffffff82d39fa1>] ? acpi_sleep_proc_init+0x57/0x57
[    1.816944]  [<ffffffff82d39fa1>] ? acpi_sleep_proc_init+0x57/0x57
[    1.823124]  [<ffffffff810021d7>] do_one_initcall+0x67/0x260
[    1.828784]  [<ffffffff82c73e68>] kernel_init_freeable+0x57f/0x6d5
[    1.834963]  [<ffffffff81d26bf0>] ? rest_init+0xe0/0xe0
[    1.840188]  [<ffffffff81d26c08>] kernel_init+0x18/0x1a0
[    1.845499]  [<ffffffff81d26bf0>] ? rest_init+0xe0/0xe0
[    1.850727]  [<ffffffff81d45525>] ret_from_fork+0x25/0x30
