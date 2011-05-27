From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH v2] ACPI: execute _PSx control method if exists during device power init phase
Date: Fri, 27 May 2011 11:32:26 +0800
Message-ID: <1306467146-5994-1-git-send-email-aaron.lu@amd.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37690 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab1E0DdZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 May 2011 23:33:25 -0400
Received: by ywe9 with SMTP id 9so580312ywe.19
        for <linux-acpi@vger.kernel.org>; Thu, 26 May 2011 20:33:25 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, arindam.nath@amd.com, henry.su@amd.com, mjg59@srcf.ucam.org, Aaron Lu <aaron.lu@amd.com>

V2:
Added a check to the power state, make sure it's valid before executing
the _PSx control method.

V1:
Per the acpi spec, for OSPM to put the device in the Dx device state,
the following must occur:
1. All Power Resources referenced by elements 1 through N must be in the
ON state.
2. All Power Resources no longer referenced by any device in the system
must be in the OFF state.
3. If present, the _PSx control method is executed to set the device
into the Dx device state.

This patch adds support for the execution of _PSx control method during
device power init phase.

This could also solves the problem I encountered, please see:
http://marc.info/?l=linux-acpi&m=130579961021505&w=2
---
 drivers/acpi/bus.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9749980..ea4eb64 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -337,8 +337,22 @@ int acpi_bus_init_power(struct acpi_device *device)
 	if (result)
 		return result;
 
-	if (device->power.flags.power_resources)
+	if (device->power.flags.power_resources) {
 		result = acpi_power_on_resources(device, state);
+		if (result)
+			return result;
+	}
+
+	/* if state is valid and _PSx exists, execute it */
+	if (state >= ACPI_STATE_D0 && state <= ACPI_STATE_D3 &&
+		device->power.states[state].flags.explicit_set) {
+		acpi_status status;
+		char object_name[5] = { '_', 'P', 'S', '0' + state, '\0' };
+		status = acpi_evaluate_object(device->handle, object_name,
+				NULL, NULL);
+		if (ACPI_FAILURE(status))
+			result = -ENODEV;
+	}
 
 	if (!result)
 		device->power.state = state;
-- 
1.7.4.4

