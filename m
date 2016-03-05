From: Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: [PATCH] ACPICA: Events: Execute some _REG methods in early boot
Date: Sat,  5 Mar 2016 15:11:55 +0000
Message-ID: <1457190715-5851-1-git-send-email-chris.bainbridge@gmail.com>
References: <20160227190828.GA4751@localhost>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34267 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbcCEPQa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Mar 2016 10:16:30 -0500
In-Reply-To: <20160227190828.GA4751@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lv.zheng@intel.com
Cc: Chris Bainbridge <chris.bainbridge@gmail.com>, robert.moore@intel.com, rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

The regression caused _REG methods to not be run in early boot for all
space IDs, but a removed comment stated that _REG methods should be
executed for IDs like embedded_controller. Before the regression this
was the case:

[    0.230469] Executing  Method       \_SB.PCI0.LPCB.EC._REG
[    0.230531] Initializing Region       \GNVS
[    0.230607] Initializing Region       \_SB.PCI0.LPCB.EC.ECOR
[    0.231043] Initializing Region       \_SB.PCI0.IGPU.IGDM

After the regression the initialisation is not done and ODEBUG warnings
are shown at boot and/or shutdown:

[    6.676570] WARNING: CPU: 0 PID: 3317 at lib/debugobjects.c:263 debug_print_object+0x85/0xa0()
[    6.676576] ODEBUG: assert_init not available (active state 0) object type: timer_list hint: stub_timer+0x0/0x20
[    6.676578] Modules linked in:
[    6.676582] CPU: 0 PID: 3317 Comm: ccpd Not tainted 4.5.0-rc6 #509
[    6.676584] Hardware name: Apple Inc. MacBookPro10,2/Mac-AFD8A9D944EA4843, BIOS MBP102.88Z.0106.B0A.1509130955 09/13/2015
[    6.676586]  0000000000000000 ffff880256543db0 ffffffff814802b5 ffff880256543df8
[    6.676590]  ffffffff81f40dbd ffff880256543de8 ffffffff810bd0ec ffff880256543e90
[    6.676594]  ffffffff822532c0 ffffffff81f40e63 ffffffff83138c88 0000000001fdf040
[    6.676598] Call Trace:
[    6.676603]  [<ffffffff814802b5>] dump_stack+0x67/0x92
[    6.676608]  [<ffffffff810bd0ec>] warn_slowpath_common+0x7c/0xb0
[    6.676611]  [<ffffffff810bd167>] warn_slowpath_fmt+0x47/0x50
[    6.676614]  [<ffffffff8149d7a5>] debug_print_object+0x85/0xa0
[    6.676616]  [<ffffffff8111f440>] ? cascade+0x70/0x70
[    6.676620]  [<ffffffff8149e398>] debug_object_assert_init+0xf8/0x130
[    6.676624]  [<ffffffff811038cd>] ? trace_hardirqs_on+0xd/0x10
[    6.676626]  [<ffffffff8111fcff>] del_timer+0x1f/0x70
[    6.676631]  [<ffffffff811852f1>] laptop_sync_completion+0x61/0x100
[    6.676633]  [<ffffffff81185290>] ? laptop_io_completion+0x30/0x30
[    6.676637]  [<ffffffff81212c9f>] sys_sync+0x7f/0x90
[    6.676641]  [<ffffffff81ad0d97>] entry_SYSCALL_64_fastpath+0x12/0x6f

Fixes: efaed9be998b ("ACPICA: Events: Enhance acpi_ev_execute_reg_method() to ensure no _REG evaluations can happen during OS early boot stages")
Link: https://lkml.org/lkml/2016/2/3/273
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=112911
Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
---
 drivers/acpi/acpica/evregion.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 47092b4d633c..d0b02ef0effa 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -590,6 +590,7 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 	union acpi_operand_object *args[3];
 	union acpi_operand_object *region_obj2;
 	acpi_status status;
+	bool sp;
 
 	ACPI_FUNCTION_TRACE(ev_execute_reg_method);
 
@@ -598,9 +599,28 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
+	/*
+	 * For the default space_IDs, (the IDs for which there are default region handlers
+	 * installed) Only execute the _REG methods if the global initialization _REG
+	 * methods have already been run (via acpi_initialize_objects). In other words,
+	 * we will defer the execution of the _REG methods for these space_IDs until
+	 * execution of acpi_initialize_objects. This is done because we need the handlers
+	 * for the default spaces (mem/io/pci/table) to be installed before we can run
+	 * any control methods (or _REG methods). There is known BIOS code that depends
+	 * on this.
+	 *
+	 * For all other space_IDs, we can safely execute the _REG methods immediately.
+	 * This means that for IDs like embedded_controller, this function should be called
+	 * only after acpi_enable_subsystem has been called.
+	 */
+
+	sp = (region_obj->region.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY ||
+	      region_obj->region.space_id == ACPI_ADR_SPACE_SYSTEM_IO ||
+	      region_obj->region.space_id == ACPI_ADR_SPACE_PCI_CONFIG ||
+	      region_obj->region.space_id == ACPI_ADR_SPACE_DATA_TABLE);
 	if (region_obj2->extra.method_REG == NULL ||
 	    region_obj->region.handler == NULL ||
-	    !acpi_gbl_reg_methods_enabled) {
+	    (sp && !acpi_gbl_reg_methods_enabled)) {
 		return_ACPI_STATUS(AE_OK);
 	}
 
-- 
2.1.4

