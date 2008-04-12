From: Len Brown <lenb@kernel.org>
Subject: [PATCH 41/73] ACPICA: Fixed a problem with AcpiGetDevices where the search of a branch of the device tree could be terminated prematurely
Date: Sat, 12 Apr 2008 00:25:24 -0400
Message-ID: <e9b790c8b33ba03dcd200c820e178bb7473ce8cd.1207973800.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:7534 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753621AbYDLE2M (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:28:12 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

In accordance with the ACPI specification, the search is terminated
if a device is both not present and not functional (instead of
just not present.) Yakui Zhao.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nsxfeval.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index b92133f..cd97c80 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -467,10 +467,13 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 		return (AE_CTRL_DEPTH);
 	}
 
-	if (!(flags & ACPI_STA_DEVICE_PRESENT)) {
-
-		/* Don't examine children of the device if not present */
-
+	if (!(flags & ACPI_STA_DEVICE_PRESENT) &&
+	    !(flags & ACPI_STA_DEVICE_FUNCTIONING)) {
+		/*
+		 * Don't examine the children of the device only when the
+		 * device is neither present nor functional. See ACPI spec,
+		 * description of _STA for more information.
+		 */
 		return (AE_CTRL_DEPTH);
 	}
 
@@ -539,7 +542,7 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
  *              value is returned to the caller.
  *
  *              This is a wrapper for walk_namespace, but the callback performs
- *              additional filtering. Please see acpi_get_device_callback.
+ *              additional filtering. Please see acpi_ns_get_device_callback.
  *
  ******************************************************************************/
 
-- 
1.5.5.29.g7134

