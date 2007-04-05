From: Danny Kukawka <dkukawka@suse.de>
Subject: [PATCH] ACPI: more verbose thermal zone shutdown message
Date: Thu, 5 Apr 2007 16:15:07 +0200
Message-ID: <200704051615.07960.dkukawka@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:56793 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767004AbXDEOQS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Apr 2007 10:16:18 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi,

while debug some strange termal shutdowns I wrote this patch to get more 
information in /var/log/messages about the reason for the shutdown. I 
think this would be useful in general.

Danny

From: Danny Kukawka <dkukawka@suse.de>
Subject: ACPI: more verbose thermal zone shutdown message

add more information to acpi thermal zone shutdown message for easier
debugging

Signed-off-by: Danny Kukawka <dkukawka@suse.de>
---
 thermal.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- linux-2.6.21-rc5/drivers/acpi/thermal.c	2007-04-05 13:37:07.000000000 +0200
+++ linux-2.6.21-rc5/drivers/acpi/thermal.c	2007-04-05 16:02:03.000000000 +0200
@@ -457,14 +457,20 @@
 		return -EINVAL;
 
 	if (tz->temperature >= tz->trips.critical.temperature) {
-		printk(KERN_WARNING PREFIX "Critical trip point\n");
+		printk(KERN_WARNING PREFIX 
+		       "Critical trip point (%ld C) reached on thermal zone [%s]\n",
+		       KELVIN_TO_CELSIUS(tz->trips.critical.temperature),
+		       acpi_device_bid(tz->device)); 
 		tz->trips.critical.flags.enabled = 1;
 	} else if (tz->trips.critical.flags.enabled)
 		tz->trips.critical.flags.enabled = 0;
 
 	printk(KERN_EMERG
-	       "Critical temperature reached (%ld C), shutting down.\n",
-	       KELVIN_TO_CELSIUS(tz->temperature));
+	       "Critical temperature reached (%ld C on [%s] with trip point set to: %ld C), shutting down.\n",
+	       KELVIN_TO_CELSIUS(tz->temperature),
+	       acpi_device_bid(tz->device),
+	       KELVIN_TO_CELSIUS(tz->trips.critical.temperature));
+
 	acpi_bus_generate_event(tz->device, ACPI_THERMAL_NOTIFY_CRITICAL,
 				tz->trips.critical.flags.enabled);
 
