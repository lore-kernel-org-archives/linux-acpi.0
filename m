From: Len Brown <lenb@kernel.org>
Subject: [PATCH 6/6] ACPI: Disable explicit power state retrieval on fans
Date: Wed, 30 Dec 2009 02:41:22 -0500
Message-ID: <0c99c5288eb9b1bbc9684b0ec0fd7efc578749b3.1262158615.git.len.brown@intel.com>
References: <1262158882-9713-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:53076 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbZL3Hlg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 02:41:36 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVG0084LG13OMPH@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 01:41:27 -0600 (CST)
In-reply-to: <1262158882-9713-1-git-send-email-lenb@kernel.org>
In-reply-to: <4c291b9021e33aac046ee8abeb9ea8fe76086342.1262158615.git.len.brown@intel.com>
References: <4c291b9021e33aac046ee8abeb9ea8fe76086342.1262158615.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

If the ACPI power state can be got both directly and indirectly,
we prefer to get it indirectly.

https://bugzilla.redhat.com/show_bug.cgi?id=531916 describes a
system with a _PSC method for the fan that always returns "on".
There's no benefit in us always requesting the state of the fan
when performing transitions - we want to do everything we can
to ensure that the fan turns on when it should do, not risk
hardware damage by believing the hardware when it tells us the
fan is already on. Given that the Leading Other OS(tm) works fine
on this machine, it seems likely that it behaves in much this way.

inspired-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index cf761b9..ae9226d 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -190,16 +190,16 @@ int acpi_bus_get_power(acpi_handle handle, int *state)
 		 * Get the device's power state either directly (via _PSC) or
 		 * indirectly (via power resources).
 		 */
-		if (device->power.flags.explicit_get) {
+		if (device->power.flags.power_resources) {
+			result = acpi_power_get_inferred_state(device);
+			if (result)
+				return result;
+		} else if (device->power.flags.explicit_get) {
 			status = acpi_evaluate_integer(device->handle, "_PSC",
 						       NULL, &psc);
 			if (ACPI_FAILURE(status))
 				return -ENODEV;
 			device->power.state = (int)psc;
-		} else if (device->power.flags.power_resources) {
-			result = acpi_power_get_inferred_state(device);
-			if (result)
-				return result;
 		}
 
 		*state = device->power.state;
-- 
1.6.0.6

