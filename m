From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH 1/4]  ACPI: Attach the ACPI device to the ACPI handle as
	early as possible
Date: Mon, 14 Jul 2008 15:35:42 +0800
Message-ID: <1216020942.32159.17.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5402 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754683AbYGNHY2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jul 2008 03:24:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org

From: Zhao Yakui <yakui.zhao@intel.com>

Attach the ACPI device to the ACPI handle as early as possible so that OS
can get the corresponding ACPI device by the acpi handle in the course
of getting the power/wakeup/performance flags.

http://bugzilla.kernel.org/show_bug.cgi?id=8049
http://bugzilla.kernel.org/show_bug.cgi?id=11000

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/scan.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -1270,6 +1270,16 @@ acpi_add_single_object(struct acpi_devic
 	acpi_device_set_id(device, parent, handle, type);
 
 	/*
+	 * The ACPI device is attached to acpi handle before getting
+	 * the power/wakeup/peformance flags. Otherwise OS can't get
+	 * the corresponding ACPI device by the acpi handle in the course
+	 * of getting the power/wakeup/performance flags.
+	 */
+	result = acpi_device_set_context(device, type);
+	if (result)
+		goto end;
+
+	/*
 	 * Power Management
 	 * ----------------
 	 */
@@ -1299,8 +1309,6 @@ acpi_add_single_object(struct acpi_devic
 			goto end;
 	}
 
-	if ((result = acpi_device_set_context(device, type)))
-		goto end;
 
 	result = acpi_device_register(device, parent);
 


