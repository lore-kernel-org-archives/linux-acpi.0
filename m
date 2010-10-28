From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH 3/3] ACPI / PM: Fix initial reference counting of power resources
Date: Thu, 28 Oct 2010 15:11:07 +0200
Message-ID: <201010281511.07358.rjw@sisk.pl>
References: <201010281507.34994.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:33284 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758574Ab0J1NNG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Oct 2010 09:13:06 -0400
In-Reply-To: <201010281507.34994.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

ACPI power resources are only reference counted during device power
state changes.  The initial device power states have no effect on
the reference counting of power resources.  This leads to the problem
that some power resources may be turned off too early when devices
are powered off during system suspend or via runtime PM.  Moreover,
the state of power resource reference counters after powering a
device on may be different than it had been before the device was
powered off.

To fix this issue, update power resource reference counting directly
during initialization by calling acpi_power_transition() for every
device using power resources.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/scan.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -880,8 +880,10 @@ static int acpi_bus_get_power_flags(stru
 
 	/* TBD: System wake support and resource requirements. */
 
-	device->power.state = ACPI_STATE_UNKNOWN;
-	acpi_bus_get_power(device->handle, &(device->power.state));
+	acpi_bus_get_power(device->handle, &device->power.state);
+	/* Update power resources reference counting. */
+	if (device->power.flags.power_resources)
+		acpi_power_transition(device, device->power.state);
 
 	return 0;
 }

