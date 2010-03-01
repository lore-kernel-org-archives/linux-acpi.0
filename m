From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/9] ACPICA: AcpiGetDevices: Eliminate unnecessary _STA calls
Date: Mon, 01 Mar 2010 01:56:12 -0500
Message-ID: <5f8902acf87aa206ee4b3f633104456d82747ca6.1267426486.git.len.brown@intel.com>
References: <1267426578-4406-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:50578 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab0CAG4h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 01:56:37 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KYL001MJCLW5RE0@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Mar 2010 00:56:26 -0600 (CST)
In-reply-to: <1267426578-4406-1-git-send-email-lenb@kernel.org>
In-reply-to: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
References: <2147d3f00f85c9e993786863d8138694672da01b.1267426486.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

In the case where a specific _HID is requested, do not run _STA
until a _HID match is found. This eliminates potentially dozens
of _STA calls during a search for a particular device/HID.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsxfeval.c |   52 +++++++++++++++++++++++++--------------
 1 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index c5a5357..ebef8a7 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -562,25 +562,20 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 		return (AE_BAD_PARAMETER);
 	}
 
-	/* Run _STA to determine if device is present */
-
-	status = acpi_ut_execute_STA(node, &flags);
-	if (ACPI_FAILURE(status)) {
-		return (AE_CTRL_DEPTH);
-	}
-
-	if (!(flags & ACPI_STA_DEVICE_PRESENT) &&
-	    !(flags & ACPI_STA_DEVICE_FUNCTIONING)) {
-		/*
-		 * Don't examine the children of the device only when the
-		 * device is neither present nor functional. See ACPI spec,
-		 * description of _STA for more information.
-		 */
-		return (AE_CTRL_DEPTH);
-	}
-
-	/* Filter based on device HID & CID */
-
+	/*
+	 * First, filter based on the device HID and CID.
+	 *
+	 * 01/2010: For this case where a specific HID is requested, we don't
+	 * want to run _STA until we have an actual HID match. Thus, we will
+	 * not unnecessarily execute _STA on devices for which the caller
+	 * doesn't care about. Previously, _STA was executed unconditionally
+	 * on all devices found here.
+	 *
+	 * A side-effect of this change is that now we will continue to search
+	 * for a matching HID even under device trees where the parent device
+	 * would have returned a _STA that indicates it is not present or
+	 * not functioning (thus aborting the search on that branch).
+	 */
 	if (info->hid != NULL) {
 		status = acpi_ut_execute_HID(node, &hid);
 		if (status == AE_NOT_FOUND) {
@@ -620,6 +615,25 @@ acpi_ns_get_device_callback(acpi_handle obj_handle,
 		}
 	}
 
+	/* Run _STA to determine if device is present */
+
+	status = acpi_ut_execute_STA(node, &flags);
+	if (ACPI_FAILURE(status)) {
+		return (AE_CTRL_DEPTH);
+	}
+
+	if (!(flags & ACPI_STA_DEVICE_PRESENT) &&
+	    !(flags & ACPI_STA_DEVICE_FUNCTIONING)) {
+		/*
+		 * Don't examine the children of the device only when the
+		 * device is neither present nor functional. See ACPI spec,
+		 * description of _STA for more information.
+		 */
+		return (AE_CTRL_DEPTH);
+	}
+
+	/* We have a valid device, invoke the user function */
+
 	status = info->user_function(obj_handle, nesting_level, info->context,
 				     return_value);
 	return (status);
-- 
1.6.0.6

