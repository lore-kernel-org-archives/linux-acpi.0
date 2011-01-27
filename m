From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / ACPICA: Avoid crashing if _PRW is defined for the root object
Date: Thu, 27 Jan 2011 23:55:46 +0100
Message-ID: <201101272355.46737.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45900 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab1A0W4V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jan 2011 17:56:21 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Some ACPI BIOSes define _PRW for the root object which causes
acpi_setup_gpe_for_wake() to crash when trying to dereference the
bogus device_node pointer.  Avoid the crash by checking if
wake_device is not the root object before attempting to set up the
"implicit notify" mechanism for it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/acpica/evxfgpe.c |   49 ++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-2.6/drivers/acpi/acpica/evxfgpe.c
@@ -212,37 +212,40 @@ acpi_setup_gpe_for_wake(acpi_handle wake
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}
 
-	/* Validate wake_device is of type Device */
-
-	device_node = ACPI_CAST_PTR(struct acpi_namespace_node, wake_device);
-	if (device_node->type != ACPI_TYPE_DEVICE) {
-		return_ACPI_STATUS(AE_BAD_PARAMETER);
-	}
-
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/* Ensure that we have a valid GPE number */
 
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
-	if (gpe_event_info) {
-		/*
-		 * If there is no method or handler for this GPE, then the
-		 * wake_device will be notified whenever this GPE fires (aka
-		 * "implicit notify") Note: The GPE is assumed to be
-		 * level-triggered (for windows compatibility).
-		 */
-		if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
-		    ACPI_GPE_DISPATCH_NONE) {
-			gpe_event_info->flags =
-			    (ACPI_GPE_DISPATCH_NOTIFY |
-			     ACPI_GPE_LEVEL_TRIGGERED);
-			gpe_event_info->dispatch.device_node = device_node;
-		}
+	if (!gpe_event_info) {
+		goto unlock_and_exit;
+	}
 
-		gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
-		status = AE_OK;
+	/*
+	 * If there is no method or handler for this GPE, then the
+	 * wake_device will be notified whenever this GPE fires (aka
+	 * "implicit notify") Note: The GPE is assumed to be
+	 * level-triggered (for windows compatibility).
+	 */
+	if (((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) ==
+	      ACPI_GPE_DISPATCH_NONE) && (wake_device != ACPI_ROOT_OBJECT)) {
+
+		/* Validate wake_device is of type Device */
+
+		device_node = ACPI_CAST_PTR(struct acpi_namespace_node,
+					    wake_device);
+		if (device_node->type != ACPI_TYPE_DEVICE) {
+			goto unlock_and_exit;
+		}
+		gpe_event_info->flags = (ACPI_GPE_DISPATCH_NOTIFY |
+					 ACPI_GPE_LEVEL_TRIGGERED);
+		gpe_event_info->dispatch.device_node = device_node;
 	}
 
+	gpe_event_info->flags |= ACPI_GPE_CAN_WAKE;
+	status = AE_OK;
+
+ unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
