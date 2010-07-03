From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI: Fix bogus GPE test in acpi_bus_set_run_wake_flags()
Date: Sun, 4 Jul 2010 01:31:39 +0200
Message-ID: <201007040131.39904.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:49192 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755782Ab0GCXdR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 3 Jul 2010 19:33:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux PM <linux-pm@lists.linux-foundation.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

When we check if a GPE can be used for runtime signaling, we only
search the FADT GPE blocks, which is incorrect, becuase the GPE
may be located elsewhere.  We really should be using the GPE device
information previously returned by _PRW here, so make that happen.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/scan.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -764,8 +764,9 @@ static void acpi_bus_set_run_wake_flags(
 		return;
 	}
 
-	status = acpi_get_gpe_status(NULL, device->wakeup.gpe_number,
-					&event_status);
+	status = acpi_get_gpe_status(device->wakeup.gpe_device,
+					device->wakeup.gpe_number,
+						&event_status);
 	if (status == AE_OK)
 		device->wakeup.flags.run_wake =
 				!!(event_status & ACPI_EVENT_FLAG_HANDLE);
