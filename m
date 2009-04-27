From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/3] ACPI: processor: check for synthetic _HID,
	default to "Device" declaration
Date: Mon, 27 Apr 2009 16:33:41 -0600
Message-ID: <20090427223341.16549.57263.stgit@bob.kio>
References: <20090427223244.16549.99553.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:9308 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757759AbZD0Wdl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Apr 2009 18:33:41 -0400
In-Reply-To: <20090427223244.16549.99553.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This patch inverts the logic that distinguishes "Processor" statements
from "Device" statements, so we now check explicitly for "Processor" and
default to "Device".  This removes the only real use of ACPI_PROCESSOR_HID,
so we can then remove the #define.  It also has the theoretical advantage
that if a new processor _HID were ever added, we wouldn't have to change
the code here.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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
 

