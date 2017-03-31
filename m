From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / scan: Prefer devices without _HID for _ADR matching
Date: Sat, 01 Apr 2017 00:45:52 +0200
Message-ID: <1609746.B4NEsK2OtA@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63664 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754594AbdCaWvh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Mar 2017 18:51:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Mike <mike@mikewilson.me.uk>, Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit c2a6bbaf0c5f (ACPI / scan: Prefer devices without _HID/_CID
for _ADR matching) added a list_empty(&adev->pnp.ids) check to
find_child_checks() so as to catch situations in which the ACPI
core attempts to decode _ADR for a device having a _HID too which
is strictly against the spec.  However, it overlooked the fact that
the adev->pnp.ids list for the devices taken into account by
find_child_checks() may contain device IDs set internally by the
kernel, like "LNXVIDEO" (thanks to Zhang Rui for that realization),
and it broke the enumeration of those devices as a result.

To unbreak it, replace the overly coarse grained list_empty()
check with a much more precise check against the pnp.type.platform_id
flag which is only set for devices having a _HID (that's how it
should be done from the start, as having both _ADR and _CID is
actually permitted).

Fixes: c2a6bbaf0c5f (ACPI / scan: Prefer devices without _HID/_CID for _ADR matching)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=194889
Reported-and-tested-by: Mike <mike@mikewilson.me.uk>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/glue.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/acpi/glue.c
===================================================================
--- linux-pm.orig/drivers/acpi/glue.c
+++ linux-pm/drivers/acpi/glue.c
@@ -99,13 +99,13 @@ static int find_child_checks(struct acpi
 		return -ENODEV;
 
 	/*
-	 * If the device has a _HID (or _CID) returning a valid ACPI/PNP
-	 * device ID, it is better to make it look less attractive here, so that
-	 * the other device with the same _ADR value (that may not have a valid
-	 * device ID) can be matched going forward.  [This means a second spec
-	 * violation in a row, so whatever we do here is best effort anyway.]
+	 * If the device has a _HID returning a valid ACPI/PNP device ID, it is
+	 * better to make it look less attractive here, so that the other device
+	 * with the same _ADR value (that may not have a valid device ID) can be
+	 * matched going forward.  [This means a second spec violation in a row,
+	 * so whatever we do here is best effort anyway.]
 	 */
-	return sta_present && list_empty(&adev->pnp.ids) ?
+	return sta_present && !adev->pnp.type.platform_id ?
 			FIND_CHILD_MAX_SCORE : FIND_CHILD_MIN_SCORE;
 }
 

