From: Zhang Rui <rui.zhang@intel.com>
Subject: [RESEND] [RFC PATCH 6/6] ACPI: set waking vectors in all FACS
	tables
Date: Wed, 12 Nov 2008 16:29:12 +0800
Message-ID: <1226478552.15014.176.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26944 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbYKLIbm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Nov 2008 03:31:42 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>


Set the waking vectors in all FACS tables
in acpi_gbl_root_table_list.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/hardware/hwsleep.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c	2008-11-13 04:29:35.000000000 +0800
+++ linux-2.6/drivers/acpi/hardware/hwsleep.c	2008-11-13 04:29:43.000000000 +0800
@@ -90,6 +90,16 @@
 
 	facs->firmware_waking_vector = (u32)physical_address;
 
+	status = acpi_get_table(ACPI_SIG_FACS, 2,
+		ACPI_CAST_INDIRECT_PTR(struct acpi_table_header, &facs));
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(AE_OK);
+
+	if (facs->version >= 1)
+		facs->xfirmware_waking_vector = 0;
+
+	facs->firmware_waking_vector = (u32)physical_address;
+
 	return_ACPI_STATUS(AE_OK);
 }
 


