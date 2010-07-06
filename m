From: Lin Ming <ming.m.lin@intel.com>
Subject: ACPICA Release 20100702 linuxized patches
Date: Tue, 06 Jul 2010 11:04:06 +0800
Message-ID: <1278385446.4398.13.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-gL7ISFcC04E9xl6Sj7jg"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33637 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab0GFDDn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Jul 2010 23:03:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi <linux-acpi@vger.kernel.org>


--=-gL7ISFcC04E9xl6Sj7jg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi, Len

Latest ACPICA version 20100702 linuxized patches attached.
The patches applied cleanly on top of commit 76e1ea4(Merge branch
'release' into test) of acpi/test branch.

This time the process is a little complex.
Rafeal's GPE patches have been applied into acpi/test branch. Then we
ported them back to ACPICA code base(with some changes). So the
linuxized patches conflict with the patches already in acpi/test branch.

In order to keep linux acpica code synced with ACPICA code base, please
rebase your acpi/test branch with below patches.

And Rafael has reviewed and agreed patch 02 to 07.

[PATCH 01/13] ACPICA: Rename acpi_hw_gpe_register_bit
[PATCH 02/13] ACPICA: Introduce acpi_gpe_wakeup()
[PATCH 03/13] ACPICA: Remove wakeup GPE reference counting which is not used
[PATCH 04/13] ACPI / EC: Drop suspend and resume routines
[PATCH 05/13] ACPI / EC: Do not use acpi_set_gpe
[PATCH 06/13] ACPICA: Use low-level GPE enable during GPE block initialization
[PATCH 07/13] ACPICA: Drop acpi_set_gpe
[PATCH 08/13] ACPICA: Add support for WDDT - Watchdog Descriptor Table
[PATCH 09/13] ACPICA: Update debug output components
[PATCH 10/13] ACPICA: Remove obsolete GPE function
[PATCH 11/13] ACPICA: Fix lint warning for 64-bit constant
[PATCH 12/13] ACPICA: Fix for Alias references within Package objects
[PATCH 13/13] ACPICA: Update version to 20100702

Thanks,
Lin Ming

--=-gL7ISFcC04E9xl6Sj7jg
Content-Disposition: attachment; filename=acpica-v20100702.mbox
Content-Type: application/mbox; name=acpica-v20100702.mbox
Content-Transfer-Encoding: 7bit

>From a93745c84f1ffd98a14e6853400c6bad5f7bb342 Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Thu, 1 Jul 2010 10:07:17 +0800
Subject: [PATCH 01/13] ACPICA: Rename acpi_hw_gpe_register_bit

Rename acpi_hw_gpe_register_bit to acpi_hw_get_gpe_register_bit
in order to be same with ACPICA code base.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/achware.h |    2 +-
 drivers/acpi/acpica/evgpe.c   |    2 +-
 drivers/acpi/acpica/hwgpe.c   |   10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 3239158..c73144c 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -90,7 +90,7 @@ acpi_status acpi_hw_write_port(acpi_io_address address, u32 value, u32 width);
 /*
  * hwgpe - GPE support
  */
-u32 acpi_hw_gpe_register_bit(struct acpi_gpe_event_info *gpe_event_info,
+u32 acpi_hw_get_gpe_register_bit(struct acpi_gpe_event_info *gpe_event_info,
 			     struct acpi_gpe_register_info *gpe_register_info);
 
 acpi_status
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 7c2c336..d24d7d3 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -78,7 +78,7 @@ acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info)
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
-	register_bit = acpi_hw_gpe_register_bit(gpe_event_info,
+	register_bit = acpi_hw_get_gpe_register_bit(gpe_event_info,
 						gpe_register_info);
 
 	/* Clear the wake/run bits up front */
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 3450309..12d70fd 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -57,7 +57,7 @@ acpi_hw_enable_wakeup_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 /******************************************************************************
  *
- * FUNCTION:	acpi_hw_gpe_register_bit
+ * FUNCTION:	acpi_hw_get_gpe_register_bit
  *
  * PARAMETERS:	gpe_event_info	    - Info block for the GPE
  *		gpe_register_info   - Info block for the GPE register
@@ -69,7 +69,7 @@ acpi_hw_enable_wakeup_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
  *
  ******************************************************************************/
 
-u32 acpi_hw_gpe_register_bit(struct acpi_gpe_event_info *gpe_event_info,
+u32 acpi_hw_get_gpe_register_bit(struct acpi_gpe_event_info *gpe_event_info,
 			     struct acpi_gpe_register_info *gpe_register_info)
 {
 	return (u32)1 << (gpe_event_info->gpe_number -
@@ -115,7 +115,7 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 action)
 
 	/* Set ot clear just the bit that corresponds to this GPE */
 
-	register_bit = acpi_hw_gpe_register_bit(gpe_event_info,
+	register_bit = acpi_hw_get_gpe_register_bit(gpe_event_info,
 						gpe_register_info);
 	switch (action) {
 	case ACPI_GPE_COND_ENABLE:
@@ -193,7 +193,7 @@ acpi_status acpi_hw_clear_gpe(struct acpi_gpe_event_info * gpe_event_info)
 		return (AE_NOT_EXIST);
 	}
 
-	register_bit = acpi_hw_gpe_register_bit(gpe_event_info,
+	register_bit = acpi_hw_get_gpe_register_bit(gpe_event_info,
 						gpe_register_info);
 
 	/*
@@ -241,7 +241,7 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 
 	/* Get the register bitmask for this GPE */
 
-	register_bit = acpi_hw_gpe_register_bit(gpe_event_info,
+	register_bit = acpi_hw_get_gpe_register_bit(gpe_event_info,
 						gpe_register_info);
 
 	/* GPE currently enabled? (enabled for runtime?) */

>From 088679835a5834f5eeefc51a81afb1eff8dcd813 Mon Sep 17 00:00:00 2001
From: Rafael J. Wysocki <rjw@sisk.pl>
Date: Fri, 25 Jun 2010 01:18:39 +0200
Subject: [PATCH 02/13] ACPICA: Introduce acpi_gpe_wakeup()

ACPICA uses reference counters to avoid disabling GPEs too early in
case they have been enabled for many times.  This is done separately
for runtime and for wakeup, but the wakeup GPE reference counter is
not really necessary, because GPEs are only enabled to wake up the
system at the hardware level by acpi_enter_sleep_state().  Thus it
only is necessary to set the corresponding bits in the wakeup enable
masks of these GPEs' registers right before the system enters a sleep
state.  Moreover, the GPE wakeup enable bits can only be set when the
target sleep state of the system is known and they need to be cleared
immediately after wakeup regardless of how many wakeup devices are
associated with a given GPE.

On the basis of the above observations, introduce function
acpi_gpe_wakeup() to be used for setting or clearing the enable bit
corresponding to a given GPE in its enable register's enable_for_wake
mask.  Modify the ACPI suspend and wakeup code the use
acpi_gpe_wakeup() instead of acpi_{enable|disable}_gpe() to set
and clear GPE enable bits in their registers' enable_for_wake masks
during system transitions to a sleep state and back to the working
state, respectively.  [This will allow us to drop the third
argument of acpi_{enable|disable}_gpe() and simplify the GPE
handling code.]

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/evxfevnt.c |   67 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/sleep.c           |   15 ++-------
 drivers/acpi/wakeup.c          |   18 ++++++----
 include/acpi/acpixf.h          |    2 +
 include/acpi/actypes.h         |    2 +-
 5 files changed, 84 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index d97b8dc..d6a6d4a 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -308,6 +308,73 @@ ACPI_EXPORT_SYMBOL(acpi_set_gpe)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_gpe_wakeup
+ *
+ * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number      - GPE level within the GPE block
+ *              Action          - Enable or Disable
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Set or clear the GPE's wakeup enable mask bit.
+ *
+ ******************************************************************************/
+acpi_status acpi_gpe_wakeup(acpi_handle gpe_device, u32 gpe_number, u8 action)
+{
+	acpi_status status = AE_OK;
+	struct acpi_gpe_event_info *gpe_event_info;
+	struct acpi_gpe_register_info *gpe_register_info;
+	acpi_cpu_flags flags;
+	u32 register_bit;
+
+	ACPI_FUNCTION_TRACE(acpi_gpe_wakeup);
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Ensure that we have a valid GPE number */
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (!gpe_event_info) {
+		status = AE_BAD_PARAMETER;
+		goto unlock_and_exit;
+	}
+
+	gpe_register_info = gpe_event_info->register_info;
+	if (!gpe_register_info) {
+		status = AE_NOT_EXIST;
+		goto unlock_and_exit;
+	}
+
+	register_bit =
+	    acpi_hw_get_gpe_register_bit(gpe_event_info, gpe_register_info);
+
+	/* Perform the action */
+
+	switch (action) {
+	case ACPI_GPE_ENABLE:
+		ACPI_SET_BIT(gpe_register_info->enable_for_wake, register_bit);
+		break;
+
+	case ACPI_GPE_DISABLE:
+		ACPI_CLEAR_BIT(gpe_register_info->enable_for_wake,
+			       register_bit);
+		break;
+
+	default:
+		ACPI_ERROR((AE_INFO, "%u, Invalid action", action));
+		status = AE_BAD_PARAMETER;
+		break;
+	}
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_gpe_wakeup)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_enable_gpe
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 5b7c52e..aaa1af5 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -664,18 +664,9 @@ int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
 		return -ENODEV;
 	}
 
-	if (enable) {
-		error = acpi_enable_wakeup_device_power(adev,
-						acpi_target_sleep_state);
-		if (!error)
-			acpi_enable_gpe(adev->wakeup.gpe_device,
-					adev->wakeup.gpe_number,
-					ACPI_GPE_TYPE_WAKE);
-	} else {
-		acpi_disable_gpe(adev->wakeup.gpe_device, adev->wakeup.gpe_number,
-				ACPI_GPE_TYPE_WAKE);
-		error = acpi_disable_wakeup_device_power(adev);
-	}
+	error = enable ?
+		acpi_enable_wakeup_device_power(adev, acpi_target_sleep_state) :
+		acpi_disable_wakeup_device_power(adev);
 	if (!error)
 		dev_info(dev, "wake-up capability %s by ACPI\n",
 				enable ? "enabled" : "disabled");
diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index 388747a..c80537b 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -64,13 +64,14 @@ void acpi_enable_wakeup_device(u8 sleep_state)
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
 
-		if (!dev->wakeup.flags.valid || !dev->wakeup.state.enabled
+		if (!dev->wakeup.flags.valid
+		    || !(dev->wakeup.state.enabled || dev->wakeup.prepare_count)
 		    || sleep_state > (u32) dev->wakeup.sleep_state)
 			continue;
 
 		/* The wake-up power should have been enabled already. */
-		acpi_enable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
-				ACPI_GPE_TYPE_WAKE);
+		acpi_gpe_wakeup(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
+				ACPI_GPE_ENABLE);
 	}
 }
 
@@ -89,13 +90,16 @@ void acpi_disable_wakeup_device(u8 sleep_state)
 		struct acpi_device *dev =
 			container_of(node, struct acpi_device, wakeup_list);
 
-		if (!dev->wakeup.flags.valid || !dev->wakeup.state.enabled
+		if (!dev->wakeup.flags.valid
+		    || !(dev->wakeup.state.enabled || dev->wakeup.prepare_count)
 		    || (sleep_state > (u32) dev->wakeup.sleep_state))
 			continue;
 
-		acpi_disable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
-				ACPI_GPE_TYPE_WAKE);
-		acpi_disable_wakeup_device_power(dev);
+		acpi_gpe_wakeup(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
+				ACPI_GPE_DISABLE);
+
+		if (dev->wakeup.state.enabled)
+			acpi_disable_wakeup_device_power(dev);
 	}
 }
 
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 8aaa596..17396e8 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -292,6 +292,8 @@ acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type);
 
 acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number);
 
+acpi_status acpi_gpe_wakeup(acpi_handle gpe_device, u32 gpe_number, u8 action);
+
 acpi_status
 acpi_get_gpe_status(acpi_handle gpe_device,
 		    u32 gpe_number, acpi_event_status *event_status);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index d55f4a7..6a65a94 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -663,7 +663,7 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_MAX                    0xFF
 #define ACPI_NUM_GPE                    256
 
-/* Actions for acpi_set_gpe and acpi_hw_low_set_gpe */
+/* Actions for acpi_set_gpe, acpi_gpe_wakeup, acpi_hw_low_set_gpe */
 
 #define ACPI_GPE_ENABLE                 0
 #define ACPI_GPE_DISABLE                1

>From 52614906ff6e541628a293c642630282322963e5 Mon Sep 17 00:00:00 2001
From: Rafael J. Wysocki <rjw@sisk.pl>
Date: Thu, 1 Jul 2010 10:11:45 +0800
Subject: [PATCH 03/13] ACPICA: Remove wakeup GPE reference counting which is not used

After the previous patch that introduced acpi_gpe_wakeup() and
modified the ACPI suspend and wakeup code to use it, the third
argument of acpi_{enable|disable}_gpe() and the GPE wakeup
reference counter are not necessary any more.  Remove them and
modify all of the users of acpi_{enable|disable}_gpe()
accordingly.  Also drop GPE type constants that aren't used
any more.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acevents.h  |    2 +-
 drivers/acpi/acpica/aclocal.h   |    1 -
 drivers/acpi/acpica/evgpe.c     |   21 +++----
 drivers/acpi/acpica/evgpeblk.c  |    3 +-
 drivers/acpi/acpica/evgpeinit.c |    3 +-
 drivers/acpi/acpica/evxfevnt.c  |  119 +++++++++-----------------------------
 drivers/acpi/button.c           |    6 +-
 drivers/acpi/ec.c               |    6 +-
 drivers/acpi/system.c           |    6 +-
 drivers/pci/pci-acpi.c          |    6 +-
 include/acpi/acpixf.h           |    6 +-
 include/acpi/actypes.h          |    6 --
 12 files changed, 50 insertions(+), 135 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index c3f43da..a561944 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -78,7 +78,7 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node *node,
 u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list);
 
 acpi_status
-acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info);
+acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info);
 
 struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 						       u32 gpe_number);
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index eb2d420..1ee0bcf 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -429,7 +429,6 @@ struct acpi_gpe_event_info {
 	u8 flags;		/* Misc info about this GPE */
 	u8 gpe_number;		/* This GPE */
 	u8 runtime_count;	/* References to a run GPE */
-	u8 wakeup_count;	/* References to a wake GPE */
 };
 
 /* Information about a GPE register pair, one per each status/enable pair in an array */
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index d24d7d3..9413ac6 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -54,24 +54,24 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context);
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_ev_update_gpe_enable_masks
+ * FUNCTION:    acpi_ev_update_gpe_enable_mask
  *
  * PARAMETERS:  gpe_event_info          - GPE to update
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Updates GPE register enable masks based upon whether there are
- *              references (either wake or run) to this GPE
+ * DESCRIPTION: Updates GPE register enable mask based upon whether there are
+ *              runtime references to this GPE
  *
  ******************************************************************************/
 
 acpi_status
-acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info)
+acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info)
 {
 	struct acpi_gpe_register_info *gpe_register_info;
 	u32 register_bit;
 
-	ACPI_FUNCTION_TRACE(ev_update_gpe_enable_masks);
+	ACPI_FUNCTION_TRACE(ev_update_gpe_enable_mask);
 
 	gpe_register_info = gpe_event_info->register_info;
 	if (!gpe_register_info) {
@@ -81,19 +81,14 @@ acpi_ev_update_gpe_enable_masks(struct acpi_gpe_event_info *gpe_event_info)
 	register_bit = acpi_hw_get_gpe_register_bit(gpe_event_info,
 						gpe_register_info);
 
-	/* Clear the wake/run bits up front */
+	/* Clear the run bit up front */
 
-	ACPI_CLEAR_BIT(gpe_register_info->enable_for_wake, register_bit);
 	ACPI_CLEAR_BIT(gpe_register_info->enable_for_run, register_bit);
 
-	/* Set the mask bits only if there are references to this GPE */
+	/* Set the mask bit only if there are references to this GPE */
 
 	if (gpe_event_info->runtime_count) {
-		ACPI_SET_BIT(gpe_register_info->enable_for_run, register_bit);
-	}
-
-	if (gpe_event_info->wakeup_count) {
-		ACPI_SET_BIT(gpe_register_info->enable_for_wake, register_bit);
+		ACPI_SET_BIT(gpe_register_info->enable_for_run, (u8)register_bit);
 	}
 
 	return_ACPI_STATUS(AE_OK);
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 341a38c..77e8630 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -529,8 +529,7 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 
 			/* Enable this GPE */
 
-			status = acpi_enable_gpe(gpe_device, gpe_number,
-						 ACPI_GPE_TYPE_RUNTIME);
+			status = acpi_enable_gpe(gpe_device, gpe_number);
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
 						"Could not enable GPE 0x%02X",
diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index 3f6c2d2..8db9e07 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -482,8 +482,7 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 				gpe_device = NULL;
 			}
 
-			status = acpi_enable_gpe(gpe_device, gpe_number,
-						 ACPI_GPE_TYPE_RUNTIME);
+			status = acpi_enable_gpe(gpe_device, gpe_number);
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
 						"Could not enable GPE 0x%02X",
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index d6a6d4a..467fde9 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -352,12 +352,13 @@ acpi_status acpi_gpe_wakeup(acpi_handle gpe_device, u32 gpe_number, u8 action)
 
 	switch (action) {
 	case ACPI_GPE_ENABLE:
-		ACPI_SET_BIT(gpe_register_info->enable_for_wake, register_bit);
+		ACPI_SET_BIT(gpe_register_info->enable_for_wake,
+			     (u8)register_bit);
 		break;
 
 	case ACPI_GPE_DISABLE:
 		ACPI_CLEAR_BIT(gpe_register_info->enable_for_wake,
-			       register_bit);
+			       (u8)register_bit);
 		break;
 
 	default:
@@ -379,17 +380,14 @@ ACPI_EXPORT_SYMBOL(acpi_gpe_wakeup)
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number      - GPE level within the GPE block
- *              gpe_type        - ACPI_GPE_TYPE_RUNTIME or ACPI_GPE_TYPE_WAKE
- *                                or both
  *
  * RETURN:      Status
  *
  * DESCRIPTION: Add a reference to a GPE. On the first reference, the GPE is
- *              hardware-enabled (for runtime GPEs), or the GPE register mask
- *              is updated (for wake GPEs).
+ *              hardware-enabled.
  *
  ******************************************************************************/
-acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type)
+acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 {
 	acpi_status status = AE_OK;
 	struct acpi_gpe_event_info *gpe_event_info;
@@ -397,12 +395,6 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type)
 
 	ACPI_FUNCTION_TRACE(acpi_enable_gpe);
 
-	/* Parameter validation */
-
-	if (!gpe_type || (gpe_type & ~ACPI_GPE_TYPE_WAKE_RUN)) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Ensure that we have a valid GPE number */
@@ -413,46 +405,19 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type)
 		goto unlock_and_exit;
 	}
 
-	if (gpe_type & ACPI_GPE_TYPE_RUNTIME) {
-		if (gpe_event_info->runtime_count == ACPI_UINT8_MAX) {
-			status = AE_LIMIT;	/* Too many references */
-			goto unlock_and_exit;
-		}
-
-		gpe_event_info->runtime_count++;
-		if (gpe_event_info->runtime_count == 1) {
-			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
-			if (ACPI_SUCCESS(status)) {
-				status = acpi_clear_and_enable_gpe(gpe_event_info);
-			}
-
-			if (ACPI_FAILURE(status)) {
-				gpe_event_info->runtime_count--;
-				goto unlock_and_exit;
-			}
-		}
+	if (gpe_event_info->runtime_count == ACPI_UINT8_MAX) {
+		status = AE_LIMIT;	/* Too many references */
+		goto unlock_and_exit;
 	}
 
-	if (gpe_type & ACPI_GPE_TYPE_WAKE) {
-		/* The GPE must have the ability to wake the system */
-
-		if (!(gpe_event_info->flags & ACPI_GPE_CAN_WAKE)) {
-			status = AE_TYPE;
-			goto unlock_and_exit;
-		}
-
-		if (gpe_event_info->wakeup_count == ACPI_UINT8_MAX) {
-			status = AE_LIMIT;	/* Too many references */
-			goto unlock_and_exit;
+	gpe_event_info->runtime_count++;
+	if (gpe_event_info->runtime_count == 1) {
+		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
+		if (ACPI_SUCCESS(status)) {
+			status = acpi_clear_and_enable_gpe(gpe_event_info);
 		}
-
-		/*
-		 * Update the enable mask on the first wakeup reference. Wake GPEs
-		 * are only hardware-enabled just before sleeping.
-		 */
-		gpe_event_info->wakeup_count++;
-		if (gpe_event_info->wakeup_count == 1) {
-			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
+		if (ACPI_FAILURE(status)) {
+			gpe_event_info->runtime_count--;
 		}
 	}
 
@@ -468,8 +433,6 @@ ACPI_EXPORT_SYMBOL(acpi_enable_gpe)
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number      - GPE level within the GPE block
- *              gpe_type        - ACPI_GPE_TYPE_RUNTIME or ACPI_GPE_TYPE_WAKE
- *                                or both
  *
  * RETURN:      Status
  *
@@ -478,7 +441,7 @@ ACPI_EXPORT_SYMBOL(acpi_enable_gpe)
  *              the GPE mask bit disabled (for wake GPEs)
  *
  ******************************************************************************/
-acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type)
+acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number)
 {
 	acpi_status status = AE_OK;
 	struct acpi_gpe_event_info *gpe_event_info;
@@ -486,12 +449,6 @@ acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type
 
 	ACPI_FUNCTION_TRACE(acpi_disable_gpe);
 
-	/* Parameter validation */
-
-	if (!gpe_type || (gpe_type & ~ACPI_GPE_TYPE_WAKE_RUN)) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Ensure that we have a valid GPE number */
@@ -504,41 +461,21 @@ acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type
 
 	/* Hardware-disable a runtime GPE on removal of the last reference */
 
-	if (gpe_type & ACPI_GPE_TYPE_RUNTIME) {
-		if (!gpe_event_info->runtime_count) {
-			status = AE_LIMIT;	/* There are no references to remove */
-			goto unlock_and_exit;
-		}
-
-		gpe_event_info->runtime_count--;
-		if (!gpe_event_info->runtime_count) {
-			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
-			if (ACPI_SUCCESS(status)) {
-				status = acpi_hw_low_set_gpe(gpe_event_info,
-							     ACPI_GPE_DISABLE);
-			}
-
-			if (ACPI_FAILURE(status)) {
-				gpe_event_info->runtime_count++;
-				goto unlock_and_exit;
-			}
-		}
+	if (!gpe_event_info->runtime_count) {
+		status = AE_LIMIT;	/* There are no references to remove */
+		goto unlock_and_exit;
 	}
 
-	/*
-	 * Update masks for wake GPE on removal of the last reference.
-	 * No need to hardware-disable wake GPEs here, they are not currently
-	 * enabled.
-	 */
-	if (gpe_type & ACPI_GPE_TYPE_WAKE) {
-		if (!gpe_event_info->wakeup_count) {
-			status = AE_LIMIT;	/* There are no references to remove */
-			goto unlock_and_exit;
+	gpe_event_info->runtime_count--;
+	if (!gpe_event_info->runtime_count) {
+		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
+		if (ACPI_SUCCESS(status)) {
+			status =
+			    acpi_hw_low_set_gpe(gpe_event_info,
+						ACPI_GPE_DISABLE);
 		}
-
-		gpe_event_info->wakeup_count--;
-		if (!gpe_event_info->wakeup_count) {
-			status = acpi_ev_update_gpe_enable_masks(gpe_event_info);
+		if (ACPI_FAILURE(status)) {
+			gpe_event_info->runtime_count++;
 		}
 	}
 
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 7d857da..1575a9b 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -424,8 +424,7 @@ static int acpi_button_add(struct acpi_device *device)
 	if (device->wakeup.flags.valid) {
 		/* Button's GPE is run-wake GPE */
 		acpi_enable_gpe(device->wakeup.gpe_device,
-				device->wakeup.gpe_number,
-				ACPI_GPE_TYPE_RUNTIME);
+				device->wakeup.gpe_number);
 		device->wakeup.run_wake_count++;
 		device->wakeup.state.enabled = 1;
 	}
@@ -448,8 +447,7 @@ static int acpi_button_remove(struct acpi_device *device, int type)
 
 	if (device->wakeup.flags.valid) {
 		acpi_disable_gpe(device->wakeup.gpe_device,
-				device->wakeup.gpe_number,
-				ACPI_GPE_TYPE_RUNTIME);
+				device->wakeup.gpe_number);
 		device->wakeup.run_wake_count--;
 		device->wakeup.state.enabled = 0;
 	}
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 5f2027d..bf50454 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -822,7 +822,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	acpi_enable_gpe(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
+	acpi_enable_gpe(NULL, ec->gpe);
 	status = acpi_install_address_space_handler(ec->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_ec_space_handler,
@@ -839,7 +839,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
 		} else {
 			acpi_remove_gpe_handler(NULL, ec->gpe,
 				&acpi_ec_gpe_handler);
-			acpi_disable_gpe(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
+			acpi_disable_gpe(NULL, ec->gpe);
 			return -ENODEV;
 		}
 	}
@@ -850,7 +850,7 @@ static int ec_install_handlers(struct acpi_ec *ec)
 
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
-	acpi_disable_gpe(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
+	acpi_disable_gpe(NULL, ec->gpe);
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 		pr_err(PREFIX "failed to remove space handler\n");
diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index f8db50a..5981bd0 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -388,12 +388,10 @@ static ssize_t counter_set(struct kobject *kobj,
 	if (index < num_gpes) {
 		if (!strcmp(buf, "disable\n") &&
 				(status & ACPI_EVENT_FLAG_ENABLED))
-			result = acpi_disable_gpe(handle, index,
-						ACPI_GPE_TYPE_RUNTIME);
+			result = acpi_disable_gpe(handle, index);
 		else if (!strcmp(buf, "enable\n") &&
 				!(status & ACPI_EVENT_FLAG_ENABLED))
-			result = acpi_enable_gpe(handle, index,
-						ACPI_GPE_TYPE_RUNTIME);
+			result = acpi_enable_gpe(handle, index);
 		else if (!strcmp(buf, "clear\n") &&
 				(status & ACPI_EVENT_FLAG_SET))
 			result = acpi_clear_gpe(handle, index);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 2e7a3bf..5342e03 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -295,14 +295,12 @@ static int acpi_dev_run_wake(struct device *phys_dev, bool enable)
 		if (!dev->wakeup.run_wake_count++) {
 			acpi_enable_wakeup_device_power(dev, ACPI_STATE_S0);
 			acpi_enable_gpe(dev->wakeup.gpe_device,
-					dev->wakeup.gpe_number,
-					ACPI_GPE_TYPE_RUNTIME);
+					dev->wakeup.gpe_number);
 		}
 	} else if (dev->wakeup.run_wake_count > 0) {
 		if (!--dev->wakeup.run_wake_count) {
 			acpi_disable_gpe(dev->wakeup.gpe_device,
-					 dev->wakeup.gpe_number,
-					 ACPI_GPE_TYPE_RUNTIME);
+					 dev->wakeup.gpe_number);
 			acpi_disable_wakeup_device_power(dev);
 		}
 	} else {
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 17396e8..354d785 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -284,11 +284,9 @@ acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status);
  */
 acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action);
 
-acpi_status
-acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type);
+acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number);
 
-acpi_status
-acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number, u8 gpe_type);
+acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number);
 
 acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number);
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 6a65a94..a42513d 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -669,12 +669,6 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_DISABLE                1
 #define ACPI_GPE_COND_ENABLE            2
 
-/* gpe_types for acpi_enable_gpe and acpi_disable_gpe */
-
-#define ACPI_GPE_TYPE_WAKE              (u8) 0x01
-#define ACPI_GPE_TYPE_RUNTIME           (u8) 0x02
-#define ACPI_GPE_TYPE_WAKE_RUN          (u8) 0x03
-
 /*
  * GPE info flags - Per GPE
  * +-------+---+-+-+

>From 06d60a89c4a2fe4acd3fbdec93024435f8e2a806 Mon Sep 17 00:00:00 2001
From: Rafael J. Wysocki <rjw@sisk.pl>
Date: Fri, 25 Jun 2010 01:20:38 +0200
Subject: [PATCH 04/13] ACPI / EC: Drop suspend and resume routines

The suspend and resume routines provided by the EC driver are not
really necessary, because the handler of the GPE disabled by them
is not going to be executed after suspend_device_irqs() and before
resume_device_irqs() anyway.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index bf50454..9bf7a75 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1088,22 +1088,6 @@ error:
 	return -ENODEV;
 }
 
-static int acpi_ec_suspend(struct acpi_device *device, pm_message_t state)
-{
-	struct acpi_ec *ec = acpi_driver_data(device);
-	/* Stop using the GPE, but keep it reference counted. */
-	acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
-	return 0;
-}
-
-static int acpi_ec_resume(struct acpi_device *device)
-{
-	struct acpi_ec *ec = acpi_driver_data(device);
-	/* Enable the GPE again, but don't reference count it once more. */
-	acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);
-	return 0;
-}
-
 static struct acpi_driver acpi_ec_driver = {
 	.name = "ec",
 	.class = ACPI_EC_CLASS,
@@ -1111,8 +1095,6 @@ static struct acpi_driver acpi_ec_driver = {
 	.ops = {
 		.add = acpi_ec_add,
 		.remove = acpi_ec_remove,
-		.suspend = acpi_ec_suspend,
-		.resume = acpi_ec_resume,
 		},
 };
 

>From 0816f5d3d61281075acf14d0656510156974b27a Mon Sep 17 00:00:00 2001
From: Rafael J. Wysocki <rjw@sisk.pl>
Date: Fri, 25 Jun 2010 01:21:42 +0200
Subject: [PATCH 05/13] ACPI / EC: Do not use acpi_set_gpe

The EC driver is the last user of acpi_set_gpe() and since it is
guaranteed that the EC GPE will not be shared, acpi_disable_gpe()
and acpi_enable_gpe() may be used for disabling the GPE temporarilty
if a GPE storm is detected and re-enabling it during EC transactions.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9bf7a75..1e6d418 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -313,11 +313,8 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 	pr_debug(PREFIX "transaction start\n");
 	/* disable GPE during transaction if storm is detected */
 	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
-		/*
-		 * It has to be disabled at the hardware level regardless of the
-		 * GPE reference counting, so that it doesn't trigger.
-		 */
-		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_DISABLE);
+		/* It has to be disabled, so that it doesn't trigger. */
+		acpi_disable_gpe(NULL, ec->gpe);
 	}
 
 	status = acpi_ec_transaction_unlocked(ec, t);
@@ -326,12 +323,8 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
 	ec_check_sci_sync(ec, acpi_ec_read_status(ec));
 	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
 		msleep(1);
-		/*
-		 * It is safe to enable the GPE outside of the transaction.  Use
-		 * acpi_set_gpe() for that, since we used it to disable the GPE
-		 * above.
-		 */
-		acpi_set_gpe(NULL, ec->gpe, ACPI_GPE_ENABLE);
+		/* It is safe to enable the GPE outside of the transaction. */
+		acpi_enable_gpe(NULL, ec->gpe);
 	} else if (t->irq_count > ACPI_EC_STORM_THRESHOLD) {
 		pr_info(PREFIX "GPE storm detected, "
 			"transactions will use polling mode\n");

>From 10108b31cafa8c9bb2a734e94700b0ba2cb332df Mon Sep 17 00:00:00 2001
From: Rafael J. Wysocki <rjw@sisk.pl>
Date: Thu, 1 Jul 2010 11:01:12 +0800
Subject: [PATCH 06/13] ACPICA: Use low-level GPE enable during GPE block initialization

The GPE block initialization code in acpi_ev_initialize_gpe_block()
uses acpi_set_gpe() to make sure that the GPEs with nonzero
runtime counter will remain enabled, but since it already has
a struct acpi_gpe_event_info object for each GPE, it might use
the low-level GPE enabling function, acpi_clear_and_enable_gpe(),
for this purpose.

To make that happen, move acpi_clear_and_enable_gpe() to
drivers/acpi/acpica/evgpe.c and rename it to acpi_ev_enable_gpe(),
modify the two existing users of it accordingly and modify
acpi_ev_initialize_gpe_block() to use it instead of acpi_set_gpe()
and to check its return value.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acevents.h |    2 +
 drivers/acpi/acpica/evgpe.c    |   40 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/evgpeblk.c |    7 ++---
 drivers/acpi/acpica/evxfevnt.c |   42 +--------------------------------------
 4 files changed, 47 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index a561944..e0e6aff 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -80,6 +80,8 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info *gpe_xrupt_list);
 acpi_status
 acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info);
 
+acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info);
+
 struct acpi_gpe_event_info *acpi_ev_get_gpe_event_info(acpi_handle gpe_device,
 						       u32 gpe_number);
 
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 9413ac6..56de460 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -94,6 +94,46 @@ acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info)
 	return_ACPI_STATUS(AE_OK);
 }
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_ev_enable_gpe
+ *
+ * PARAMETERS:  gpe_event_info  - GPE to enable
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Clear the given GPE from stale events and enable it.
+ *
+ ******************************************************************************/
+acpi_status
+acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+{
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(ev_enable_gpe);
+
+	/*
+	 * We will only allow a GPE to be enabled if it has either an
+	 * associated method (_Lxx/_Exx) or a handler. Otherwise, the
+	 * GPE will be immediately disabled by acpi_ev_gpe_dispatch the
+	 * first time it fires.
+	 */
+	if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)) {
+		return_ACPI_STATUS(AE_NO_HANDLER);
+	}
+
+	/* Clear the GPE (of stale events) */
+	status = acpi_hw_clear_gpe(gpe_event_info);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Enable the requested GPE */
+	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
+
+	return_ACPI_STATUS(status);
+}
+
 
 /*******************************************************************************
  *
diff --git a/drivers/acpi/acpica/evgpeblk.c b/drivers/acpi/acpica/evgpeblk.c
index 77e8630..0c6f3f8 100644
--- a/drivers/acpi/acpica/evgpeblk.c
+++ b/drivers/acpi/acpica/evgpeblk.c
@@ -508,10 +508,8 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 			 * increment its reference counter.
 			 */
 			if (gpe_event_info->runtime_count) {
-				acpi_set_gpe(gpe_device, gpe_number,
-						ACPI_GPE_ENABLE);
-				gpe_enabled_count++;
-				continue;
+				status = acpi_ev_enable_gpe(gpe_event_info);
+				goto enabled;
 			}
 
 			if (gpe_event_info->flags & ACPI_GPE_CAN_WAKE) {
@@ -530,6 +528,7 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 			/* Enable this GPE */
 
 			status = acpi_enable_gpe(gpe_device, gpe_number);
+		      enabled:
 			if (ACPI_FAILURE(status)) {
 				ACPI_EXCEPTION((AE_INFO, status,
 						"Could not enable GPE 0x%02X",
diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index 467fde9..b094cc0 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -210,44 +210,6 @@ ACPI_EXPORT_SYMBOL(acpi_enable_event)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_clear_and_enable_gpe
- *
- * PARAMETERS:  gpe_event_info  - GPE to enable
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Clear the given GPE from stale events and enable it.
- *
- ******************************************************************************/
-static acpi_status
-acpi_clear_and_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
-{
-	acpi_status status;
-
-	/*
-	 * We will only allow a GPE to be enabled if it has either an
-	 * associated method (_Lxx/_Exx) or a handler. Otherwise, the
-	 * GPE will be immediately disabled by acpi_ev_gpe_dispatch the
-	 * first time it fires.
-	 */
-	if (!(gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)) {
-		return_ACPI_STATUS(AE_NO_HANDLER);
-	}
-
-	/* Clear the GPE (of stale events) */
-	status = acpi_hw_clear_gpe(gpe_event_info);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Enable the requested GPE */
-	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
-
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_set_gpe
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
@@ -287,7 +249,7 @@ acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action)
 
 	switch (action) {
 	case ACPI_GPE_ENABLE:
-		status = acpi_clear_and_enable_gpe(gpe_event_info);
+		status = acpi_ev_enable_gpe(gpe_event_info);
 		break;
 
 	case ACPI_GPE_DISABLE:
@@ -414,7 +376,7 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 	if (gpe_event_info->runtime_count == 1) {
 		status = acpi_ev_update_gpe_enable_mask(gpe_event_info);
 		if (ACPI_SUCCESS(status)) {
-			status = acpi_clear_and_enable_gpe(gpe_event_info);
+			status = acpi_ev_enable_gpe(gpe_event_info);
 		}
 		if (ACPI_FAILURE(status)) {
 			gpe_event_info->runtime_count--;

>From 5fda46e3fa9b295504bc5c3dc7ca1fd23f2b1134 Mon Sep 17 00:00:00 2001
From: Rafael J. Wysocki <rjw@sisk.pl>
Date: Thu, 1 Jul 2010 11:07:20 +0800
Subject: [PATCH 07/13] ACPICA: Drop acpi_set_gpe

The acpi_set_gpe() function is a little awkward, because it doesn't
really work as advertised in the "disable" case.  Namely, if a GPE
has been enabled with acpi_enable_gpe() and triggered a notification
to occur, and if acpi_set_gpe() is used to disable it before
acpi_ev_asynch_enable_gpe() runs, the GPE will be immediately enabled
by the latter as though the acpi_set_gpe() had no effect.

Thus, since it's been possible to make all of its callers use
alternative operations to disable or enable GPEs, acpi_set_gpe() can
be dropped.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evxfevnt.c |   60 ----------------------------------------
 include/acpi/acpixf.h          |    2 -
 include/acpi/actypes.h         |    2 +-
 3 files changed, 1 insertions(+), 63 deletions(-)

diff --git a/drivers/acpi/acpica/evxfevnt.c b/drivers/acpi/acpica/evxfevnt.c
index b094cc0..fda5b44 100644
--- a/drivers/acpi/acpica/evxfevnt.c
+++ b/drivers/acpi/acpica/evxfevnt.c
@@ -210,66 +210,6 @@ ACPI_EXPORT_SYMBOL(acpi_enable_event)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_set_gpe
- *
- * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
- *              gpe_number      - GPE level within the GPE block
- *              action          - ACPI_GPE_ENABLE or ACPI_GPE_DISABLE
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Enable or disable an individual GPE. This function bypasses
- *              the reference count mechanism used in the acpi_enable_gpe and
- *              acpi_disable_gpe interfaces -- and should be used with care.
- *
- * Note: Typically used to disable a runtime GPE for short period of time,
- * then re-enable it, without disturbing the existing reference counts. This
- * is useful, for example, in the Embedded Controller (EC) driver.
- *
- ******************************************************************************/
-acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action)
-{
-	struct acpi_gpe_event_info *gpe_event_info;
-	acpi_status status;
-	acpi_cpu_flags flags;
-
-	ACPI_FUNCTION_TRACE(acpi_set_gpe);
-
-	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
-
-	/* Ensure that we have a valid GPE number */
-
-	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
-	if (!gpe_event_info) {
-		status = AE_BAD_PARAMETER;
-		goto unlock_and_exit;
-	}
-
-	/* Perform the action */
-
-	switch (action) {
-	case ACPI_GPE_ENABLE:
-		status = acpi_ev_enable_gpe(gpe_event_info);
-		break;
-
-	case ACPI_GPE_DISABLE:
-		status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
-		break;
-
-	default:
-		status = AE_BAD_PARAMETER;
-		break;
-	}
-
-      unlock_and_exit:
-	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
-	return_ACPI_STATUS(status);
-}
-
-ACPI_EXPORT_SYMBOL(acpi_set_gpe)
-
-/*******************************************************************************
- *
  * FUNCTION:    acpi_gpe_wakeup
  *
  * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 354d785..e0a53e4 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -282,8 +282,6 @@ acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status);
 /*
  * GPE Interfaces
  */
-acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action);
-
 acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number);
 
 acpi_status acpi_disable_gpe(acpi_handle gpe_device, u32 gpe_number);
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index a42513d..5db8f47 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -663,7 +663,7 @@ typedef u32 acpi_event_status;
 #define ACPI_GPE_MAX                    0xFF
 #define ACPI_NUM_GPE                    256
 
-/* Actions for acpi_set_gpe, acpi_gpe_wakeup, acpi_hw_low_set_gpe */
+/* Actions for acpi_gpe_wakeup, acpi_hw_low_set_gpe */
 
 #define ACPI_GPE_ENABLE                 0
 #define ACPI_GPE_DISABLE                1

>From 638be881fb3481f53db5a448cb12371fa558f4bf Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 6 Jul 2010 09:58:11 +0800
Subject: [PATCH 08/13] ACPICA: Add support for WDDT - Watchdog Descriptor Table

Header file support.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/actbl2.h |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 0a600b8..d4136b2 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -77,6 +77,7 @@
 #define ACPI_SIG_UEFI           "UEFI"	/* Uefi Boot Optimization Table */
 #define ACPI_SIG_WAET           "WAET"	/* Windows ACPI Emulated devices Table */
 #define ACPI_SIG_WDAT           "WDAT"	/* Watchdog Action Table */
+#define ACPI_SIG_WDDT           "WDDT"	/* Watchdog Timer Description Table */
 #define ACPI_SIG_WDRT           "WDRT"	/* Watchdog Resource Table */
 
 #ifdef ACPI_UNDEFINED_TABLES
@@ -918,6 +919,44 @@ enum acpi_wdat_instructions {
 
 /*******************************************************************************
  *
+ * WDDT - Watchdog Descriptor Table
+ *        Version 1
+ *
+ * Conforms to "Using the Intel ICH Family Watchdog Timer (WDT)",
+ * Version 001, September 2002
+ *
+ ******************************************************************************/
+
+struct acpi_table_wddt {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u16 spec_version;
+	u16 table_version;
+	u16 pci_vendor_id;
+	struct acpi_generic_address address;
+	u16 max_count;		/* Maximum counter value supported */
+	u16 min_count;		/* Minimum counter value supported */
+	u16 period;
+	u16 status;
+	u16 capability;
+};
+
+/* Flags for Status field above */
+
+#define ACPI_WDDT_AVAILABLE     (1)
+#define ACPI_WDDT_ACTIVE        (1<<1)
+#define ACPI_WDDT_TCO_OS_OWNED  (1<<2)
+#define ACPI_WDDT_USER_RESET    (1<<11)
+#define ACPI_WDDT_WDT_RESET     (1<<12)
+#define ACPI_WDDT_POWER_FAIL    (1<<13)
+#define ACPI_WDDT_UNKNOWN_RESET (1<<14)
+
+/* Flags for Capability field above */
+
+#define ACPI_WDDT_AUTO_RESET    (1)
+#define ACPI_WDDT_ALERT_SUPPORT (1<<1)
+
+/*******************************************************************************
+ *
  * WDRT - Watchdog Resource Table
  *        Version 1
  *

>From f5f8d9e38aeb60d24b4948fa3d6970f1a44a561b Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 6 Jul 2010 10:02:16 +0800
Subject: [PATCH 09/13] ACPICA: Update debug output components

Add data table compiler output component

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acoutput.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acoutput.h b/include/acpi/acoutput.h
index 5e95226..bc4a6de 100644
--- a/include/acpi/acoutput.h
+++ b/include/acpi/acoutput.h
@@ -71,8 +71,9 @@
 #define ACPI_TOOLS                  0x00002000
 #define ACPI_EXAMPLE                0x00004000
 #define ACPI_DRIVER                 0x00008000
+#define DT_COMPILER                 0x00010000
 
-#define ACPI_ALL_COMPONENTS         0x0000FFFF
+#define ACPI_ALL_COMPONENTS         0x0001FFFF
 #define ACPI_COMPONENT_DEFAULT      (ACPI_ALL_COMPONENTS)
 
 /* Component IDs reserved for ACPI drivers */

>From 22f0c928062f197bf25850db35a46cce0569dd3d Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 6 Jul 2010 10:30:37 +0800
Subject: [PATCH 10/13] ACPICA: Remove obsolete GPE function

Remove acpi_hw_write_gpe_enable_reg, it had been reduced down to a
single line of code, and called from only one place.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/achware.h |    3 ---
 drivers/acpi/acpica/evgpe.c   |    8 ++++++--
 drivers/acpi/acpica/hwgpe.c   |   25 -------------------------
 3 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index c73144c..120b3af 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -97,9 +97,6 @@ acpi_status
 acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 action);
 
 acpi_status
-acpi_hw_write_gpe_enable_reg(struct acpi_gpe_event_info *gpe_event_info);
-
-acpi_status
 acpi_hw_disable_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 			  struct acpi_gpe_block_info *gpe_block, void *context);
 
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 56de460..7a6a3e6 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -452,8 +452,12 @@ static void acpi_ev_asynch_enable_gpe(void *context)
 		}
 	}
 
-	/* Enable this GPE */
-	(void)acpi_hw_write_gpe_enable_reg(gpe_event_info);
+	/*
+	 * Enable this GPE, conditionally. This means that the GPE will only be
+	 * physically enabled if the enable_for_run bit is set in the event_info
+	 */
+	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_COND_ENABLE);
+
 	return_VOID;
 }
 
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index 12d70fd..14750db 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -143,31 +143,6 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 action)
 
 /******************************************************************************
  *
- * FUNCTION:    acpi_hw_write_gpe_enable_reg
- *
- * PARAMETERS:  gpe_event_info      - Info block for the GPE to be enabled
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Write a GPE enable register.  Note: The bit for this GPE must
- *              already be cleared or set in the parent register
- *              enable_for_run mask.
- *
- ******************************************************************************/
-
-acpi_status
-acpi_hw_write_gpe_enable_reg(struct acpi_gpe_event_info * gpe_event_info)
-{
-	acpi_status status;
-
-	ACPI_FUNCTION_ENTRY();
-
-	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_COND_ENABLE);
-	return (status);
-}
-
-/******************************************************************************
- *
  * FUNCTION:    acpi_hw_clear_gpe
  *
  * PARAMETERS:  gpe_event_info      - Info block for the GPE to be cleared

>From c993628873070abe85d3dfdf3b220ddefa4be3c5 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 6 Jul 2010 10:35:55 +0800
Subject: [PATCH 11/13] ACPICA: Fix lint warning for 64-bit constant

cast to u64.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/nsrepair.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/nsrepair.c b/drivers/acpi/acpica/nsrepair.c
index d4be377..d1c1366 100644
--- a/drivers/acpi/acpica/nsrepair.c
+++ b/drivers/acpi/acpica/nsrepair.c
@@ -556,7 +556,7 @@ acpi_ns_repair_null_element(struct acpi_predefined_data *data,
 
 		/* Need an Integer - create a zero-value integer */
 
-		new_object = acpi_ut_create_integer_object(0);
+		new_object = acpi_ut_create_integer_object((u64)0);
 	} else if (expected_btypes & ACPI_RTYPE_STRING) {
 
 		/* Need a String - create a NULL string */

>From 727f6487e7738a404eee2e16641ab78e1a68a9d3 Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 6 Jul 2010 10:37:13 +0800
Subject: [PATCH 12/13] ACPICA: Fix for Alias references within Package objects

This fixes a problem where a reference to an Alias within the
definition of a Package was not always resolved properly. Aliases
to objects like Processors, ThermalZones, etc. were resolved to the
actual object instead of a reference to the object as it should be.
Package objects are only allowed to contain integer, string,
buffer, package, and reference objects.

https://bugzilla.redhat.com/show_bug.cgi?id=608648

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/dsobject.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/dsobject.c b/drivers/acpi/acpica/dsobject.c
index 3607adc..8e85f54 100644
--- a/drivers/acpi/acpica/dsobject.c
+++ b/drivers/acpi/acpica/dsobject.c
@@ -81,6 +81,7 @@ acpi_ds_build_internal_object(struct acpi_walk_state *walk_state,
 {
 	union acpi_operand_object *obj_desc;
 	acpi_status status;
+	acpi_object_type type;
 
 	ACPI_FUNCTION_TRACE(ds_build_internal_object);
 
@@ -172,7 +173,20 @@ acpi_ds_build_internal_object(struct acpi_walk_state *walk_state,
 				return_ACPI_STATUS(status);
 			}
 
-			switch (op->common.node->type) {
+			/*
+			 * Special handling for Alias objects. We need to setup the type
+			 * and the Op->Common.Node to point to the Alias target. Note,
+			 * Alias has at most one level of indirection internally.
+			 */
+			type = op->common.node->type;
+			if (type == ACPI_TYPE_LOCAL_ALIAS) {
+				type = obj_desc->common.type;
+				op->common.node =
+				    ACPI_CAST_PTR(struct acpi_namespace_node,
+						  op->common.node->object);
+			}
+
+			switch (type) {
 				/*
 				 * For these types, we need the actual node, not the subobject.
 				 * However, the subobject did not get an extra reference count above.

>From 590e1b43be1ea5f0f39e8df5988761b130ab210e Mon Sep 17 00:00:00 2001
From: Bob Moore <robert.moore@intel.com>
Date: Tue, 6 Jul 2010 10:39:01 +0800
Subject: [PATCH 13/13] ACPICA: Update version to 20100702

Version 20100702.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpixf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index e0a53e4..ba94a88 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -47,7 +47,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20100528
+#define ACPI_CA_VERSION                 0x20100702
 
 #include "actypes.h"
 #include "actbl.h"


--=-gL7ISFcC04E9xl6Sj7jg--

