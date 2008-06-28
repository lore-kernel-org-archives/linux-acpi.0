From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/84] Make GPE disable more robust
Date: Sat, 28 Jun 2008 01:43:17 -0400
Message-ID: <a7f34ae2abc9cb51a5b906f2da0aaa697f1a8883.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:50450 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbYF1Fo7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:44:59 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K35001ZIRYP7OTH@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:44:50 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Implemented another change for the GPE disable. We now perform a
read-change-write of the enable register instead of simply writing out the
cached enable mask. This will prevent inadvertent enabling of GPEs if a rogue
GPE is received during initialization (before GPE handlers are installed.)

http://bugzilla.kernel.org/show_bug.cgi?id=6217

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evgpe.c   |   18 +++++++++++---
 drivers/acpi/hardware/hwgpe.c |   50 ++++++++++++++++++++++++++++++++++++++++-
 include/acpi/achware.h        |    2 +
 3 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/events/evgpe.c b/drivers/acpi/events/evgpe.c
index 5354be4..e0339d4 100644
--- a/drivers/acpi/events/evgpe.c
+++ b/drivers/acpi/events/evgpe.c
@@ -256,7 +256,7 @@ acpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 		return_ACPI_STATUS(status);
 	}
 
-	/* Mark wake-disabled or HW disable, or both */
+	/* Clear the appropriate enabled flags for this GPE */
 
 	switch (gpe_event_info->flags & ACPI_GPE_TYPE_MASK) {
 	case ACPI_GPE_TYPE_WAKE:
@@ -273,13 +273,23 @@ acpi_status acpi_ev_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
 		/* Disable the requested runtime GPE */
 
 		ACPI_CLEAR_BIT(gpe_event_info->flags, ACPI_GPE_RUN_ENABLED);
-
-		/* fallthrough */
+		break;
 
 	default:
-		acpi_hw_write_gpe_enable_reg(gpe_event_info);
+		break;
 	}
 
+	/*
+	 * Even if we don't know the GPE type, make sure that we always
+	 * disable it. low_disable_gpe will just clear the enable bit for this
+	 * GPE and write it. It will not write out the current GPE enable mask,
+	 * since this may inadvertently enable GPEs too early, if a rogue GPE has
+	 * come in during ACPICA initialization - possibly as a result of AML or
+	 * other code that has enabled the GPE.
+	 */
+	status = acpi_hw_low_disable_gpe(gpe_event_info);
+	return_ACPI_STATUS(status);
+
 	return_ACPI_STATUS(AE_OK);
 }
 
diff --git a/drivers/acpi/hardware/hwgpe.c b/drivers/acpi/hardware/hwgpe.c
index 14bc4f4..6a14832 100644
--- a/drivers/acpi/hardware/hwgpe.c
+++ b/drivers/acpi/hardware/hwgpe.c
@@ -55,6 +55,54 @@ acpi_hw_enable_wakeup_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 
 /******************************************************************************
  *
+ * FUNCTION:    acpi_hw_low_disable_gpe
+ *
+ * PARAMETERS:  gpe_event_info      - Info block for the GPE to be disabled
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Disable a single GPE in the enable register.
+ *
+ ******************************************************************************/
+
+acpi_status acpi_hw_low_disable_gpe(struct acpi_gpe_event_info *gpe_event_info)
+{
+	struct acpi_gpe_register_info *gpe_register_info;
+	acpi_status status;
+	u32 enable_mask;
+
+	/* Get the info block for the entire GPE register */
+
+	gpe_register_info = gpe_event_info->register_info;
+	if (!gpe_register_info) {
+		return (AE_NOT_EXIST);
+	}
+
+	/* Get current value of the enable register that contains this GPE */
+
+	status = acpi_hw_low_level_read(ACPI_GPE_REGISTER_WIDTH, &enable_mask,
+					&gpe_register_info->enable_address);
+	if (ACPI_FAILURE(status)) {
+		return (status);
+	}
+
+	/* Clear just the bit that corresponds to this GPE */
+
+	ACPI_CLEAR_BIT(enable_mask,
+		       ((u32) 1 <<
+			(gpe_event_info->gpe_number -
+			 gpe_register_info->base_gpe_number)));
+
+	/* Write the updated enable mask */
+
+	status = acpi_hw_low_level_write(ACPI_GPE_REGISTER_WIDTH, enable_mask,
+					 &gpe_register_info->enable_address);
+
+	return (status);
+}
+
+/******************************************************************************
+ *
  * FUNCTION:    acpi_hw_write_gpe_enable_reg
  *
  * PARAMETERS:  gpe_event_info      - Info block for the GPE to be enabled
@@ -68,7 +116,7 @@ acpi_hw_enable_wakeup_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
  ******************************************************************************/
 
 acpi_status
-acpi_hw_write_gpe_enable_reg(struct acpi_gpe_event_info *gpe_event_info)
+acpi_hw_write_gpe_enable_reg(struct acpi_gpe_event_info * gpe_event_info)
 {
 	struct acpi_gpe_register_info *gpe_register_info;
 	acpi_status status;
diff --git a/include/acpi/achware.h b/include/acpi/achware.h
index d4fb9bb..45e9859 100644
--- a/include/acpi/achware.h
+++ b/include/acpi/achware.h
@@ -87,6 +87,8 @@ acpi_status acpi_hw_clear_acpi_status(void);
 /*
  * hwgpe - GPE support
  */
+acpi_status acpi_hw_low_disable_gpe(struct acpi_gpe_event_info *gpe_event_info);
+
 acpi_status
 acpi_hw_write_gpe_enable_reg(struct acpi_gpe_event_info *gpe_event_info);
 
-- 
1.5.6.1.89.gd544

