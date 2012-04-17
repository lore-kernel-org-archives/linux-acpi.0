From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 1/6] ACPI: D3cold state is always valid
Date: Tue, 17 Apr 2012 13:47:51 +0800
Message-ID: <1334641676-14566-2-git-send-email-ming.m.lin@intel.com>
References: <1334641676-14566-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:49201 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055Ab2DQFsK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Apr 2012 01:48:10 -0400
In-Reply-To: <1334641676-14566-1-git-send-email-ming.m.lin@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.og>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Huang Ying <huang.ying.caritas@gmail.com>, Aaron Lu <aaron.lu@amd.com>

ACPI_STATE_D3 actually means ACPI D3hot which is not always valid.
Instead, ACPI D3cold is always valid.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/scan.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 767e2dc..fb56388 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -884,13 +884,6 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
 				acpi_bus_add_power_resource(ps->resources.handles[j]);
 		}
 
-		/* The exist of _PR3 indicates D3Cold support */
-		if (i == ACPI_STATE_D3) {
-			status = acpi_get_handle(device->handle, object_name, &handle);
-			if (ACPI_SUCCESS(status))
-				device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
-		}
-
 		/* Evaluate "_PSx" to see if we can do explicit sets */
 		object_name[2] = 'S';
 		status = acpi_get_handle(device->handle, object_name, &handle);
@@ -908,8 +901,8 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
 	/* Set defaults for D0 and D3 states (always valid) */
 	device->power.states[ACPI_STATE_D0].flags.valid = 1;
 	device->power.states[ACPI_STATE_D0].power = 100;
-	device->power.states[ACPI_STATE_D3].flags.valid = 1;
-	device->power.states[ACPI_STATE_D3].power = 0;
+	device->power.states[ACPI_STATE_D3_COLD].flags.valid = 1;
+	device->power.states[ACPI_STATE_D3_COLD].power = 0;
 
 	acpi_bus_init_power(device);
 
-- 
1.7.2.5

