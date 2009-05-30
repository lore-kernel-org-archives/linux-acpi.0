From: Len Brown <lenb@kernel.org>
Subject: [PATCH 48/65] ACPI: processor: check for synthetic _HID,
 default to "Device" declaration
Date: Fri, 29 May 2009 21:42:26 -0400
Message-ID: <6cc73b4806c07b4207780f6d85c456b4c5b29d71.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:39590 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757420AbZE3BnG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:06 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF0067VORPV7E3@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:02 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This patch inverts the logic that distinguishes "Processor" statements
from "Device" statements, so we now check explicitly for "Processor" and
default to "Device".  This removes the only real use of ACPI_PROCESSOR_HID,
so we can then remove the #define.  It also has the theoretical advantage
that if a new processor _HID were ever added, we wouldn't have to change
the code here.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_core.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 45ad328..cf627d6 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -596,7 +596,21 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "No bus mastering arbitration control\n"));
 
-	if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_HID)) {
+	if (!strcmp(acpi_device_hid(device), ACPI_PROCESSOR_OBJECT_HID)) {
+		/* Declared with "Processor" statement; match ProcessorID */
+		status = acpi_evaluate_object(pr->handle, NULL, NULL, &buffer);
+		if (ACPI_FAILURE(status)) {
+			printk(KERN_ERR PREFIX "Evaluating processor object\n");
+			return -ENODEV;
+		}
+
+		/*
+		 * TBD: Synch processor ID (via LAPIC/LSAPIC structures) on SMP.
+		 *      >>> 'acpi_get_processor_id(acpi_id, &id)' in
+		 *      arch/xxx/acpi.c
+		 */
+		pr->acpi_id = object.processor.proc_id;
+	} else {
 		/*
 		 * Declared with "Device" statement; match _UID.
 		 * Note that we don't handle string _UIDs yet.
@@ -611,20 +625,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
 		}
 		device_declaration = 1;
 		pr->acpi_id = value;
-	} else {
-		/* Declared with "Processor" statement; match ProcessorID */
-		status = acpi_evaluate_object(pr->handle, NULL, NULL, &buffer);
-		if (ACPI_FAILURE(status)) {
-			printk(KERN_ERR PREFIX "Evaluating processor object\n");
-			return -ENODEV;
-		}
-
-		/*
-		 * TBD: Synch processor ID (via LAPIC/LSAPIC structures) on SMP.
-		 *      >>> 'acpi_get_processor_id(acpi_id, &id)' in
-		 *      arch/xxx/acpi.c
-		 */
-		pr->acpi_id = object.processor.proc_id;
 	}
 	cpu_index = get_cpu_id(pr->handle, device_declaration, pr->acpi_id);
 
-- 
1.6.0.6

