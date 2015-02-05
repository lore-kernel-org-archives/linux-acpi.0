From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/10] ACPICA: Events: Cleanup to move acpi_gbl_global_event_handler invocation out of acpi_ev_gpe_dispatch().
Date: Thu,  5 Feb 2015 15:20:22 +0800
Message-ID: <bc03ba68716daf6821ca06d2804816d315b83cc1.1423119574.git.lv.zheng@intel.com>
References: <cover.1423119574.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423119574.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 04f25acdd4f655ae33f83de789bb5f4b7790171c

This patch follows acpi_ev_fixed_event_detect(), which invokes
acpi_gbl_global_event_handler instead of invoking it in
acpi_ev_fixed_event_dispatch(), moves acpi_gbl_global_event_handler from
acpi_ev_gpe_dispatch() to acpi_ev_gpe_detect(). This makes further cleanups
around acpi_ev_gpe_dispatch() simpler. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/04f25acd
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evgpe.c |   39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index d8b919a..4a4f41a 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -328,7 +328,10 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list)
 {
 	acpi_status status;
 	struct acpi_gpe_block_info *gpe_block;
+	struct acpi_namespace_node *gpe_device;
 	struct acpi_gpe_register_info *gpe_register_info;
+	struct acpi_gpe_event_info *gpe_event_info;
+	u32 gpe_number;
 	u32 int_status = ACPI_INTERRUPT_NOT_HANDLED;
 	u8 enabled_status_byte;
 	u32 status_reg;
@@ -356,6 +359,8 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list)
 
 	gpe_block = gpe_xrupt_list->gpe_block_list_head;
 	while (gpe_block) {
+		gpe_device = gpe_block->node;
+
 		/*
 		 * Read all of the 8-bit GPE status and enable registers in this GPE
 		 * block, saving all of them. Find all currently active GP events.
@@ -431,16 +436,33 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list)
 
 				/* Examine one GPE bit */
 
+				gpe_event_info =
+				    &gpe_block->
+				    event_info[((acpi_size) i *
+						ACPI_GPE_REGISTER_WIDTH) + j];
+				gpe_number =
+				    j + gpe_register_info->base_gpe_number;
+
 				if (enabled_status_byte & (1 << j)) {
+
+					/* Invoke global event handler if present */
+
+					acpi_gpe_count++;
+					if (acpi_gbl_global_event_handler) {
+						acpi_gbl_global_event_handler
+						    (ACPI_EVENT_TYPE_GPE,
+						     gpe_device, gpe_number,
+						     acpi_gbl_global_event_handler_context);
+					}
+
 					/*
 					 * Found an active GPE. Dispatch the event to a handler
 					 * or method.
 					 */
 					int_status |=
-					    acpi_ev_gpe_dispatch(gpe_block->
-								 node,
-								 &gpe_block->
-								 event_info[((acpi_size) i * ACPI_GPE_REGISTER_WIDTH) + j], j + gpe_register_info->base_gpe_number);
+					    acpi_ev_gpe_dispatch(gpe_device,
+								 gpe_event_info,
+								 gpe_number);
 				}
 			}
 		}
@@ -645,15 +667,6 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 
 	ACPI_FUNCTION_TRACE(ev_gpe_dispatch);
 
-	/* Invoke global event handler if present */
-
-	acpi_gpe_count++;
-	if (acpi_gbl_global_event_handler) {
-		acpi_gbl_global_event_handler(ACPI_EVENT_TYPE_GPE, gpe_device,
-					      gpe_number,
-					      acpi_gbl_global_event_handler_context);
-	}
-
 	/*
 	 * Always disable the GPE so that it does not keep firing before
 	 * any asynchronous activity completes (either from the execution
-- 
1.7.10
