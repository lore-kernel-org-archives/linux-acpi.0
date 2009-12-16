From: Len Brown <lenb@kernel.org>
Subject: [PATCH 003/103] acpi: thermal: display forced passive trip points in
 proc
Date: Wed, 16 Dec 2009 03:35:14 -0500
Message-ID: <7fb2616e249184e217f9818a7662596165710ea4.1260952471.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:53994 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbZLPIhE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 03:37:04 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0067WL9P4WZO@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 02:37:02 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Frans Pop <elendil@planet.nl>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Frans Pop <elendil@planet.nl>

Users can force a passive trip point for a thermal zone that does not
have _PSV defined in ACPI by setting the passive attribute in sysfs.
It's useful to display such trip points in /proc/acpi/thermal_zone.

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

