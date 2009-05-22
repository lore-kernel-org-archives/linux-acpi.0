From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/4] ACPI: simplify notification debug messages
Date: Fri, 22 May 2009 11:43:41 -0600
Message-ID: <20090522174341.4304.95088.stgit@bob.kio>
References: <20090522174223.4304.7099.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:37878 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188AbZEVRnj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 May 2009 13:43:39 -0400
In-Reply-To: <20090522174223.4304.7099.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

This replaces several messages that depend on the acpi_device struct
with a single message that uses just the acpi_handle.  We should be
able to deal with notifications to objects that do not yet have an
acpi_device struct.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
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
 

