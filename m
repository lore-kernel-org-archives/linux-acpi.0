From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH v2] ACPI: Evaluate _PS3 when entering D3 Cold
Date: Wed, 25 Apr 2012 12:29:50 +0800
Message-ID: <1335328190-5748-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:5332
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751416Ab2DYEaT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Apr 2012 00:30:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>
Cc: Lin Ming <ming.m.lin@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Lu <aaron.lu@amd.com>, Andiry Xu <andiry.xu@amd.com>, Alex He <alex.he@amd.com>

V2: set D3 Cold's explicit_set flag in acpi_bus_get_power_flags if _PS3
exists as suggested by Rafael and modify the way to change object_name
to _PS3 from _PS4 when doing explicit set to enter D3 Cold.
The patch is based on top of Lin Ming's ACPI D3 clean up patch.

V1: When entering D3 Cold from a lower device power state(higher power),
evaluate _PS3 before doing power transition.

Signed-off-by: Aaron Lu <aaron.lu@amd.com>
Cc: Andiry Xu <andiry.xu@amd.com>
Cc: Alex He <alex.he@amd.com>
---
 drivers/acpi/bus.c  |    3 +++
 drivers/acpi/scan.c |    4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 3263b68..3a7860f 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -273,6 +273,9 @@ static int __acpi_bus_set_power(struct acpi_device *device, int state)
 		}
 	} else {
 		if (device->power.states[state].flags.explicit_set) {
+			/* Evaluate _PS3 when entering D3cold */
+			if (state == ACPI_STATE_D3)
+				object_name[3] = '3';
 			status = acpi_evaluate_object(device->handle,
 						      object_name, NULL, NULL);
 			if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7417267..27906d0 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -908,6 +908,10 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
 	device->power.states[ACPI_STATE_D3].flags.valid = 1;
 	device->power.states[ACPI_STATE_D3].power = 0;
 
+	/* Also set D3cold's explicit flag when _PS3 exists */
+	if (device->power.states[ACPI_STATE_D3_HOT].flags.explicit_set)
+		device->power.states[ACPI_STATE_D3].flags.explicit_set = 1;
+
 	acpi_bus_init_power(device);
 
 	return 0;
-- 
1.7.9.6


