From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 2/2] acpi: add function to check if poweroff is possible
Date: Fri,  9 Nov 2012 09:54:56 +0800
Message-ID: <1352426096-15116-3-git-send-email-aaron.lu@intel.com>
References: <1352426096-15116-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:54338 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757259Ab2KIBzI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Nov 2012 20:55:08 -0500
In-Reply-To: <1352426096-15116-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

>From ACPI's perspective, a device is powered off if we put it into D3
cold power state. This wrapper inline function can be used to check if
firmware has provided us a way to power off the device during runtime.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 include/acpi/acpi_bus.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 7d20617..932977a 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -496,6 +496,11 @@ static inline bool acpi_device_can_wakeup(struct acpi_device *adev)
 	return adev->wakeup.flags.valid;
 }
 
+static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
+{
+	return adev->power.states[ACPI_STATE_D3_COLD].flags.swset;
+}
+
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
1.7.12.4

