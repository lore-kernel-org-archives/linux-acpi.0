From: aaron lu <aaron.lu@amd.com>
Subject: [PATCH] ACPI, execute _PSx control method if exists during device
 power init phase
Date: Thu, 26 May 2011 15:39:41 +0800
Message-ID: <1306395581.10256.9.camel@torpedo-aaron.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:40417 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934Ab1EZHju convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 May 2011 03:39:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, arindam.nath@amd.com, henry.su@amd.com

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

This could also solve the problem I encountered, please see:
http://marc.info/?l=linux-acpi&m=130579961021505&w=2

Signed-off-by: Aaron Lu <aaron.lu@amd.com>
---
 drivers/acpi/bus.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9749980..71c9e35 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -339,6 +339,18 @@ int acpi_bus_init_power(struct acpi_device *device)
 
 	if (device->power.flags.power_resources)
 		result = acpi_power_on_resources(device, state);
+	if (result)
+		return result;
+
+	/* if _PSx exists, execute it */
+	if (device->power.states[state].flags.explicit_set) {
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

