From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v2] acpi: introduce os_accessible flag for power_state
Date: Wed, 21 Nov 2012 20:24:20 +0800
Message-ID: <50ACC7F4.7060401@intel.com>
References: <1352426096-15116-1-git-send-email-aaron.lu@intel.com> <1352426096-15116-2-git-send-email-aaron.lu@intel.com> <1488423.HT0sLzAmeT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:45880 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511Ab2KUMYF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Nov 2012 07:24:05 -0500
In-Reply-To: <1488423.HT0sLzAmeT@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Currently we have valid flag to represent if this ACPI device power
state is valid. A device power state is valid does not necessarily
mean we, as OSPM, has a mean to put the device into that power state,
e.g. D3 cold is always a valid power state for any ACPI device, but if
there is no _PS3 or _PRx for this device, we can't really put that
device into D3 cold power state. The same is true for D0 power state.

So here comes the os_accessible flag, which is only set if the device
has provided us the required means to put it into that power state,
e.g. if we have _PS3 or _PRx, we can put the device into D3 cold state
and thus, D3 cold power state's os_accessible flag will be set in this
case.

And a new wrapper inline function is added to be used to check if
firmware has provided us a way to power off the device during runtime.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
v2:
Rename swset to os_accessible as suggested by Rafael Wysocki.
Fold patch 2 into patch 1 as suggested by Rafael Wysocki.

 drivers/acpi/scan.c     | 9 ++++++++-
 include/acpi/acpi_bus.h | 6 ++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3c646e6..f250c5b 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1062,8 +1062,10 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
 		 * D3hot is only valid if _PR3 present.
 		 */
 		if (ps->resources.count ||
-		    (ps->flags.explicit_set && i < ACPI_STATE_D3_HOT))
+		    (ps->flags.explicit_set && i < ACPI_STATE_D3_HOT)) {
 			ps->flags.valid = 1;
+			ps->flags.os_accessible = 1;
+		}
 
 		ps->power = -1;	/* Unknown - driver assigned */
 		ps->latency = -1;	/* Unknown - driver assigned */
@@ -1079,6 +1081,11 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
 	if (device->power.states[ACPI_STATE_D3_HOT].flags.explicit_set)
 		device->power.states[ACPI_STATE_D3_COLD].flags.explicit_set = 1;
 
+	/* Presence of _PS3 or _PRx means we can put the device into D3 cold */
+	if (device->power.states[ACPI_STATE_D3_HOT].flags.explicit_set ||
+			device->power.flags.power_resources)
+		device->power.states[ACPI_STATE_D3_COLD].flags.os_accessible = 1;
+
 	acpi_bus_init_power(device);
 
 	return 0;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index ce77cd7..644d941 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -201,6 +201,7 @@ struct acpi_device_power_flags {
 struct acpi_device_power_state {
 	struct {
 		u8 valid:1;
+		u8 os_accessible:1;
 		u8 explicit_set:1;	/* _PSx present? */
 		u8 reserved:6;
 	} flags;
@@ -500,6 +501,11 @@ static inline bool acpi_device_can_wakeup(struct acpi_device *adev)
 	return adev->wakeup.flags.valid;
 }
 
+static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
+{
+	return adev->power.states[ACPI_STATE_D3_COLD].flags.os_accessible;
+}
+
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
-- 
1.7.12.4
