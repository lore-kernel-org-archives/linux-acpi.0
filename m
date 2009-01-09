From: Len Brown <lenb@kernel.org>
Subject: [PATCH 76/94] ACPICA: New: acpi_reset interface - write to reset
 register
Date: Fri, 09 Jan 2009 04:27:18 -0500
Message-ID: <d3fd902d1ed43aebfc407c08d7ce86495604124c.1231492611.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:56614 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746AbZAIKR7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 05:17:59 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700LXC8LRL4S7@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 04:17:59 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Uses the FADT-defined reset register and reset value. Checks the
FADT flags for the reset register supported bit. Supports reset
register in memory or I/O space, but not in PCI config space
since the host has the information to do it.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/hardware/hwxface.c |   37 +++++++++++++++++++++++++++++++++++++
 include/acpi/acpixf.h           |    2 ++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/hardware/hwxface.c b/drivers/acpi/hardware/hwxface.c
index b6244a0..0601ed7 100644
--- a/drivers/acpi/hardware/hwxface.c
+++ b/drivers/acpi/hardware/hwxface.c
@@ -50,6 +50,43 @@ ACPI_MODULE_NAME("hwxface")
 
 /******************************************************************************
  *
+ * FUNCTION:    acpi_reset
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Set reset register in memory or IO space. Note: Does not
+ *              support reset register in PCI config space, this must be
+ *              handled separately.
+ *
+ ******************************************************************************/
+acpi_status acpi_reset(void)
+{
+	struct acpi_generic_address *reset_reg;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_reset);
+
+	reset_reg = &acpi_gbl_FADT.reset_register;
+
+	/* Check if the reset register is supported */
+
+	if (!(acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) ||
+	    !reset_reg->address) {
+		return_ACPI_STATUS(AE_NOT_EXIST);
+	}
+
+	/* Write the reset value to the reset register */
+
+	status = acpi_write(acpi_gbl_FADT.reset_value, reset_reg);
+	return_ACPI_STATUS(status);
+}
+
+ACPI_EXPORT_SYMBOL(acpi_reset)
+
+/******************************************************************************
+ *
  * FUNCTION:    acpi_read
  *
  * PARAMETERS:  Value               - Where the value is returned
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 030aeb5..b3bcead 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -322,6 +322,8 @@ acpi_resource_to_address64(struct acpi_resource *resource,
 /*
  * Hardware (ACPI device) interfaces
  */
+acpi_status acpi_reset(void);
+
 acpi_status acpi_get_register(u32 register_id, u32 * return_value);
 
 acpi_status acpi_get_register_unlocked(u32 register_id, u32 *return_value);
-- 
1.5.6.6

