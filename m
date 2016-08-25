From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] acpi: fix ubsan warning
Date: Thu, 25 Aug 2016 07:11:20 -0400 (EDT)
Message-ID: <alpine.LRH.2.02.1608250709480.24332@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This patch fixes the following warning. The warning happens when using the
Linux kernel 4.8-rc1 on kvm virtual machine, on Debian Jessie host.

================================================================================
UBSAN: Undefined behaviour in drivers/acpi/acpica/dsutils.c:641:16
index -1 is out of range for type 'acpi_operand_object *[9]'
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.8.0-rc1+ #2
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
 0000000000000000 ffff88011b17b9c8 ffffffff81264718 0000000000000002
 ffff88011b17b9f0 ffffffffffffffff ffff88011b17b9e0 ffffffff8129397a
 ffffffff81add780 ffff88011b17ba30 ffffffff8129401e 0000000000000202
Call Trace:
 [<ffffffff81264718>] dump_stack+0x83/0xc1
 [<ffffffff8129397a>] ubsan_epilogue+0xd/0x3a
 [<ffffffff8129401e>] __ubsan_handle_out_of_bounds+0x54/0x5d
 [<ffffffff812c8192>] acpi_ds_create_operand+0x249/0x2e4
 [<ffffffff812c838d>] acpi_ds_create_operands+0x160/0x1b7
 [<ffffffff812b34d3>] ? acpi_os_release_object+0x9/0xd
 [<ffffffff812eda68>] ? acpi_ut_delete_generic_state+0x18/0x1a
 [<ffffffff812e2b94>] ? acpi_ps_pop_scope+0xde/0x13c
 [<ffffffff812c8c71>] acpi_ds_exec_end_op+0x335/0x57d
 [<ffffffff812e1670>] acpi_ps_parse_loop+0x729/0x78b
 [<ffffffff812ed97b>] ? acpi_ut_create_generic_state+0x34/0x3f
 [<ffffffff812e270c>] acpi_ps_parse_aml+0xa7/0x2d6
 [<ffffffff812e32fb>] acpi_ps_execute_method+0x1f3/0x231
 [<ffffffff812db33f>] acpi_ns_evaluate+0x22e/0x2be
 [<ffffffff812df1e5>] acpi_evaluate_object+0x13c/0x255
 [<ffffffff8117c8e6>] ? kfree+0x1b2/0x1c1
 [<ffffffff812bb50b>] acpi_get_phys_id+0x38/0x11a
 [<ffffffff812bb75f>] acpi_get_cpuid+0xc/0x18
 [<ffffffff81c86f23>] early_init_pdc+0x8d/0xa2
 [<ffffffff812defac>] acpi_ns_walk_namespace+0x11c/0x1ea
 [<ffffffff81c86e96>] ? set_no_mwait+0x3b/0x3b
 [<ffffffff81c86e96>] ? set_no_mwait+0x3b/0x3b
 [<ffffffff812df40d>] acpi_walk_namespace+0x9b/0xd0
 [<ffffffff81c863b4>] ? acpi_sleep_init+0x120/0x120
 [<ffffffff81c86f68>] acpi_early_processor_set_pdc+0x30/0x4a
 [<ffffffff81c86535>] acpi_init+0x181/0x2e5
 [<ffffffff81c863b4>] ? acpi_sleep_init+0x120/0x120
 [<ffffffff810004aa>] do_one_initcall+0xd3/0x164
 [<ffffffff81c5c522>] kernel_init_freeable+0x246/0x2d8
 [<ffffffff81420713>] kernel_init+0xa/0x103
 [<ffffffff8142ed0f>] ret_from_fork+0x1f/0x40
 [<ffffffff81420709>] ? rest_init+0x160/0x160
================================================================================

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Index: linux-2.6/drivers/acpi/acpica/dsutils.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/dsutils.c
+++ linux-2.6/drivers/acpi/acpica/dsutils.c
@@ -637,11 +637,10 @@ acpi_ds_create_operand(struct acpi_walk_
 			ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH,
 					  "Argument previously created, already stacked\n"));
 
-			acpi_db_display_argument_object(walk_state->
-							operands[walk_state->
-								 num_operands -
-								 1],
-							walk_state);
+			if (walk_state->num_operands)
+				acpi_db_display_argument_object(walk_state->
+					operands[walk_state-> num_operands - 1],
+					walk_state);
 
 			/*
 			 * Use value that was already previously returned
