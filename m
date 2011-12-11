From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/18] ACPI 5.0: Allow _AEI method in walk resources
Date: Sun, 11 Dec 2011 12:45:47 -0500
Message-ID: <5be1feb6a1e7a4ea385b52e64deab3374138c12a.1323625426.git.len.brown@intel.com>
References: <1323625549-10775-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36856 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab1LKS0p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Dec 2011 13:26:45 -0500
Received: from localhost.localdomain ([unknown] [74.104.158.190])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LW10020XXWDDIBB@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 11 Dec 2011 12:26:44 -0600 (CST)
In-reply-to: <1323625549-10775-1-git-send-email-lenb@kernel.org>
In-reply-to: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
References: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

_AEI contains a resource template, this change adds support for
the walk resources function.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/rsxface.c |   10 ++++++----
 include/acpi/acnames.h        |    1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/rsxface.c b/drivers/acpi/acpica/rsxface.c
index 45a9e5e..f6cceac 100644
--- a/drivers/acpi/acpica/rsxface.c
+++ b/drivers/acpi/acpica/rsxface.c
@@ -526,8 +526,9 @@ acpi_rs_match_vendor_resource(struct acpi_resource *resource, void *context)
  *
  * PARAMETERS:  device_handle   - Handle to the device object for the
  *                                device we are querying
- *              Name            - Method name of the resources we want
- *                                (METHOD_NAME__CRS or METHOD_NAME__PRS)
+ *              Name            - Method name of the resources we want.
+ *                                (METHOD_NAME__CRS, METHOD_NAME__PRS, or
+ *                                METHOD_NAME__AEI)
  *              user_function   - Called for each resource
  *              Context         - Passed to user_function
  *
@@ -554,11 +555,12 @@ acpi_walk_resources(acpi_handle device_handle,
 
 	if (!device_handle || !user_function || !name ||
 	    (!ACPI_COMPARE_NAME(name, METHOD_NAME__CRS) &&
-	     !ACPI_COMPARE_NAME(name, METHOD_NAME__PRS))) {
+	     !ACPI_COMPARE_NAME(name, METHOD_NAME__PRS) &&
+	     !ACPI_COMPARE_NAME(name, METHOD_NAME__AEI))) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Get the _CRS or _PRS resource list */
+	/* Get the _CRS/_PRS/_AEI resource list */
 
 	buffer.length = ACPI_ALLOCATE_LOCAL_BUFFER;
 	status = acpi_rs_get_method_data(device_handle, name, &buffer);
diff --git a/include/acpi/acnames.h b/include/acpi/acnames.h
index fc1575f..5b5af0d 100644
--- a/include/acpi/acnames.h
+++ b/include/acpi/acnames.h
@@ -58,6 +58,7 @@
 #define METHOD_NAME__PRT        "_PRT"
 #define METHOD_NAME__CRS        "_CRS"
 #define METHOD_NAME__PRS        "_PRS"
+#define METHOD_NAME__AEI        "_AEI"
 #define METHOD_NAME__PRW        "_PRW"
 #define METHOD_NAME__SRS        "_SRS"
 
-- 
1.7.7.rc0.72.g4b5ea

