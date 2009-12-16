From: Len Brown <lenb@kernel.org>
Subject: [PATCH 096/103] acpi: thermal: display forced passive trip points in
 proc
Date: Wed, 16 Dec 2009 03:36:47 -0500
Message-ID: <bf2abdd79ac81c52957bf0d0d5430cec5433cfb7.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:61722 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759667AbZLPMGG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 07:06:06 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0025QUXOD4MD@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 06:05:56 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Frans Pop <elendil@planet.nl>, Matthew Garrett <mjg59@srcf.ucam.org>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Frans Pop <elendil@planet.nl>

Users can force a passive trip point for a thermal zone that does not have
_PSV defined in ACPI by setting the passive attribute in sysfs.  It's
useful to display such trip points in /proc/acpi/thermal_zone.

.../TZ1/cooling_mode:<setting not supported>
.../TZ1/polling_frequency:polling frequency:       10 seconds
.../TZ1/state:state:                   ok
.../TZ1/temperature:temperature:             53 C
.../TZ1/trip_points:critical (S5):           110 C
.../TZ1/trip_points:passive (forced):        95 C

And if not set (passive is 0):
.../TZ1/trip_points:passive (forced):<not set>

Signed-off-by: Frans Pop <elendil@planet.nl>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 65f6781..9073ada 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1052,6 +1052,13 @@ static int acpi_thermal_trip_seq_show(struct seq_file *seq, void *offset)
 				   acpi_device_bid(device));
 		}
 		seq_puts(seq, "\n");
+	} else {
+		seq_printf(seq, "passive (forced):");
+		if (tz->thermal_zone->forced_passive)
+			seq_printf(seq, "        %i C\n",
+				   tz->thermal_zone->forced_passive / 1000);
+		else
+			seq_printf(seq, "<not set>\n");
 	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-- 
1.6.0.6

