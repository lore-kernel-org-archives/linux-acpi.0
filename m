From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/9] ACPICA: New GPE handler callback definition
Date: Wed, 12 Jan 2011 04:38:04 -0500
Message-ID: <8b6cd8ad18def34bfc5045b2a0234329bf94cf78.1294824789.git.len.brown@intel.com>
References: <1294825090-21150-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:33451 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab1ALJiY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 04:38:24 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEW009A1LFYIW11@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 03:38:24 -0600 (CST)
In-reply-to: <1294825090-21150-1-git-send-email-lenb@kernel.org>
In-reply-to: <3cfd53d53f700a225716294842b1a843326dea21.1294824789.git.len.brown@intel.com>
References: <3cfd53d53f700a225716294842b1a843326dea21.1294824789.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

The new GPE handler callback has 2 additional parameters, gpe_device and
gpe_number.

typedef
u32 (*acpi_gpe_handler) (acpi_handle gpe_device, u32 gpe_number, void *context);

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acevents.h   |    3 ++-
 drivers/acpi/acpica/aclocal.h    |    6 +++---
 drivers/acpi/acpica/evgpe.c      |   14 ++++++++++----
 drivers/acpi/acpica/evxface.c    |   10 +++++-----
 drivers/acpi/ec.c                |    3 ++-
 drivers/char/ipmi/ipmi_si_intf.c |    3 ++-
 include/acpi/acpixf.h            |    4 ++--
 include/acpi/actypes.h           |    3 +++
 8 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index ce2af07..ebb467f 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -112,7 +112,8 @@ acpi_ev_initialize_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 acpi_status acpi_ev_delete_gpe_block(struct acpi_gpe_block_info *gpe_block);
 
 u32
-acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info,
+acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
+		     struct acpi_gpe_event_info *gpe_event_info,
 		     u32 gpe_number);
 
 /*
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 2f841d0..6a71f8e 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -408,8 +408,8 @@ struct acpi_predefined_data {
 
 /* Dispatch info for each GPE -- either a method or handler, cannot be both */
 
-struct acpi_handler_info {
-	acpi_event_handler address;	/* Address of handler, if any */
+struct acpi_gpe_handler_info {
+	acpi_gpe_handler address;	/* Address of handler, if any */
 	void *context;		/* Context to be passed to handler */
 	struct acpi_namespace_node *method_node;	/* Method node for this GPE level (saved) */
 	u8 original_flags;      /* Original (pre-handler) GPE info */
@@ -418,7 +418,7 @@ struct acpi_handler_info {
 
 union acpi_gpe_dispatch_info {
 	struct acpi_namespace_node *method_node;	/* Method node for this GPE level */
-	struct acpi_handler_info *handler;  /* Installed GPE handler */
+	struct acpi_gpe_handler_info *handler;  /* Installed GPE handler */
 };
 
 /*
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 005c170..3fb621e 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -409,7 +409,9 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 					 * or method.
 					 */
 					int_status |=
-					    acpi_ev_gpe_dispatch(&gpe_block->
+					    acpi_ev_gpe_dispatch(gpe_block->
+								 node,
+								 &gpe_block->
 						event_info[((acpi_size) i * ACPI_GPE_REGISTER_WIDTH) + j], j + gpe_register_info->base_gpe_number);
 				}
 			}
@@ -542,7 +544,8 @@ static void acpi_ev_asynch_enable_gpe(void *context)
  *
  * FUNCTION:    acpi_ev_gpe_dispatch
  *
- * PARAMETERS:  gpe_event_info  - Info for this GPE
+ * PARAMETERS:  gpe_device      - Device node. NULL for GPE0/GPE1
+ *              gpe_event_info  - Info for this GPE
  *              gpe_number      - Number relative to the parent GPE block
  *
  * RETURN:      INTERRUPT_HANDLED or INTERRUPT_NOT_HANDLED
@@ -555,7 +558,8 @@ static void acpi_ev_asynch_enable_gpe(void *context)
  ******************************************************************************/
 
 u32
-acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
+acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
+		    struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 {
 	acpi_status status;
 
@@ -593,7 +597,9 @@ acpi_ev_gpe_dispatch(struct acpi_gpe_event_info *gpe_event_info, u32 gpe_number)
 		 * Ignore return status for now.
 		 * TBD: leave GPE disabled on error?
 		 */
-		(void)gpe_event_info->dispatch.handler->address(gpe_event_info->
+		(void)gpe_event_info->dispatch.handler->address(gpe_device,
+								gpe_number,
+								gpe_event_info->
 								dispatch.
 								handler->
 								context);
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 042a6d6..d193b90 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -671,10 +671,10 @@ ACPI_EXPORT_SYMBOL(acpi_remove_notify_handler)
 acpi_status
 acpi_install_gpe_handler(acpi_handle gpe_device,
 			 u32 gpe_number,
-			 u32 type, acpi_event_handler address, void *context)
+			 u32 type, acpi_gpe_handler address, void *context)
 {
 	struct acpi_gpe_event_info *gpe_event_info;
-	struct acpi_handler_info *handler;
+	struct acpi_gpe_handler_info *handler;
 	acpi_status status;
 	acpi_cpu_flags flags;
 
@@ -693,7 +693,7 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 
 	/* Allocate memory for the handler object */
 
-	handler = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_handler_info));
+	handler = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_gpe_handler_info));
 	if (!handler) {
 		status = AE_NO_MEMORY;
 		goto unlock_and_exit;
@@ -777,10 +777,10 @@ ACPI_EXPORT_SYMBOL(acpi_install_gpe_handler)
  ******************************************************************************/
 acpi_status
 acpi_remove_gpe_handler(acpi_handle gpe_device,
-			u32 gpe_number, acpi_event_handler address)
+			u32 gpe_number, acpi_gpe_handler address)
 {
 	struct acpi_gpe_event_info *gpe_event_info;
-	struct acpi_handler_info *handler;
+	struct acpi_gpe_handler_info *handler;
 	acpi_status status;
 	acpi_cpu_flags flags;
 
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 302b31e..8188772 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -606,7 +606,8 @@ static int ec_check_sci(struct acpi_ec *ec, u8 state)
 	return 0;
 }
 
-static u32 acpi_ec_gpe_handler(void *data)
+static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
+	u32 gpe_number, void *data)
 {
 	struct acpi_ec *ec = data;
 
diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 035da9e..c4bacc6 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1928,7 +1928,8 @@ static void __devinit hardcode_find_bmc(void)
 static int acpi_failure;
 
 /* For GPE-type interrupts. */
-static u32 ipmi_acpi_gpe(void *context)
+static u32 ipmi_acpi_gpe(acpi_handle gpe_device,
+	u32 gpe_number, void *context)
 {
 	struct smi_info *smi_info = context;
 	unsigned long   flags;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 5f8ccf1..b806e56 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -258,11 +258,11 @@ acpi_remove_address_space_handler(acpi_handle device,
 acpi_status
 acpi_install_gpe_handler(acpi_handle gpe_device,
 			 u32 gpe_number,
-			 u32 type, acpi_event_handler address, void *context);
+			 u32 type, acpi_gpe_handler address, void *context);
 
 acpi_status
 acpi_remove_gpe_handler(acpi_handle gpe_device,
-			u32 gpe_number, acpi_event_handler address);
+			u32 gpe_number, acpi_gpe_handler address);
 
 #ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_install_exception_handler(acpi_exception_handler handler);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index e738939..b9575ad 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -897,6 +897,9 @@ typedef void
 typedef u32(*acpi_event_handler) (void *context);
 
 typedef
+u32 (*acpi_gpe_handler) (acpi_handle gpe_device, u32 gpe_number, void *context);
+
+typedef
 void (*acpi_notify_handler) (acpi_handle device, u32 value, void *context);
 
 typedef
-- 
1.7.4.rc1.7.g2cf08

