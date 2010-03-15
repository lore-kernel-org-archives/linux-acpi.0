From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/34] ACPI: Disable explicit power state retrieval on fans
Date: Sun, 14 Mar 2010 21:40:43 -0400
Message-ID: <0c99c5288eb9b1bbc9684b0ec0fd7efc578749b3.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:63382 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190Ab0COBpW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:45:22 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA004NZVJLKFM5@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:45:22 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
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
1.7.0.2.201.g80978

