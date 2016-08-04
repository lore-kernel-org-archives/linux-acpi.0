From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/30] ACPICA: Events: Introduce acpi_mask_gpe() to implement GPE masking mechanism
Date: Thu,  4 Aug 2016 16:43:39 +0800
Message-ID: <98cb0dd55517019c87d620f56a06e113e0daa108.1470299677.git.lv.zheng@intel.com>
References: <cover.1470299677.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20489 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754695AbcHDIom (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Aug 2016 04:44:42 -0400
In-Reply-To: <cover.1470299677.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 23a417ca406a527e7ae1710893e59a8b6db30e14

There is a facility in Linux, developers can control the enabling/disabling
of a GPE via /sys/firmware/acpi/interrupts/gpexx. This is mainly for
debugging purposes.

But many users expect to use this facility to implement quirks to mask a
specific GPE when there is a gap in Linux causing this GPE to flood. This
is not working correctly because currently this facility invokes
enabling/disabling counting based GPE driver APIs:
 acpi_enable_gpe()/acpi_disable_gpe()
and the GPE drivers can still affect the count to mess up the GPE
masking purposes.

However, most of the IRQ chip designs allow masking/unmasking IRQs via a
masking bit which is different from the enabled bit to achieve the same
purpose. But the GPE hardware doesn't contain such a feature, this brings
the trouble.

In this patch, we introduce a software mechanism to implement the GPE
masking feature, and acpi_mask_gpe() are provided to the OSPMs to
mask/unmask GPEs in the above mentioned situation instead of
acpi_enable_gpe()/acpi_disable_gpe(). ACPICA BZ 1102. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/23a417ca
Link: https://bugs.acpica.org/show_bug.cgi?id=1102
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acevents.h |    3 +++
 drivers/acpi/acpica/aclocal.h  |    2 ++
 drivers/acpi/acpica/evgpe.c    |   57 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/acpica/evxfgpe.c  |   43 ++++++++++++++++++++++++++++++
 drivers/acpi/acpica/hwgpe.c    |   23 ++++++++++++----
 include/acpi/acpixf.h          |    4 +++
 include/acpi/actypes.h         |   39 ++++++++++++++-------------
 7 files changed, 148 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
index 77af91c..92fa47c 100644
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@ -86,6 +86,9 @@ acpi_ev_update_gpe_enable_mask(struct acpi_gpe_event_info *gpe_event_info);
 acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info);
 
 acpi_status
+acpi_ev_mask_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 is_masked);
+
+acpi_status
 acpi_ev_add_gpe_reference(struct acpi_gpe_event_info *gpe_event_info);
 
 acpi_status
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 13331d7..dff1207 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -484,6 +484,7 @@ struct acpi_gpe_event_info {
 	u8 flags;		/* Misc info about this GPE */
 	u8 gpe_number;		/* This GPE */
 	u8 runtime_count;	/* References to a run GPE */
+	u8 disable_for_dispatch;	/* Masked during dispatching */
 };
 
 /* Information about a GPE register pair, one per each status/enable pair in an array */
@@ -494,6 +495,7 @@ struct acpi_gpe_register_info {
 	u16 base_gpe_number;	/* Base GPE number for this register */
 	u8 enable_for_wake;	/* GPEs to keep enabled when sleeping */
 	u8 enable_for_run;	/* GPEs to keep enabled when running */
+	u8 mask_for_run;	/* GPEs to keep masked when running */
 	u8 enable_mask;		/* Current mask of enabled GPEs */
 };
 
diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 4b4949c..bdb10be 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -130,6 +130,60 @@ acpi_status acpi_ev_enable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_ev_mask_gpe
+ *
+ * PARAMETERS:  gpe_event_info          - GPE to be blocked/unblocked
+ *              is_masked               - Whether the GPE is masked or not
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Unconditionally mask/unmask a GPE during runtime.
+ *
+ ******************************************************************************/
+
+acpi_status
+acpi_ev_mask_gpe(struct acpi_gpe_event_info *gpe_event_info, u8 is_masked)
+{
+	struct acpi_gpe_register_info *gpe_register_info;
+	u32 register_bit;
+
+	ACPI_FUNCTION_TRACE(ev_mask_gpe);
+
+	gpe_register_info = gpe_event_info->register_info;
+	if (!gpe_register_info) {
+		return_ACPI_STATUS(AE_NOT_EXIST);
+	}
+
+	register_bit = acpi_hw_get_gpe_register_bit(gpe_event_info);
+
+	/* Perform the action */
+
+	if (is_masked) {
+		if (register_bit & gpe_register_info->mask_for_run) {
+			return_ACPI_STATUS(AE_BAD_PARAMETER);
+		}
+
+		(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
+		ACPI_SET_BIT(gpe_register_info->mask_for_run, (u8)register_bit);
+	} else {
+		if (!(register_bit & gpe_register_info->mask_for_run)) {
+			return_ACPI_STATUS(AE_BAD_PARAMETER);
+		}
+
+		ACPI_CLEAR_BIT(gpe_register_info->mask_for_run,
+			       (u8)register_bit);
+		if (gpe_event_info->runtime_count
+		    && !gpe_event_info->disable_for_dispatch) {
+			(void)acpi_hw_low_set_gpe(gpe_event_info,
+						  ACPI_GPE_ENABLE);
+		}
+	}
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_ev_add_gpe_reference
  *
  * PARAMETERS:  gpe_event_info          - Add a reference to this GPE
@@ -674,6 +728,7 @@ acpi_status acpi_ev_finish_gpe(struct acpi_gpe_event_info *gpe_event_info)
 	 * in the event_info.
 	 */
 	(void)acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_CONDITIONAL_ENABLE);
+	gpe_event_info->disable_for_dispatch = FALSE;
 	return (AE_OK);
 }
 
@@ -737,6 +792,8 @@ acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
 		}
 	}
 
+	gpe_event_info->disable_for_dispatch = TRUE;
+
 	/*
 	 * Dispatch the GPE to either an installed handler or the control
 	 * method associated with this GPE (_Lxx or _Exx). If a handler
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 17cfef7..d7a3b27 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -235,11 +235,13 @@ acpi_status acpi_set_gpe(acpi_handle gpe_device, u32 gpe_number, u8 action)
 	case ACPI_GPE_ENABLE:
 
 		status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
+		gpe_event_info->disable_for_dispatch = FALSE;
 		break;
 
 	case ACPI_GPE_DISABLE:
 
 		status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_DISABLE);
+		gpe_event_info->disable_for_dispatch = TRUE;
 		break;
 
 	default:
@@ -257,6 +259,47 @@ ACPI_EXPORT_SYMBOL(acpi_set_gpe)
 
 /*******************************************************************************
  *
+ * FUNCTION:    acpi_mask_gpe
+ *
+ * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number          - GPE level within the GPE block
+ *              is_masked           - Whether the GPE is masked or not
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Unconditionally mask/unmask the an individual GPE, ex., to
+ *              prevent a GPE flooding.
+ *
+ ******************************************************************************/
+acpi_status acpi_mask_gpe(acpi_handle gpe_device, u32 gpe_number, u8 is_masked)
+{
+	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_status status;
+	acpi_cpu_flags flags;
+
+	ACPI_FUNCTION_TRACE(acpi_mask_gpe);
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
+	status = acpi_ev_mask_gpe(gpe_event_info, is_masked);
+
+unlock_and_exit:
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_mask_gpe)
+
+/*******************************************************************************
+ *
  * FUNCTION:    acpi_mark_gpe_for_wake
  *
  * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
diff --git a/drivers/acpi/acpica/hwgpe.c b/drivers/acpi/acpica/hwgpe.c
index bdecd5e..76b0e35 100644
--- a/drivers/acpi/acpica/hwgpe.c
+++ b/drivers/acpi/acpica/hwgpe.c
@@ -98,7 +98,7 @@ acpi_status
 acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
 {
 	struct acpi_gpe_register_info *gpe_register_info;
-	acpi_status status;
+	acpi_status status = AE_OK;
 	u32 enable_mask;
 	u32 register_bit;
 
@@ -148,9 +148,14 @@ acpi_hw_low_set_gpe(struct acpi_gpe_event_info *gpe_event_info, u32 action)
 		return (AE_BAD_PARAMETER);
 	}
 
-	/* Write the updated enable mask */
+	if (!(register_bit & gpe_register_info->mask_for_run)) {
 
-	status = acpi_hw_write(enable_mask, &gpe_register_info->enable_address);
+		/* Write the updated enable mask */
+
+		status =
+		    acpi_hw_write(enable_mask,
+				  &gpe_register_info->enable_address);
+	}
 	return (status);
 }
 
@@ -242,6 +247,12 @@ acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
 		local_event_status |= ACPI_EVENT_FLAG_ENABLED;
 	}
 
+	/* GPE currently masked? (masked for runtime?) */
+
+	if (register_bit & gpe_register_info->mask_for_run) {
+		local_event_status |= ACPI_EVENT_FLAG_MASKED;
+	}
+
 	/* GPE enabled for wake? */
 
 	if (register_bit & gpe_register_info->enable_for_wake) {
@@ -397,6 +408,7 @@ acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 	u32 i;
 	acpi_status status;
 	struct acpi_gpe_register_info *gpe_register_info;
+	u8 enable_mask;
 
 	/* NOTE: assumes that all GPEs are currently disabled */
 
@@ -410,9 +422,10 @@ acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 		/* Enable all "runtime" GPEs in this register */
 
+		enable_mask = gpe_register_info->enable_for_run &
+		    ~gpe_register_info->mask_for_run;
 		status =
-		    acpi_hw_gpe_enable_write(gpe_register_info->enable_for_run,
-					     gpe_register_info);
+		    acpi_hw_gpe_enable_write(enable_mask, gpe_register_info);
 		if (ACPI_FAILURE(status)) {
 			return (status);
 		}
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 875964d..c2d4b9c 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -736,6 +736,10 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 						u32 gpe_number))
 
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_mask_gpe(acpi_handle gpe_device,
+					      u32 gpe_number, u8 is_masked))
+
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_mark_gpe_for_wake(acpi_handle gpe_device,
 						       u32 gpe_number))
 
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index cb389ef..fa4bd6a 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -732,16 +732,17 @@ typedef u32 acpi_event_type;
  * The encoding of acpi_event_status is illustrated below.
  * Note that a set bit (1) indicates the property is TRUE
  * (e.g. if bit 0 is set then the event is enabled).
- * +-------------+-+-+-+-+-+
- * |   Bits 31:5 |4|3|2|1|0|
- * +-------------+-+-+-+-+-+
- *          |     | | | | |
- *          |     | | | | +- Enabled?
- *          |     | | | +--- Enabled for wake?
- *          |     | | +----- Status bit set?
- *          |     | +------- Enable bit set?
- *          |     +--------- Has a handler?
- *          +--------------- <Reserved>
+ * +-------------+-+-+-+-+-+-+
+ * |   Bits 31:6 |5|4|3|2|1|0|
+ * +-------------+-+-+-+-+-+-+
+ *          |     | | | | | |
+ *          |     | | | | | +- Enabled?
+ *          |     | | | | +--- Enabled for wake?
+ *          |     | | | +----- Status bit set?
+ *          |     | | +------- Enable bit set?
+ *          |     | +--------- Has a handler?
+ *          |     +----------- Masked?
+ *          +----------------- <Reserved>
  */
 typedef u32 acpi_event_status;
 
@@ -751,6 +752,7 @@ typedef u32 acpi_event_status;
 #define ACPI_EVENT_FLAG_STATUS_SET      (acpi_event_status) 0x04
 #define ACPI_EVENT_FLAG_ENABLE_SET      (acpi_event_status) 0x08
 #define ACPI_EVENT_FLAG_HAS_HANDLER     (acpi_event_status) 0x10
+#define ACPI_EVENT_FLAG_MASKED          (acpi_event_status) 0x20
 #define ACPI_EVENT_FLAG_SET             ACPI_EVENT_FLAG_STATUS_SET
 
 /* Actions for acpi_set_gpe, acpi_gpe_wakeup, acpi_hw_low_set_gpe */
@@ -761,14 +763,15 @@ typedef u32 acpi_event_status;
 
 /*
  * GPE info flags - Per GPE
- * +-------+-+-+---+
- * |  7:5  |4|3|2:0|
- * +-------+-+-+---+
- *     |    | |  |
- *     |    | |  +-- Type of dispatch:to method, handler, notify, or none
- *     |    | +----- Interrupt type: edge or level triggered
- *     |    +------- Is a Wake GPE
- *     +------------ <Reserved>
+ * +---+-+-+-+---+
+ * |7:6|5|4|3|2:0|
+ * +---+-+-+-+---+
+ *   |  | | |  |
+ *   |  | | |  +-- Type of dispatch:to method, handler, notify, or none
+ *   |  | | +----- Interrupt type: edge or level triggered
+ *   |  | +------- Is a Wake GPE
+ *   |  +--------- Is GPE masked by the software GPE masking machanism
+ *   +------------ <Reserved>
  */
 #define ACPI_GPE_DISPATCH_NONE          (u8) 0x00
 #define ACPI_GPE_DISPATCH_METHOD        (u8) 0x01
-- 
1.7.10

