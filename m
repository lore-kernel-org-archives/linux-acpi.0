From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] acpi: bus: handle power manageable but no _PSC/_PRx case
Date: Mon, 27 Aug 2012 15:38:46 +0800
Message-ID: <1346053126-7646-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48168 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752758Ab2H0HjX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Aug 2012 03:39:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@intel.com>

Currently, when we are trying to get the power state of an acpi device,
we will do the following:
If device is not power manageable, init its power state as its parent or
if it does not have a parent, init as D0;
If device is power manageable, evaluate _PSC and then refine with
acpi_power_get_inferred_state.

But there exist some devices with _PSx defined, but no _PSC or _PRx.
It is power manageable, but the above method to get power state does
not cover this case and its power state will be UNKNOWN(255).

So change the check of power manageable to whether _PSC and _PRx
defined.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 9628652..b564e6d 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -207,7 +207,8 @@ static int __acpi_bus_get_power(struct acpi_device *device, int *state)
 	if (!device || !state)
 		return -EINVAL;
 
-	if (!device->flags.power_manageable) {
+	if (!device->power.flags.explicit_get &&
+			!device->power.flags.power_resources) {
 		/* TBD: Non-recursive algorithm for walking up hierarchy. */
 		*state = device->parent ?
 			device->parent->power.state : ACPI_STATE_D0;
-- 
1.7.12.21.g871e293

