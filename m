From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/10] ACPICA: Events: Cleanup GPE dispatcher type obtaining code.
Date: Thu,  5 Feb 2015 15:20:29 +0800
Message-ID: <fad915e1c1232f2cbbe19bf30506434a1bcf4102.1423119574.git.lv.zheng@intel.com>
References: <cover.1423119574.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1423119574.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 7926d5ca9452c87f866938dcea8f12e1efb58f89

There is an issue in acpi_install_gpe_handler() and acpi_remove_gpe_handler().
The code to obtain the GPE dispatcher type from the Handler->original_flags
is wrong:
    if (((Handler->original_flags & ACPI_GPE_DISPATCH_METHOD) ||
         (Handler->original_flags & ACPI_GPE_DISPATCH_NOTIFY)) &&
ACPI_GPE_DISPATCH_NOTIFY is 0x03 and ACPI_GPE_DISPATCH_METHOD is 0x02, thus
this statement is TRUE for the following dispatcher types:
    0x01 (ACPI_GPE_DISPATCH_HANDLER): not expected
    0x02 (ACPI_GPE_DISPATCH_METHOD): expected
    0x03 (ACPI_GPE_DISPATCH_NOTIFY): expected

There is no functional issue due to this because Handler->original_flags is
only set in acpi_install_gpe_handler(), and an earlier checker has excluded
the ACPI_GPE_DISPATCH_HANDLER:
    if ((gpe_event_info->Flags & ACPI_GPE_DISPATCH_MASK) ==
            ACPI_GPE_DISPATCH_HANDLER)
    {
        Status = AE_ALREADY_EXISTS;
        goto free_and_exit;
    }
    ...
    Handler->original_flags = (u8) (gpe_event_info->Flags &
        (ACPI_GPE_XRUPT_TYPE_MASK | ACPI_GPE_DISPATCH_MASK));

We need to clean this up before modifying the GPE dispatcher type values.

In order to prevent such issue from happening in the future, this patch
introduces ACPI_GPE_DISPATCH_TYPE() macro to be used to obtain the GPE
dispatcher types. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/7926d5ca
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evgpe.c     |    4 ++--
 drivers/acpi/acpica/evgpeblk.c  |    6 +++---
 drivers/acpi/acpica/evgpeinit.c |    4 ++--
 drivers/acpi/acpica/evgpeutil.c |    8 +++-----
 drivers/acpi/acpica/evxface.c   |   18 ++++++++++--------
 drivers/acpi/acpica/evxfgpe.c   |    6 +++---
 drivers/acpi/acpica/hwgpe.c     |    2 +-
 include/acpi/actypes.h          |    1 +
 8 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 4a4f41a..fccdfb2 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -503,7 +503,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 
 	/* Do the correct dispatch - normal method or implicit notify */
 
-	switch (gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) {
+	switch (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags)) {
 	case ACPI_GPE_DISPATCH_NOTIFY:
 		/*
 		 * Implicit notify.
@@ -707,7 +707,7 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 	 * If there is neither a handler nor a method, leave the GPE
 	 * disabled.
 	 */
-	switch (gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) {
+	switch (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags)) {
 	case ACPI_GPE_DISPATCH_HANDLER:
 
 		/* Invoke the installed handler (at interrupt level) */
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index d86699e..d0a6024 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -474,10 +474,10 @@ acpi_ev_initialize_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 			 * Ignore GPEs that have no corresponding _Lxx/_Exx method
 			 * and GPEs that are used to wake the system
 			 */
-			if (((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+			if ((ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
 			     ACPI_GPE_DISPATCH_NONE)
-			    || ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)
-				== ACPI_GPE_DISPATCH_HANDLER)
+			    || (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
+				ACPI_GPE_DISPATCH_HANDLER)
 			    || (gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
 				continue;
 			}
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 7be9283..ebfd40d 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -401,7 +401,7 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+	if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
 	    ACPI_GPE_DISPATCH_HANDLER) {
 
 		/* If there is already a handler, ignore this GPE method */
@@ -409,7 +409,7 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 		return_ACPI_STATUS(AE_OK);
 	}
 
-	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+	if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
 	    ACPI_GPE_DISPATCH_METHOD) {
 		/*
 		 * If there is already a method, ignore this method. But check
diff --git a/drivers/acpi/acpica/evgpeutil.c b/drivers/acpi/acpica/evgpeutil.c
index 3f1c5aa..b197812 100644
--- a/drivers/acpi/acpica/evgpeutil.c
+++ b/drivers/acpi/acpica/evgpeutil.c
@@ -324,7 +324,7 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 								 ACPI_GPE_REGISTER_WIDTH)
 								+ j];
 
-			if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+			if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
 			    ACPI_GPE_DISPATCH_HANDLER) {
 
 				/* Delete an installed handler block */
@@ -333,10 +333,8 @@ acpi_ev_delete_gpe_handlers(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 				gpe_event_info->dispatch.handler = NULL;
 				gpe_event_info->flags &=
 				    ~ACPI_GPE_DISPATCH_MASK;
-			} else
-			    if ((gpe_event_info->
-				 flags & ACPI_GPE_DISPATCH_MASK) ==
-				ACPI_GPE_DISPATCH_NOTIFY) {
+			} else if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags)
+				   == ACPI_GPE_DISPATCH_NOTIFY) {
 
 				/* Delete the implicit notification device list */
 
diff --git a/drivers/acpi/acpica/evxface.c b/drivers/acpi/acpica/evxface.c
index b6b0c23..61b0261 100644
--- a/drivers/acpi/acpica/evxface.c
+++ b/drivers/acpi/acpica/evxface.c
@@ -775,7 +775,7 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 
 	/* Make sure that there isn't a handler there already */
 
-	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+	if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
 	    ACPI_GPE_DISPATCH_HANDLER) {
 		status = AE_ALREADY_EXISTS;
 		goto free_and_exit;
@@ -793,9 +793,10 @@ acpi_install_gpe_handler(acpi_handle gpe_device,
 	 * automatically during initialization, in which case it has to be
 	 * disabled now to avoid spurious execution of the handler.
 	 */
-	if (((handler->original_flags & ACPI_GPE_DISPATCH_METHOD) ||
-	     (handler->original_flags & ACPI_GPE_DISPATCH_NOTIFY)) &&
-	    gpe_event_info->runtime_count) {
+	if (((ACPI_GPE_DISPATCH_TYPE(handler->original_flags) ==
+	      ACPI_GPE_DISPATCH_METHOD) ||
+	     (ACPI_GPE_DISPATCH_TYPE(handler->original_flags) ==
+	      ACPI_GPE_DISPATCH_NOTIFY)) && gpe_event_info->runtime_count) {
 		handler->originally_enabled = TRUE;
 		(void)acpi_ev_remove_gpe_reference(gpe_event_info);
 
@@ -880,7 +881,7 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 
 	/* Make sure that a handler is indeed installed */
 
-	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) !=
+	if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
 	    ACPI_GPE_DISPATCH_HANDLER) {
 		status = AE_NOT_EXIST;
 		goto unlock_and_exit;
@@ -910,9 +911,10 @@ acpi_remove_gpe_handler(acpi_handle gpe_device,
 	 * enabled, it should be enabled at this point to restore the
 	 * post-initialization configuration.
 	 */
-	if (((handler->original_flags & ACPI_GPE_DISPATCH_METHOD) ||
-	     (handler->original_flags & ACPI_GPE_DISPATCH_NOTIFY)) &&
-	    handler->originally_enabled) {
+	if (((ACPI_GPE_DISPATCH_TYPE(handler->original_flags) ==
+	      ACPI_GPE_DISPATCH_METHOD) ||
+	     (ACPI_GPE_DISPATCH_TYPE(handler->original_flags) ==
+	      ACPI_GPE_DISPATCH_NOTIFY)) && handler->originally_enabled) {
 		(void)acpi_ev_add_gpe_reference(gpe_event_info);
 	}
 
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index c637666..b836139 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -132,7 +132,7 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 	 */
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
 	if (gpe_event_info) {
-		if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) !=
+		if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
 		    ACPI_GPE_DISPATCH_NONE) {
 			status = acpi_ev_add_gpe_reference(gpe_event_info);
 		} else {
@@ -313,7 +313,7 @@ acpi_setup_gpe_for_wake(acpi_handle wake_device,
 	 * known as an "implicit notify". Note: The GPE is assumed to be
 	 * level-triggered (for windows compatibility).
 	 */
-	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+	if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
 	    ACPI_GPE_DISPATCH_NONE) {
 		/*
 		 * This is the first device for implicit notify on this GPE.
@@ -327,7 +327,7 @@ acpi_setup_gpe_for_wake(acpi_handle wake_device,
 	 * If we already have an implicit notify on this GPE, add
 	 * this device to the notify list.
 	 */
-	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+	if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) ==
 	    ACPI_GPE_DISPATCH_NOTIFY) {
 
 		/* Ensure that the device is not already in the list */
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 6a955a9..ed85fe7 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -225,7 +225,7 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 
 	/* GPE currently handled? */
 
-	if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) !=
+	if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
 	    ACPI_GPE_DISPATCH_NONE) {
 		local_event_status |= ACPI_EVENT_FLAG_HAS_HANDLER;
 	}
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index bbef173..401705d 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -757,6 +757,7 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_DISPATCH_HANDLER       (u8) 0x02
 #define ACPI_GPE_DISPATCH_NOTIFY        (u8) 0x03
 #define ACPI_GPE_DISPATCH_MASK          (u8) 0x03
+#define ACPI_GPE_DISPATCH_TYPE(flags)   ((u8) ((flags) & ACPI_GPE_DISPATCH_MASK))
 
 #define ACPI_GPE_LEVEL_TRIGGERED        (u8) 0x04
 #define ACPI_GPE_EDGE_TRIGGERED         (u8) 0x00
-- 
1.7.10
