From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/15] ACPICA: Namespace: fix operand cache leak
Date: Wed, 26 Apr 2017 16:18:08 +0800
Message-ID: <6584657e196b2259f3978f2598829bc22a0e22b1.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:42041 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1952688AbdDZISO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:18:14 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Seunghun Han <kkamagui@gmail.com>

From: Seunghun Han <kkamagui@gmail.com>

ACPICA commit a23325b2e583556eae88ed3f764e457786bf4df6

I found some ACPI operand cache leaks in ACPI early abort cases.

Boot log of ACPI operand cache leak is as follows:
>[    0.174332] ACPI: Added _OSI(Module Device)
>[    0.175504] ACPI: Added _OSI(Processor Device)
>[    0.176010] ACPI: Added _OSI(3.0 _SCP Extensions)
>[    0.177032] ACPI: Added _OSI(Processor Aggregator Device)
>[    0.178284] ACPI: SCI (IRQ16705) allocation failed
>[    0.179352] ACPI Exception: AE_NOT_ACQUIRED, Unable to install
System Control Interrupt handler (20160930/evevent-131)
>[    0.180008] ACPI: Unable to start the ACPI Interpreter
>[    0.181125] ACPI Error: Could not remove SCI handler
(20160930/evmisc-281)
>[    0.184068] kmem_cache_destroy Acpi-Operand: Slab cache still has
objects
>[    0.185358] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.10.0-rc3 #2
>[    0.186820] Hardware name: innotek gmb_h virtual_box/virtual_box, BIOS
virtual_box 12/01/2006
>[    0.188000] Call Trace:
>[    0.188000]  ? dump_stack+0x5c/0x7d
>[    0.188000]  ? kmem_cache_destroy+0x224/0x230
>[    0.188000]  ? acpi_sleep_proc_init+0x22/0x22
>[    0.188000]  ? acpi_os_delete_cache+0xa/0xd
>[    0.188000]  ? acpi_ut_delete_caches+0x3f/0x7b
>[    0.188000]  ? acpi_terminate+0x5/0xf
>[    0.188000]  ? acpi_init+0x288/0x32e
>[    0.188000]  ? __class_create+0x4c/0x80
>[    0.188000]  ? video_setup+0x7a/0x7a
>[    0.188000]  ? do_one_initcall+0x4e/0x1b0
>[    0.188000]  ? kernel_init_freeable+0x194/0x21a
>[    0.188000]  ? rest_init+0x80/0x80
>[    0.188000]  ? kernel_init+0xa/0x100
>[    0.188000]  ? ret_from_fork+0x25/0x30

When early abort is occurred due to invalid ACPI information, Linux kernel
terminates ACPI by calling acpi_terminate() function. The function calls
acpi_ns_terminate() function to delete namespace data and ACPI operand cache
(acpi_gbl_module_code_list).

But the deletion code in acpi_ns_terminate() function is wrapped in
ACPI_EXEC_APP definition, therefore the code is only executed when the
definition exists. If the define doesn't exist, ACPI operand cache
(acpi_gbl_module_code_list) is leaked, and stack dump is shown in kernel log.

This causes a security threat because the old kernel (<= 4.9) shows memory
locations of kernel functions in stack dump, therefore kernel ASLR can be
neutralized.

To fix ACPI operand leak for enhancing security, I made a patch which
removes the ACPI_EXEC_APP define in acpi_ns_terminate() function for
executing the deletion code unconditionally.

Link: https://github.com/acpica/acpica/commit/a23325b2
Signed-off-by: Seunghun Han <kkamagui@gmail.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nsutils.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpica/nsutils.c b/drivers/acpi/acpica/nsutils.c
index 6616767..b5a2914 100644
--- a/drivers/acpi/acpica/nsutils.c
+++ b/drivers/acpi/acpica/nsutils.c
@@ -594,25 +594,20 @@ struct acpi_namespace_node *acpi_ns_validate_handle(acpi_handle handle)
 void acpi_ns_terminate(void)
 {
 	acpi_status status;
+	union acpi_operand_object *prev;
+	union acpi_operand_object *next;
 
 	ACPI_FUNCTION_TRACE(ns_terminate);
 
-#ifdef ACPI_EXEC_APP
-	{
-		union acpi_operand_object *prev;
-		union acpi_operand_object *next;
+	/* Delete any module-level code blocks */
 
-		/* Delete any module-level code blocks */
-
-		next = acpi_gbl_module_code_list;
-		while (next) {
-			prev = next;
-			next = next->method.mutex;
-			prev->method.mutex = NULL;	/* Clear the Mutex (cheated) field */
-			acpi_ut_remove_reference(prev);
-		}
+	next = acpi_gbl_module_code_list;
+	while (next) {
+		prev = next;
+		next = next->method.mutex;
+		prev->method.mutex = NULL;	/* Clear the Mutex (cheated) field */
+		acpi_ut_remove_reference(prev);
 	}
-#endif
 
 	/*
 	 * Free the entire namespace -- all nodes and all objects
-- 
2.7.4

