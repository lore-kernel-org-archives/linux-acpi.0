From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH] ACPI:avoid printing the error message that processor
	device is not present
Date: Mon, 08 Oct 2007 11:35:18 +0800
Message-ID: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11085 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbXJHD21 (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Sun, 7 Oct 2007 23:28:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Linux-acpi@vger.kernel.org

Subject: ACPI: avoid printing the info that processor device is not present
From: Zhao Yakui  <yakui.zhao@intel.com>

Four processors are defined in the DSDT table, which means that quad-core cpu
is supported. But dual-core cpu is installed on the system. In the
initialization OS will check whether the defined processor exists. If it 
doesn't exist, it will print the info that processor device is not present.
The above error message has no effect on the system but it will mislead us.
So it is unnecessary to print the error message when disabling acpi debug.

http://bugzilla.kernel.org/show_bug.cgi?id=8630

Signed-off-by: Zhao Yakui  <yakui.zhao@intel.com>
---
 drivers/acpi/processor_core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.23-rc7/drivers/acpi/processor_core.c
===================================================================
--- linux-2.6.23-rc7.orig/drivers/acpi/processor_core.c
+++ linux-2.6.23-rc7/drivers/acpi/processor_core.c
@@ -813,7 +813,9 @@ static int is_processor_present(acpi_han
 
 	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
 	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT)) {
-		ACPI_EXCEPTION((AE_INFO, status, "Processor Device is not present"));
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"%s :Processor Device is not present",
+			acpi_format_exception(status)));
 		return 0;
 	}
 	return 1;

