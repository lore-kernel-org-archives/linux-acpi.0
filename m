From: Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH V3] acpi: acpica: fix acpi parse and parseext cache leaks
Date: Fri, 23 Jun 2017 14:08:26 +0900
Message-ID: <1498194506-25595-1-git-send-email-kkamagui@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35799 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754311AbdFWFJs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Jun 2017 01:09:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lv.zheng@intel.com
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, Seunghun Han <kkamagui@gmail.com>

I'm Seunghun Han, and I work for National Security Research Institute of
South Korea.

I have been doing a research on ACPI and found an ACPI cache leak in ACPI
early abort cases.

Boot log of ACPI cache leak is as follows:
[    0.352414] ACPI: Added _OSI(Module Device)
[    0.353182] ACPI: Added _OSI(Processor Device)
[    0.353182] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.353182] ACPI: Added _OSI(Processor Aggregator Device)
[    0.356028] ACPI: Unable to start the ACPI Interpreter
[    0.356799] ACPI Error: Could not remove SCI handler (20170303/evmisc-281)
[    0.360215] kmem_cache_destroy Acpi-State: Slab cache still has objects
[    0.360648] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
4.12.0-rc4-next-20170608+ #10
[    0.361273] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[    0.361873] Call Trace:
[    0.362243]  ? dump_stack+0x5c/0x81
[    0.362591]  ? kmem_cache_destroy+0x1aa/0x1c0
[    0.362944]  ? acpi_sleep_proc_init+0x27/0x27
[    0.363296]  ? acpi_os_delete_cache+0xa/0x10
[    0.363646]  ? acpi_ut_delete_caches+0x6d/0x7b
[    0.364000]  ? acpi_terminate+0xa/0x14
[    0.364000]  ? acpi_init+0x2af/0x34f
[    0.364000]  ? __class_create+0x4c/0x80
[    0.364000]  ? video_setup+0x7f/0x7f
[    0.364000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.364000]  ? do_one_initcall+0x4e/0x1a0
[    0.364000]  ? kernel_init_freeable+0x189/0x20a
[    0.364000]  ? rest_init+0xc0/0xc0
[    0.364000]  ? kernel_init+0xa/0x100
[    0.364000]  ? ret_from_fork+0x25/0x30

I analyzed this memory leak in detail. I found that “Acpi-State” cache and
“Acpi-Parse” cache were merged because the size of cache objects was same
slab cache size.

I finally found “Acpi-Parse” cache and “Acpi-ParseExt” cache were leaked
using SLAB_NEVER_MERGE flag in kmem_cache_create() function.

Real ACPI cache leak point is as follows:
[    0.360101] ACPI: Added _OSI(Module Device)
[    0.360101] ACPI: Added _OSI(Processor Device)
[    0.360101] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.361043] ACPI: Added _OSI(Processor Aggregator Device)
[    0.364016] ACPI: Unable to start the ACPI Interpreter
[    0.365061] ACPI Error: Could not remove SCI handler (20170303/evmisc-281)
[    0.368174] kmem_cache_destroy Acpi-Parse: Slab cache still has objects
[    0.369332] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
4.12.0-rc4-next-20170608+ #8
[    0.371256] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[    0.372000] Call Trace:
[    0.372000]  ? dump_stack+0x5c/0x81
[    0.372000]  ? kmem_cache_destroy+0x1aa/0x1c0
[    0.372000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.372000]  ? acpi_os_delete_cache+0xa/0x10
[    0.372000]  ? acpi_ut_delete_caches+0x56/0x7b
[    0.372000]  ? acpi_terminate+0xa/0x14
[    0.372000]  ? acpi_init+0x2af/0x34f
[    0.372000]  ? __class_create+0x4c/0x80
[    0.372000]  ? video_setup+0x7f/0x7f
[    0.372000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.372000]  ? do_one_initcall+0x4e/0x1a0
[    0.372000]  ? kernel_init_freeable+0x189/0x20a
[    0.372000]  ? rest_init+0xc0/0xc0
[    0.372000]  ? kernel_init+0xa/0x100
[    0.372000]  ? ret_from_fork+0x25/0x30
[    0.388039] kmem_cache_destroy Acpi-ParseExt: Slab cache still has objects
[    0.389063] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
4.12.0-rc4-next-20170608+ #8
[    0.390557] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[    0.392000] Call Trace:
[    0.392000]  ? dump_stack+0x5c/0x81
[    0.392000]  ? kmem_cache_destroy+0x1aa/0x1c0
[    0.392000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.392000]  ? acpi_os_delete_cache+0xa/0x10
[    0.392000]  ? acpi_ut_delete_caches+0x6d/0x7b
[    0.392000]  ? acpi_terminate+0xa/0x14
[    0.392000]  ? acpi_init+0x2af/0x34f
[    0.392000]  ? __class_create+0x4c/0x80
[    0.392000]  ? video_setup+0x7f/0x7f
[    0.392000]  ? acpi_sleep_proc_init+0x27/0x27
[    0.392000]  ? do_one_initcall+0x4e/0x1a0
[    0.392000]  ? kernel_init_freeable+0x189/0x20a
[    0.392000]  ? rest_init+0xc0/0xc0
[    0.392000]  ? kernel_init+0xa/0x100
[    0.392000]  ? ret_from_fork+0x25/0x30

When early abort is occurred due to invalid ACPI information, Linux kernel
terminates ACPI by calling acpi_terminate() function. The function calls
acpi_ut_delete_caches() function to delete local caches (acpi_gbl_namespace_
cache, state_cache, operand_cache, ps_node_cache, ps_node_ext_cache).

But the deletion codes in acpi_ut_delete_caches() function only delete
slab caches using kmem_cache_destroy() function, therefore the cache
objects should be flushed before acpi_ut_delete_caches() function.

“Acpi-Parse” cache and “Acpi-ParseExt” cache are used in an AML parse
function, acpi_ps_parse_loop(). The function should have flush codes to
handle an error state due to invalid AML codes.

This cache leak has a security threat because an old kernel (<= 4.9) shows
memory locations of kernel functions in stack dump. Some malicious users
could use this information to neutralize kernel ASLR.

To fix ACPI cache leak for enhancing security, I made a patch which has
flush codes in acpi_ps_parse_loop() function.

I hope that this patch improves the security of Linux kernel.

Thank you.

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
---
Changes since v2: merge flush code with existing code and change comments.
Changes since v1: move flush code to acpi_ps_complete_final_op() function.

 drivers/acpi/acpica/psobject.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 5bcb618..0a4b565 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -675,11 +675,28 @@ acpi_ps_complete_final_op(struct acpi_walk_state *walk_state,
 
 				else if (ACPI_FAILURE(status)) {
 
-					/* First error is most important */
+					/*
+					 * First error is most important and
+					 * clean up
+					 */
+					do {
+						if (op) {
+							(void)
+							    acpi_ps_complete_this_op
+							    (walk_state, op);
+						}
+
+						acpi_ps_pop_scope(&
+								  (walk_state->
+								   parser_state),
+								  &op,
+								  &walk_state->
+								  arg_types,
+								  &walk_state->
+								  arg_count);
+
+					} while (op);
 
-					(void)
-					    acpi_ps_complete_this_op(walk_state,
-								     op);
 					return_ACPI_STATUS(status);
 				}
 			}
-- 
2.1.4

