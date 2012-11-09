From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 1/2] acpi: introduce swset flag for power_state
Date: Fri,  9 Nov 2012 09:54:55 +0800
Message-ID: <1352426096-15116-2-git-send-email-aaron.lu@intel.com>
References: <1352426096-15116-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64573 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627Ab2KIBzG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Nov 2012 20:55:06 -0500
In-Reply-To: <1352426096-15116-1-git-send-email-aaron.lu@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Currently we have valid flag to represent if this ACPI device power
state is valid. A device power state is valid does not necessarily mean
we, as OSPM, has a mean to put the device into that power state, e.g. D3
cold is always a valid power state for any ACPI device, but if there is
no _PS3 or _PRx for this device, we can't really put that device into
D3 cold power state. The same is true for D0 power state.

So here comes the swset flag, which is only set if the device has
provided us the required means to put it into that power state, e.g. if
we have _PS3 or _PRx, we can put the device into D3 cold state and thus,
D3 cold power state's swset flag will be set in this case.

This flag is mainly used to check if firmware has provided us a way to
put the device into D3 cold state, as the valid flag for D3 cold is
always true.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/scan.c     | 9 ++++++++-
 include/acpi/acpi_bus.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 95ff1e8..60d271a 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1038,8 +1038,10 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
 		 * D3hot is only valid if _PR3 present.
 		 */
 		if (ps->resources.count ||
-		    (ps->flags.explicit_set && i < ACPI_STATE_D3_HOT))
+		    (ps->flags.explicit_set && i < ACPI_STATE_D3_HOT)) {
 			ps->flags.valid = 1;
+			ps->flags.swset = 1;
+		}
 
 		ps->power = -1;	/* Unknown - driver assigned */
 		ps->latency = -1;	/* Unknown - driver assigned */
@@ -1055,6 +1057,11 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
 	if (device->power.states[ACPI_STATE_D3_HOT].flags.explicit_set)
 		device->power.states[ACPI_STATE_D3_COLD].flags.explicit_set = 1;
 
+	/* Presence of _PS3 or _PRx means we can put the device into D3 cold */
+	if (device->power.states[ACPI_STATE_D3_HOT].flags.explicit_set ||
+			device->power.flags.power_resources)
+		device->power.states[ACPI_STATE_D3_COLD].flags.swset = 1;
+
 	acpi_bus_init_power(device);
 
 	return 0;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 2242c10..7d20617 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -200,6 +200,7 @@ struct acpi_device_power_flags {
 struct acpi_device_power_state {
 	struct {
 		u8 valid:1;
+		u8 swset:1;
 		u8 explicit_set:1;	/* _PSx present? */
 		u8 reserved:6;
 	} flags;
-- 
1.7.12.4

