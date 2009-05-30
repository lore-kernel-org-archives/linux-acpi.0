From: Len Brown <lenb@kernel.org>
Subject: [PATCH 51/65] ACPI: simplify notification debug messages
Date: Fri, 29 May 2009 21:42:29 -0400
Message-ID: <071aa4c5d085fc439f871efd8c8598736b8f81cc.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:50006 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756601AbZE3BnP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:15 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF007DAORQ7OX2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:43:02 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <len.brown@intel.com>

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

This replaces several messages that depend on the acpi_device struct
with a single message that uses just the acpi_handle.  We should be
able to deal with notifications to objects that do not yet have an
acpi_device struct.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c |   27 +++------------------------
 1 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index cdfecc0..eb98638 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -551,6 +551,9 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 	struct acpi_device *device = NULL;
 	struct acpi_driver *driver;
 
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Notification %#02x to handle %p\n",
+			  type, handle));
+
 	blocking_notifier_call_chain(&acpi_bus_notify_list,
 		type, (void *)handle);
 
@@ -560,9 +563,6 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 	switch (type) {
 
 	case ACPI_NOTIFY_BUS_CHECK:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Received BUS CHECK notification for device [%s]\n",
-				  device->pnp.bus_id));
 		result = acpi_bus_check_scope(device);
 		/*
 		 * TBD: We'll need to outsource certain events to non-ACPI
@@ -571,9 +571,6 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Received DEVICE CHECK notification for device [%s]\n",
-				  device->pnp.bus_id));
 		result = acpi_bus_check_device(device, NULL);
 		/*
 		 * TBD: We'll need to outsource certain events to non-ACPI
@@ -582,44 +579,26 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 		break;
 
 	case ACPI_NOTIFY_DEVICE_WAKE:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Received DEVICE WAKE notification for device [%s]\n",
-				  device->pnp.bus_id));
 		/* TBD */
 		break;
 
 	case ACPI_NOTIFY_EJECT_REQUEST:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Received EJECT REQUEST notification for device [%s]\n",
-				  device->pnp.bus_id));
 		/* TBD */
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK_LIGHT:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Received DEVICE CHECK LIGHT notification for device [%s]\n",
-				  device->pnp.bus_id));
 		/* TBD: Exactly what does 'light' mean? */
 		break;
 
 	case ACPI_NOTIFY_FREQUENCY_MISMATCH:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Received FREQUENCY MISMATCH notification for device [%s]\n",
-				  device->pnp.bus_id));
 		/* TBD */
 		break;
 
 	case ACPI_NOTIFY_BUS_MODE_MISMATCH:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Received BUS MODE MISMATCH notification for device [%s]\n",
-				  device->pnp.bus_id));
 		/* TBD */
 		break;
 
 	case ACPI_NOTIFY_POWER_FAULT:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Received POWER FAULT notification for device [%s]\n",
-				  device->pnp.bus_id));
 		/* TBD */
 		break;
 
-- 
1.6.0.6

