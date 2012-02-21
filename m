From: <alex.he@amd.com>
Subject: [PATCH] ACPI: Clean redundant codes in scan.c
Date: Tue, 21 Feb 2012 16:58:10 +0800
Message-ID: <1329814690-9313-1-git-send-email-alex.he@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:42432 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752174Ab2BUI6Y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Feb 2012 03:58:24 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Alex He <alex.he@amd.com>

From: Alex He <alex.he@amd.com>

Clean the redundant codes of apci_bus_get_power_flags().

Signed-off-by: Alex He <alex.he@amd.com>
---
 drivers/acpi/scan.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8ab80ba..5d24a17 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -880,7 +880,6 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
 			int j;
 
 			device->power.flags.power_resources = 1;
-			ps->flags.valid = 1;
 			for (j = 0; j < ps->resources.count; j++)
 				acpi_bus_add_power_resource(ps->resources.handles[j]);
 		}
@@ -888,10 +887,8 @@ static int acpi_bus_get_power_flags(struct acpi_device *device)
 		/* Evaluate "_PSx" to see if we can do explicit sets */
 		object_name[2] = 'S';
 		status = acpi_get_handle(device->handle, object_name, &handle);
-		if (ACPI_SUCCESS(status)) {
+		if (ACPI_SUCCESS(status))
 			ps->flags.explicit_set = 1;
-			ps->flags.valid = 1;
-		}
 
 		/* State is valid if we have some power control */
 		if (ps->resources.count || ps->flags.explicit_set)
-- 
1.7.1


