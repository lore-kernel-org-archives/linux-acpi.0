From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 1/6] ACPICA: Events: Introduce ACPI_GPE_DISPATCH_RAW_HANDLER to fix 2 issues for the current GPE APIs.
Date: Thu,  5 Feb 2015 16:27:03 +0800
Message-ID: <5a3c2a26e9258c10b15fc2d89c41b25b795fa719.1423123819.git.lv.zheng@intel.com>
References: <cover.1403060601.git.lv.zheng@intel.com> <cover.1423123818.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423123818.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 199cad16530a45aea2bec98e528866e20c5927e1

Since whether the GPE should be disabled/enabled/cleared should only be
determined by the GPE driver's state machine:
1. GPE should be disabled if the driver wants to switch to the GPE polling
   mode when a GPE storm condition is indicated and should be enabled if
   the driver wants to switch back to the GPE interrupt mode when all of
   the storm conditions are cleared. The conditions should be protected by
   the driver's specific lock.
2. GPE should be enabled if the driver has accepted more than one request
   and should be disabled if the driver has completed all of the requests.
   The request count should be protected by the driver's specific lock.
3. GPE should be cleared either when the driver is about to handle an edge
   triggered GPE or when the driver has completed to handle a level
   triggered GPE. The handling code should be protected by the driver's
   specific lock.
Thus the GPE enabling/disabling/clearing operations are likely to be
performed with the driver's specific lock held while we currently cannot do
this. This is because:
1. We have the acpi_gbl_gpe_lock held before invoking the GPE driver's
   handler. Driver's specific lock is likely to be held inside of the
   handler, thus we can see some dead lock issues due to the reversed
   locking order or recursive locking. In order to solve such dead lock
   issues, we need to unlock the acpi_gbl_gpe_lock before invoking the
   handler. BZ 1100.
2. Since GPE disabling/enabling/clearing should be determined by the GPE
   driver's state machine, we shouldn't perform such operations inside of
   ACPICA for a GPE handler to mess up the driver's state machine. BZ 1101.

Originally this patch includes a logic to flush GPE handlers, it is dropped
due to the following reasons:
1. This is a different issue;
2. Linux OSL has fixed this by flushing SCI in acpi_os_wait_events_complete().
We will pick up this topic when the Linux OSL fix turns out to be not
sufficient.

Note that currently the internal operations and the acpi_gbl_gpe_lock are
also used by ACPI_GPE_DISPATCH_METHOD and ACPI_GPE_DISPATCH_NOTIFY. In
order not to introduce regressions, we add one
ACPI_GPE_DISPATCH_RAW_HANDLER type to be distiguished from
ACPI_GPE_DISPATCH_HANDLER. For which the acpi_gbl_gpe_lock is unlocked before
invoking the GPE handler and the internal enabling/disabling operations are
bypassed to allow drivers to perform them at a proper position using the
GPE APIs and ACPI_GPE_DISPATCH_RAW_HANDLER users should invoke acpi_set_gpe()
instead of acpi_enable_gpe()/acpi_disable_gpe() to bypass the internal GPE
clearing code in acpi_enable_gpe(). Lv Zheng.

Known issues:
1. Edge-triggered GPE lost for frequent enablings
   On some buggy silicon platforms, GPE enable line may not be directly
   wired to the GPE trigger line. In that case, when GPE enabling is
   frequently performed for edge-triggered GPEs, GPE status may stay set
   without being triggered.
   This patch may maginify this problem as it allows GPE enabling to be
   parallel performed during the process the GPEs are handled.
   This is an existing issue, because:
   1. For task context:
      Current ACPI_GPE_DISPATCH_METHOD practices have proven that this
      isn't a real issue - we can re-enable edge-triggered GPE in a work
      queue where the GPE status bit might already be set.
   2. For IRQ context:
      This can even happen when the GPE enabling occurs before returning
      from the GPE handler and after unlocking the GPE lock.
   Thus currently no code is included to protect this.

Link: https://github.com/acpica/acpica/commit/199cad16
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evgpe.c     |   52 +++++++++++++++---
 drivers/acpi/acpica/evgpeblk.c  |    2 +
 drivers/acpi/acpica/evgpeinit.c |    6 +-
 drivers/acpi/acpica/evgpeutil.c |    6 +-
 drivers/acpi/acpica/evxface.c   |  115 +++++++++++++++++++++++++++++++++++----
 include/acpi/acpixf.h           |    8 +++
 include/acpi/actypes.h          |   11 ++--
 7 files changed, 171 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 836c79b..5ed064e 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -332,6 +332,7 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list)
 	struct acpi_gpe_register_info *gpe_register_info;
 	struct acpi_gpe_event_info *gpe_event_info;
 	u32 gpe_number;
+	struct acpi_gpe_handler_info *gpe_handler_info;
 	u32 int_status = ACPI_INTERRUPT_NOT_HANDLED;
 	u8 enabled_status_byte;
 	u32 status_reg;
@@ -455,14 +456,49 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list)
 						     acpi_gbl_global_event_handler_context);
 					}
 
-					/*
-					 * Found an active GPE. Dispatch the event to a handler
-					 * or method.
-					 */
-					int_status |=
-					    acpi_ev_gpe_dispatch(gpe_device,
-								 gpe_event_info,
-								 gpe_number);
+					/* Found an active GPE */
+
+					if (ACPI_GPE_DISPATCH_TYPE
+					    (gpe_event_info->flags) ==
+					    ACPI_GPE_DISPATCH_RAW_HANDLER) {
+
+						/* Dispatch the event to a raw handler */
+
+						gpe_handler_info =
+						    gpe_event_info->dispatch.
+						    handler;
+
+						/*
+						 * There is no protection around the namespace node
+						 * and the GPE handler to ensure a safe destruction
+						 * because:
+						 * 1. The namespace node is expected to always
+						 *    exist after loading a table.
+						 * 2. The GPE handler is expected to be flushed by
+						 *    acpi_os_wait_events_complete() before the
+						 *    destruction.
+						 */
+						acpi_os_release_lock
+						    (acpi_gbl_gpe_lock, flags);
+						int_status |=
+						    gpe_handler_info->
+						    address(gpe_device,
+							    gpe_number,
+							    gpe_handler_info->
+							    context);
+						flags =
+						    acpi_os_acquire_lock
+						    (acpi_gbl_gpe_lock);
+					} else {
+						/*
+						 * Dispatch the event to a standard handler or
+						 * method.
+						 */
+						int_status |=
+						    acpi_ev_gpe_dispatch
+						    (gpe_device, gpe_event_info,
+						     gpe_number);
+					}
 				}
 			}
 		}
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index ce2a7cf..e0f24c5 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -478,6 +478,8 @@ acpi_ev_initialize_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 			     ACPI_GPE_DISPATCH_NONE)
 			    || (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
 				ACPI_GPE_DISPATCH_HANDLER)
+			    || (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
+				ACPI_GPE_DISPATCH_RAW_HANDLER)
 			    || (gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
 				continue;
 			}
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 7670508..8840296 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -401,8 +401,10 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
-	    ACPI_GPE_DISPATCH_HANDLER) {
+	if ((ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
+	     ACPI_GPE_DISPATCH_HANDLER) ||
+	    (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
+	     ACPI_GPE_DISPATCH_RAW_HANDLER)) {
 
 		/* If there is already a handler, ignore this GPE method */
 
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index c369b19..3a958f3 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -324,8 +324,10 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 								 ACPI_GPE_REGISTER_WIDTH)
 								+ j];
 
-			if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
-			    ACPI_GPE_DISPATCH_HANDLER) {
+			if ((ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
+			     ACPI_GPE_DISPATCH_HANDLER) ||
+			    (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
+			     ACPI_GPE_DISPATCH_RAW_HANDLER)) {
 
 				/* Delete an installed handler block */
 
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index 6d04ae9..81f2d9e 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -51,6 +51,16 @@
 
 #define _COMPONENT          ACPI_EVENTS
 ACPI_MODULE_NAME("evxface")
+#if (!ACPI_REDUCED_HARDWARE)
+/* Local prototypes */
+static acpi_status
+acpi_ev_install_gpe_handler(acpi_handle gpe_device,
+			    u32 gpe_number,
+			    u32 type,
+			    u8 is_raw_handler,
+			    acpi_gpe_handler address, void *context);
+
+#endif
 
 
 /*******************************************************************************
@@ -76,6 +86,7 @@ ACPI_MODULE_NAME("evxface")
  *              handlers.
  *
  ******************************************************************************/
+
 acpi_status
 acpi_install_notify_handler(acpi_handle device,
 			    u32 handler_type,
@@ -717,32 +728,37 @@ ACPI_EXPORT_SYMBOL(acpi_remove_fixed_event_handler)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_install_gpe_handler
+ * FUNCTION:    acpi_ev_install_gpe_handler
  *
  * PARAMETERS:  gpe_device      - Namespace node for the GPE (NULL for FADT
  *                                defined GPEs)
  *              gpe_number      - The GPE number within the GPE block
  *              type            - Whether this GPE should be treated as an
  *                                edge- or level-triggered interrupt.
+ *              is_raw_handler  - Whether this GPE should be handled using
+ *                                the special GPE handler mode.
  *              address         - Address of the handler
  *              context         - Value passed to the handler on each GPE
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Install a handler for a General Purpose Event.
+ * DESCRIPTION: Internal function to install a handler for a General Purpose
+ *              Event.
  *
  ******************************************************************************/
-acpi_status
-acpi_install_gpe_handler(acpi_handle gpe_device,
-			 u32 gpe_number,
-			 u32 type, acpi_gpe_handler address, void *context)
+static acpi_status
+acpi_ev_install_gpe_handler(acpi_handle gpe_device,
+			    u32 gpe_number,
+			    u32 type,
+			    u8 is_raw_handler,
+			    acpi_gpe_handler address, void *context)
 {
 	struct acpi_gpe_event_info *gpe_event_info;
 	struct acpi_gpe_handler_info *handler;
 	acpi_status status;
 	acpi_cpu_flags flags;
 
-	ACPI_FUNCTION_TRACE(acpi_install_gpe_handler);
+	ACPI_FUNCTION_TRACE(ev_install_gpe_handler);
 
 	/* Parameter validation */
 
@@ -775,8 +791,10 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 
 	/* Make sure that there isn't a handler there already */
 
-	if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
-	    ACPI_GPE_DISPATCH_HANDLER) {
+	if ((ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
+	     ACPI_GPE_DISPATCH_HANDLER) ||
+	    (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
+	     ACPI_GPE_DISPATCH_RAW_HANDLER)) {
 		status = AE_ALREADY_EXISTS;
 		goto free_and_exit;
 	}
@@ -817,7 +835,10 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 
 	gpe_event_info->flags &=
 	    ~(ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK);
-	gpe_event_info->flags |= (u8)(type | ACPI_GPE_DISPATCH_HANDLER);
+	gpe_event_info->flags |=
+	    (u8)(type |
+		 (is_raw_handler ? ACPI_GPE_DISPATCH_RAW_HANDLER :
+		  ACPI_GPE_DISPATCH_HANDLER));
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 
@@ -831,10 +852,78 @@ free_and_exit:
 	goto unlock_and_exit;
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_install_gpe_handler
+ *
+ * PARAMETERS:  gpe_device      - Namespace node for the GPE (NULL for FADT
+ *                                defined GPEs)
+ *              gpe_number      - The GPE number within the GPE block
+ *              type            - Whether this GPE should be treated as an
+ *                                edge- or level-triggered interrupt.
+ *              address         - Address of the handler
+ *              context         - Value passed to the handler on each GPE
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install a handler for a General Purpose Event.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_install_gpe_handler(acpi_handle gpe_device,
+			 u32 gpe_number,
+			 u32 type, acpi_gpe_handler address, void *context)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_install_gpe_handler);
+
+	status =
+	    acpi_ev_install_gpe_handler(gpe_device, gpe_number, type, FALSE,
+					address, context);
+
+	return_ACPI_STATUS(status);
+}
+
 ACPI_EXPORT_SYMBOL(acpi_install_gpe_handler)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_install_gpe_raw_handler
+ *
+ * PARAMETERS:  gpe_device      - Namespace node for the GPE (NULL for FADT
+ *                                defined GPEs)
+ *              gpe_number      - The GPE number within the GPE block
+ *              type            - Whether this GPE should be treated as an
+ *                                edge- or level-triggered interrupt.
+ *              address         - Address of the handler
+ *              context         - Value passed to the handler on each GPE
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Install a handler for a General Purpose Event.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_install_gpe_raw_handler(acpi_handle gpe_device,
+			     u32 gpe_number,
+			     u32 type, acpi_gpe_handler address, void *context)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_install_gpe_raw_handler);
+
+	status = acpi_ev_install_gpe_handler(gpe_device, gpe_number, type, TRUE,
+					     address, context);
+
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_install_gpe_raw_handler)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_remove_gpe_handler
  *
  * PARAMETERS:  gpe_device      - Namespace node for the GPE (NULL for FADT
@@ -881,8 +970,10 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 
 	/* Make sure that a handler is indeed installed */
 
-	if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
-	    ACPI_GPE_DISPATCH_HANDLER) {
+	if ((ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
+	     ACPI_GPE_DISPATCH_HANDLER) &&
+	    (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
+	     ACPI_GPE_DISPATCH_RAW_HANDLER)) {
 		status = AE_NOT_EXIST;
 		goto unlock_and_exit;
 	}
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 96e4ef3..d56f5d7 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -569,6 +569,14 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 							  address,
 							  void *context))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				 acpi_install_gpe_raw_handler(acpi_handle
+							      gpe_device,
+							      u32 gpe_number,
+							      u32 type,
+							      acpi_gpe_handler
+							      address,
+							      void *context))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				 acpi_remove_gpe_handler(acpi_handle gpe_device,
 							 u32 gpe_number,
 							 acpi_gpe_handler
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 453cebb..b034f10 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -744,7 +744,7 @@ typedef u32 acpi_event_status;
 /*
  * GPE info flags - Per GPE
  * +-------+-+-+---+
- * |  7:4  |3|2|1:0|
+ * |  7:5  |4|3|2:0|
  * +-------+-+-+---+
  *     |    | |  |
  *     |    | |  +-- Type of dispatch:to method, handler, notify, or none
@@ -756,14 +756,15 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_DISPATCH_METHOD        (u8) 0x01
 #define ACPI_GPE_DISPATCH_HANDLER       (u8) 0x02
 #define ACPI_GPE_DISPATCH_NOTIFY        (u8) 0x03
-#define ACPI_GPE_DISPATCH_MASK          (u8) 0x03
+#define ACPI_GPE_DISPATCH_RAW_HANDLER   (u8) 0x04
+#define ACPI_GPE_DISPATCH_MASK          (u8) 0x07
 #define ACPI_GPE_DISPATCH_TYPE(flags)   ((u8) ((flags) & ACPI_GPE_DISPATCH_MASK))
 
-#define ACPI_GPE_LEVEL_TRIGGERED        (u8) 0x04
+#define ACPI_GPE_LEVEL_TRIGGERED        (u8) 0x08
 #define ACPI_GPE_EDGE_TRIGGERED         (u8) 0x00
-#define ACPI_GPE_XRUPT_TYPE_MASK        (u8) 0x04
+#define ACPI_GPE_XRUPT_TYPE_MASK        (u8) 0x08
 
-#define ACPI_GPE_CAN_WAKE               (u8) 0x08
+#define ACPI_GPE_CAN_WAKE               (u8) 0x10
 
 /*
  * Flags for GPE and Lock interfaces
-- 
1.7.10
