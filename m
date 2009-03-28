From: Len Brown <lenb@kernel.org>
Subject: [PATCH 80/98] ACPI: update thermal for bus_id removal
Date: Sat, 28 Mar 2009 00:31:55 -0400
Message-ID: <f6f5c45e06e86d94621cd5c1c4508bdee1952fc8.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:35043 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042AbZC1Edr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:33:47 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700DCG8O2LGJ1@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:39 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <len.brown@intel.com>

From: Stephen Rothwell <sfr@canb.auug.org.au>

> drivers/acpi/thermal.c: In function 'thermal_notify':
> drivers/acpi/thermal.c:768: error: 'struct device' has no member named 'bus_id'
>
> Caused by commit b1569e99c795bf83b4ddf41c4f1c42761ab7f75e ("ACPI: move
> thermal trip handling to generic thermal layer") interacting with commit
> d4a078fca590911cdf87a8eaffee1b6e643c2558 ("driver core: get rid of struct
> device's bus_id string array").
>

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 0ec48d2..6b95997 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -41,6 +41,7 @@
 #include <linux/kmod.h>
 #include <linux/seq_file.h>
 #include <linux/reboot.h>
+#include <linux/device.h>
 #include <asm/uaccess.h>
 #include <linux/thermal.h>
 #include <acpi/acpi_bus.h>
@@ -765,7 +766,7 @@ static int thermal_notify(struct thermal_zone_device *thermal, int trip,
 
 	acpi_bus_generate_proc_event(tz->device, type, 1);
 	acpi_bus_generate_netlink_event(tz->device->pnp.device_class,
-					tz->device->dev.bus_id, type, 1);
+					dev_name(&tz->device->dev), type, 1);
 
 	if (trip_type == THERMAL_TRIP_CRITICAL && nocrt)
 		return 1;
-- 
1.6.0.6

