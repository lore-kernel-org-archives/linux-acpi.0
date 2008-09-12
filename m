From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: don't enable control method power button as wakeup
	device when Fixed Power button is used
Date: Fri, 12 Sep 2008 11:12:25 +0800
Message-ID: <1221189145.3441.117.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:34724 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbYILDMn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Sep 2008 23:12:43 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, walken@zoy.org

don't enable control method power button as wakeup device
when Fixed Power button is used.

http://bugzilla.kernel.org/show_bug.cgi?id=10503


Tested-by: walken@zoy.org <walken@zoy.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/scan.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c	2008-09-11 13:28:11.000000000 +0800
+++ linux-2.6/drivers/acpi/scan.c	2008-09-11 15:12:12.000000000 +0800
@@ -744,6 +744,16 @@
 	if (!acpi_match_device_ids(device, button_device_ids))
 		device->wakeup.flags.run_wake = 1;
 
+	/*
+	 * Don't set Power button GPE as run_wake
+	 * if Fixed Power button is used
+	 */
+	if (!strcmp(device->pnp.hardware_id, "PNP0C0C") &&
+		!(acpi_gbl_FADT.flags & ACPI_FADT_POWER_BUTTON)) {
+		device->wakeup.flags.run_wake = 0;
+		device->wakeup.flags.valid = 0;
+	}
+
       end:
 	if (ACPI_FAILURE(status))
 		device->flags.wake_capable = 0;


